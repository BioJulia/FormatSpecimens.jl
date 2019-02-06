module FormatSpecimens

export
    list_all_specimens,
    list_valid_specimens,
    list_invalid_specimens,
    hastags,
    hastag,
    gettags,
    hasorigin,
    getorigin,
    hascomments,
    getcomments
    

using Pkg.TOML

function read_all_specimens(fmt::String)
    folder = joinpath(dirname(dirname(@__FILE__)), fmt)
    all_specimens = TOML.parse(open(joinpath(folder, "index.toml"), "r"))
end

function list_all_specimens(fmt::String)
    all_specimens = read_all_specimens(read_all_specimens)
    return vcat(all_specimens["valid"], all_specimens["invalid"])
end

function list_valid_specimens(fmt::String)
    all_specimens = read_all_specimens(fmt)
    return get(all_specimens, "valid", Dict{String, Any}[])
end

function list_invalid_specimens(fmt::String)
    all_specimens = read_all_specimens(fmt)
    return get(all_specimens, "invalid", Dict{String, Any}[])
end

# Tag operations
hastags(entry) = haskey(entry, "tags")
hastag(entry, tag) = hastags(entry) && tag in entry["tags"] ? true : false

function gettags(entry)
    hastags(entry) || throw(ArgumentError("Index entry has no tags"))
    return entry["tags"]
end

# Origin operations
hasorigin(entry) = haskey(entry, "origin")
hasorigin(entry, origin) = hasorigin(entry) && entry["origin"] == origin ? true : false

function getorigin(entry)
    hasorigin(entry) || throw(ArgumentError("Index entry has no origin"))
    return entry["origin"]
end

# Comments operations
hascomments(entry) = haskey(entry, "comments")

function getcomments(entry)
    hascomments(entry) || throw(ArgumentError("Index entry has no comments"))
    return entry["comments"]
end


end # module