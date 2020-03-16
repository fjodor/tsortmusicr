# tsortmusicr
Functions to work with data from https://tsort.info/ - The World's Music Charts

Work in progress! Not a finished package! Functions and function names are likely to change in future versions. 

Currently implemented:

## Functions to read data from https://tsort.info

* tsm_read_songs(): Wrapper around readr::read_csv to read Top 5000 songs from tsort.info, with convenient defaults (url, file name, NA coding).
* tsm_read_albums(): Wrapper around readr::read_csv to read Top 3000 albums from tsort.info, with convenient defaults.
* tsm_read_chart(): Wrapper around readr::read_csv to read full chart data from tsort.info, with convenient defaults.
* tsm_get_version(): Function to find out current file version.

## Data frames

Note that usage of data from tsort.info is free under the following conditions:

1. Acknowledge the source.

2. Prominently link to https://tsort.info

3. Always include version number.

Data frames that ship with the package:

* songs: Top 5000 Songs from tsort.info, 9 variables, version 2-8-0025.
* albums: Top 3000 Albums from tsort.info, 9 variables, version 2-8-0025.
* chart: Full data from tsort.info, 71141 rows, 17 variables, version 2-8-0025.


## Plotting function

* tsm_ggbox(): ggplot2 boxplot additionally showing original data points using a slightly customized theme.
