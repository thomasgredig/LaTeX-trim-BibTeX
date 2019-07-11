# LaTeX-trim-BibTeX

Utility to trim a BibTeX file down to the essential references. It first scans the latex files for references used, then loads the bibtex file and writes a new file with only the used references.


## Installation

Create and configure the file `myConfig.R`.

## Usage

Run `main.R`.

## Find Figures

The `main-findFigures.R` utility runs through `path.source` and finds all TeX files, then searches for figures and creates an output file with the file location path. The output file is stored in the `path.source` folder.


## To Do

Run through all AUX files, currently only searches main.aux.