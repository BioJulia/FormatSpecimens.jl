# <img src="./sticker.svg" width="30%" align="right" /> FormatSpecimens

[![Latest Release](https://img.shields.io/github/release/BioJulia/FormatSpecimens.jl.svg)](https://github.com/BioJulia/FormatSpecimens.jl/releases/latest)
[![Pkg Status](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Chat](https://img.shields.io/gitter/room/BioJulia/FormatSpecimens.jl.svg)](https://gitter.im/BioJulia/FormatSpecimens.jl)

Bioinformatics is rife with formats and parsers for those formats. 

These parsers don't always agree on the definitions of these formats, since many
lack any sort of formal standard.

This repository aims to consolidate a collection of format specimens, forming a
unified file set for testing software. Testing against the same cases is a first
step towards agreeing on the details and edge cases of a format.

Unlike its predecessor [BioFmtSpeciments](https://github.com/BioJulia/BioFmtSpecimens),
FormatSpecimens is version controlled and released to a julia package registry,
and features a small julia module to assist in unit-testing.

# Install

FormatSpecimens is built primarily for [BioJulia](https://biojulia.net), and is
maintained with compatibility with the BioJulia ecosystem of tools, and BioJulia
developers in mind. FormatSpecimens is made available to install through BioJulia's
package registry.

Julia by default only watches the "General" package registry, so before you
start, you should add the BioJulia package registry.

Start a julia terminal, hit the `]` key to enter pkg mode (you should see the
prompt change from `julia> ` to `pkg> `), then enter the following command:

```julia
registry add https://github.com/BioJulia/BioJuliaRegistry.git
```

After you've added the registry, you can install FormatSpecimens from the julia
REPL. Press `]` to enter pkg mode again, and enter the following:

```julia
add FormatSpecimens
```


# Organization

This repository consists of a directory for every major format. Directories
contain format specimens along with a file `index.toml`. This is a
[TOML](https://github.com/toml-lang/toml) document.
This `index.toml` contains two arrays, called `valid`, and `invalid`. All the 
index records for specimen files that are considered valid (i.e. conform to the
format definition) are found in this array.
All the index records for specimen files that are considered invalid (i.e.
violate the format definition in some way) are found in the `invalid` array.

Every entry in the `valid` and `invalid` arrays have the following fields:

  * **filename** Specimen filename (required).
  * **origin** (Optional) The contributor or source from which a specimen was taken.
  * **tags** (Optional) One or more words used to group specimens by shared features.
  * **comments** (Optional) Any additional information that might be of
    interest.
    
Really the only field absolutely required to retrieve a file using the 
`FormatSpecimens` julia module is filename, but the other fields are useful to
manipulate lists of specimen files in your unit tests.


# Julia Module

To get a list of all valid or invalid file specimens for a given format, you
can do the following:

```julia
using FormatSpecimens
goodfiles = list_valid_specimens("FASTQ")
badfiles = list_invalid_specimens("FASTQ")
```

You can test if a specimen in the list has a given tag, or get an attribute
like so:

```julia
# Test if the first entry in the list of goodfiles has the tag "dna" in it's

# list of tags... 
hastag(goodfiles[1], "dna")

# Get the comments associated with an entry:
comments(goodfiles[1])

# Get the full path of a file in the entry:
fp = joinpath(path_of_format("FASTQ"), filename(entry))
```

You can also use do notation in order to filter the records e.g. to list all the
valid FASTA files that are of a DNA sequence you can filter by tag:

```julia
gooddnafiles = list_valid_specimens("FASTA") do x
    hastag(x, "dna")
end
```