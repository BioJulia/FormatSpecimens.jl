module FormatSpecimens

export
    list_all_specimens,
    list_valid_specimens,
    list_invalid_specimens,
    hastags,
    hastag,
    tags,
    hasorigin,
    origin,
    hascomments,
    comments,
    filename,
    path_of_format
    
using TOML

path_of_format(fmt::String) = joinpath(dirname(dirname(@__FILE__)), fmt)

function read_all_specimens(fmt::String)
    folder = path_of_format(fmt)
    all_specimens = TOML.parse(open(joinpath(folder, "index.toml"), "r"))
end

function list_all_specimens(fmt::String)
    all_specimens = read_all_specimens(fmt)
    return vcat(get(all_specimens, "valid", Dict{String, Any}[]), get(all_specimens, "invalid", Dict{String, Any}[]))
end

function list_all_specimens(fn::Function, fmt::String)
    specimens = list_all_specimens(fmt)
    filter!(fn, specimens)
    return specimens
end

function list_valid_specimens(fmt::String)
    all_specimens = read_all_specimens(fmt)
    return get(all_specimens, "valid", Dict{String, Any}[])
end

function list_valid_specimens(fn::Function, fmt::String)
    specimens = list_valid_specimens(fmt)
    filter!(fn, specimens)
    return specimens
end

function list_invalid_specimens(fmt::String)
    all_specimens = read_all_specimens(fmt)
    return get(all_specimens, "invalid", Dict{String, Any}[])
end

function list_invalid_specimens(fn::Function, fmt::String)
    specimens = list_invalid_specimens(fmt)
    filter!(fn, specimens)
    return specimens
end

# Tag operations
hastags(entry) = haskey(entry, "tags")
hastag(entry, tag) = hastags(entry) && tag in entry["tags"] ? true : false

function tags(entry)::Vector{String}
    hastags(entry) || throw(ArgumentError("Index entry has no tags"))
    return entry["tags"]
end

# Origin operations
hasorigin(entry) = haskey(entry, "origin")
hasorigin(entry, origin) = hasorigin(entry) && entry["origin"] == origin ? true : false

function origin(entry)::String
    hasorigin(entry) || throw(ArgumentError("Index entry has no origin"))
    return entry["origin"]
end

# Comments operations
hascomments(entry) = haskey(entry, "comments")

function comments(entry)::Vector{String}
    hascomments(entry) || throw(ArgumentError("Index entry has no comments"))
    return entry["comments"]
end

# Filename operations
function filename(entry)::String
    haskey(entry, "filename") || throw(ArgumentError("Index entry has no filename"))
    return entry["filename"]
end


end # module
