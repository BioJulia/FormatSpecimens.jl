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

