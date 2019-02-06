# Bioinformatics Format Specimens

Bioinformatics is rife with formats and parsers for those formats. These parsers
don't always agree on the definitions of these formats, since many lack any sort
of formal standard.

This repository aims to consolidate a collection of format specimens to create a
unified set of data with which to test software against. Testing against the
same cases is a first step towards agreeing on the details and edge cases of a
format.

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