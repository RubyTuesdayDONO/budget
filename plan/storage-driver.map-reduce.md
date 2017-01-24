# Storage Driver: Map-Reduce Optimizations #

In order to help optimize operation of storage drivers
to support distributed operations such as map-reduce,
transactional storage operations such as consolidation
and deduplication will be canonically defined in terms
of algoriths composed of discrete sub-steps that can
succeed or fail individually, and potentially resumed
in the event of failure or deferral.

In particular, the use of two-phase commit contracts
in certain operations will enhance the availability of
concurrency because metadata in branch nodes will
include a record of completed consolidation attempts,
averting repeated consolidations; and that same
internal commit history can drive parallel garbage
collection operations of consolidated leaf nodes.

To align the operation of consolidation and node
pruning with the data structures they'll manipulate
(primarily large collections of transactional data),
the commit history of a branch node's consolidation
metadata will be summararizable by slotted
hierarchical sharding keys.  For example, if a branch
node's nested sharding key is 1/2, then leaf node
transactions 1, 2, 3 and 7, 8, 9 under that branch
node could be summarized, once consolidated, into two
bounded summary segments [1,3] and [7,9], because the
sharding keys are "slotted" like integers, with no
interim keys between those discrete values.

Once a summary segment fully encloses the entire range
of a sub-node (whether a branch or leaf), then the
consolidation is complete, and the corresponding
sub-node may be finalized.  For consolidation
operations that aggregate data, such as Sum, Mean,
Min, Max, Median (or other statistical summarization
functions), this will typically mean deleting the
child node.  For consolidation operations that retain
details of leaf nodes, such as deduplication,
validation, sanatization, or other functions
generalizable as visitation functors, the leaf node
may be left intact under the sharding tree, and the
summary record in the branch node's consolidation
metadata will serve to dequeue it from further
(redundant) processing.

Abstracted further, the branch nodes' consolidation
summaries may include embedded details of leaf nodes
as a means of moving them through the tree, e.g.  in
support of sorting operations, or to support merging
of duplicated data without searching the entire tree
recursively for each iterated primary record.  To
accomplish this, consolidation operations should be
matched with reciprocal projection operations, which
push down a consolidation summary from a branch node
into a new leaf node.  In sorting operations, this
would pull up leaf nodes into successively shallower
branch nodes until it reaches a parent of its
canonical collation key.  Then, after any outstanding
consolidation operations have been applied to a branch
node to pull up mis-sorted child nodes (whether branch
or leaf), a projection operation would push any
details carried in the consolidation summary down
under shard paths corresponding with their canonical
collation key.

To support data merge in deduplication operations,

nodes will be comparable by hashing their contents.

a node's structure will consist of perspectives
describing the node:
* node
  * data
  * path
  * meta
  * proc

Nodes constitute the minimal transactional quantum of
storage operations.  Nodes contain two key attributes:
data segments and path locators for the node.  Path
locators form a hierarchical tree (directed acyclic
graph) such that nodes may designate or be inferred to
relate to other nodes based on their own paths.  For
example, if a node's path is `a/b/c`, it may be
inferred to have a child relationship with a node at
path `a/b`.  Reciprocally, a node with path `a/b` may
be inferred to have a parent relationship with nodes
`a/b/1` and `a/b/2`.

## Core Node-Tree Transform Operations ##

The core operations used to transform a collection of
nodes fall within two categories: those that change
the contents of the node, and those that change the
collection of nodes itself.  Specifically, operations
that create, alter, or delete the data segments within
a node; and operations that create, alter, or delete
nodes themselves.

### Data-Segment Operations ###

A Node's data segments consist of a key and a value.
The Create operation creates new data segments by
adding new key-value tuples to the node's data-segment
collection.  Because data segment keys must be
distinct within a node, create operations that attempt
to create duplicate keys will either fail, or replace
the duplicate key; indeed, the Alter operation may be
implemented in terms of the Create operation, by
"creating" a data segment with the same key as an
existing segment.  The Delete operation removes
segments with the named key from the collection.

### Node Operations ###

A tree's node collection consists of nodes keyed by
their path locators.  Because nodes' paths must be
distinct within the tree, create operations for
duplicate path locators will replace existing nodes at
the same path.  As with data segments, nodes may be
<lost train of thought>

Once a branch node's summary segments are fully
consolidated
