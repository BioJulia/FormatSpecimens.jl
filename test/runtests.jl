using Test
using FormatSpecimens

@testset "FormatSpecimens" begin

@testset "Parse" begin

    path = joinpath(@__DIR__, "..")

    exclusions = [".git", "src", "test", "juliamnt"]

    formats = filter(str -> isdir(joinpath(path, str)) && !in(str, exclusions), readdir(path))

    for format in formats
        @info "Parsing:" format
        @test_nowarn FormatSpecimens.read_all_specimens(format)
    end

end #testest Parse

end #testest FormatSpecimens
