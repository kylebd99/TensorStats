
module TStats

using Finch
using AutoHashEquals
using DataStructures: counter, inc!
using IterTools: subsets

IndexExpr=Symbol
# This defines the list of access protocols allowed by the Finch API
@enum AccessProtocol t_walk = 1 t_lead = 2 t_follow = 3 t_gallop = 4 t_default = 5
# A subset of the allowed level formats provided by the Finch API
@enum LevelFormat t_sparse_list = 1 t_dense = 2 t_hash = 3 t_bytemap = 4 t_undef = 5


include("algebra.jl")
include("tensor-stats.jl")
include("propagate-stats.jl")

DC = DegreeConstraint

export DCStats, DC,  DegreeConstraint, NaiveStats, TensorDef
export estimate_nnz, condense_stats!
export reduce_tensor_stats, merge_tensor_stats


end