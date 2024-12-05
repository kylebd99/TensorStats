using TStats

# Let A be a diagonal matri0
stat_a = DCStats(TensorDef(Set([:i, :j]), Dict(:i=>100, :j=>100), 0, nothing, nothing, nothing),
                  Set([DC(Set(), Set([:i, :j]), 100^2),
                       DC(Set([:i]), Set([:j]), 1),
                       DC(Set([:j]), Set([:i]), 1),
                       DC(Set(), Set([:i]), 100),
                       DC(Set(), Set([:j]), 100),
                  ]))

# Let B be a sparse block matri0
stat_b = DCStats(TensorDef(Set([:i, :j, :ei0, :ei1, :ej0, :ej1]), Dict(:i=>100, :j=>100, :ei0=>10, :ei1=>10, :ej0=>10, :ej1=>10), 0, nothing, nothing, nothing),
                  Set([ DC(Set(), Set([:i, :j]), 5000),
                        DC(Set([:ei0, :ei1]), Set([:i]), 1),
                        DC(Set([:ej0, :ej1]), Set([:j]), 1),
                        DC(Set([:ei0]), Set([:ej0]), 2),
                        DC(Set([:ej0]), Set([:ei0]), 2),
                        DC(Set(), Set([:i]),100),
                        DC(Set(), Set([:j]),100),
                        DC(Set(), Set([:ei0]), 10),
                        DC(Set(), Set([:ej0]), 10),
                        DC(Set(), Set([:ei1]), 10),
                        DC(Set(), Set([:ej1]), 10),
                  ]))


# Let C be a sparse block matri0
stat_c = DCStats(TensorDef(Set([:k, :j, :ej0, :ej1, :ek0, :ek1]), Dict(:j=>100, :k=>100, :ej0=>10, :ej1=>10, :ek0=>10, :ek1=>10), 0, nothing, nothing, nothing),
                    Set([ DC(Set(), Set([:k, :j]), 5000),
                        DC(Set([:ek0, :ek1]), Set([:k]), 1),
                        DC(Set([:ej0, :ej1]), Set([:j]), 1),
                        DC(Set([:ei0]), Set([:ej0]), 2),
                        DC(Set([:ej0]), Set([:ek0]), 2),
                        DC(Set(), Set([:k]), 100),
                        DC(Set(), Set([:j]), 100),
                        DC(Set(), Set([:ek0]), 10),
                        DC(Set(), Set([:ej0]), 10),
                        DC(Set(), Set([:ek1]), 10),
                        DC(Set(), Set([:ej1]), 10),
                    ]))


# Let D_ijk = A_ij*C_jk
stat_d = merge_tensor_stats(*, stat_a, stat_c)
println("nnz(D) = $(estimate_nnz(stat_d))")
stat_d2 = reduce_tensor_stats(+, Set([:ej0, :ej1, :ek0, :ek1, :j]), stat_d)
println("nnz(D2) = $(estimate_nnz(stat_d2))")

# Let E_ijk = B_ij*C_jk
stat_e = merge_tensor_stats(*, stat_b, stat_c)
println("nnz(E) = $(estimate_nnz(stat_e))")
stat_e2 = reduce_tensor_stats(+, Set([:ei0, :ei1, :ej0, :ej1, :ek0, :ek1, :j]), stat_e)
println("nnz(E2) = $(estimate_nnz(stat_e2))")

# Let F_ik = D2_ik + E2_ik 
stat_f =  merge_tensor_stats(+, stat_d2, stat_e2)
println("nnz(F) = $(estimate_nnz(stat_f))")
