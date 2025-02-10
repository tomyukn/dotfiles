"""
    subtypetree(f, roottype; level=1, indent=4)

Display the entire type hierarchy starting from the specified `roottype`.
Apply `f` to each types.
"""
function subtypetree(f, roottype; level=1, indent=4)
    amark = isabstracttype(roottype) ? "*" : ""
    level == 1 && println(f(roottype), amark)

    for t in subtypes(roottype)
        amark = isabstracttype(t) ? "*" : ""
        println(join(fill(" ", level * indent)), string(f(t)), amark)
        subtypetree(f, t, level=level + 1, indent=indent)
    end
end

"""
    subtypetree(roottype; level=1, indent=4)

Display the entire type hierarchy starting from the specified `roottype`.
"""
subtypetree(roottype; level=1, indent=4) =
    subtypetree(identity, roottype; level=level, indent=indent)


# Using Revise by default
try
    @eval using Revise
catch e
    @warn "Error initializing Revise" exception = (e, catch_backtrace())
end

