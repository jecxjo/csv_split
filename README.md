# csv_split - Split a csv file into multiple csv files

## Build

Code is written in tcl, and can be built into a starkpack. The build processes requires sdx and tclkit.

    $ SDX=$(which sdx) TCLKIT=$(which tclkit) ./do

The variables `SDX` and `TCLKIT` are optional, set them to the kit for the platform you wish you build.

## Run

    $ wc -l data.csv
      22 data.csv
    $ csv_split 10 data.csv
    $ ls data.d
      data-0.csv data-1.csv data-2.csv

## Credits

`cmdline` is part of tcllib1.19. See `lib/cmdline/license.terms` for license information.
