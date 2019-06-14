#
# Copyright (c) 2019, Jeff Parent. All rights reserved.
# Licensed under the BSD 3-Cluase License. See LICENSE file in this project for full license information.
#
package provide app-csv_split 1.0
package require cmdline

set options {
  {no-header "file does not have header"}
  {dest.arg -1 "set destination location"}
}

set usage ": csv_split \[options] <max-line-count> <file-name>"

try {
  array set arg [cmdline::getoptions argv $options $usage]
} trap {CMDLINE USAGE} {msg o} {
  puts $msg
  exit 1
}

if { [llength $argv] != 2 } {
  cmdline::usage $options $usage
  puts "ERROR$usage"
  exit 1
}

set max_line_count [lindex $argv 0]
set file_name [lindex $argv 1]

if {[file exists $file_name] == 0 } {
  puts "ERROR: File not found"
  exit 2
}

set working_dir [file dirname $file_name]
set working_file [lindex [file split $file_name] end]
set read_line_number 0
set out_file_number 0
set out_file 0

puts "splitting $out_file_number"
set in_file [open $file_name r]
while  {[gets $in_file line] >= 0} {

  if {$out_file == 0} {
    set out_dir [file join $working_dir "[file rootname $working_file].d"]
    if {$arg(dest) != -1} {
      set out_dir $arg(dest)
    }
    file mkdir $out_dir
    set out_file [open [file join $out_dir "[file rootname $working_file]-$out_file_number[file extension $working_file]"] w]

    if {$arg(no-header) == 0} {
      if {[info exists header] == 0} {
        set header $line
      } else {
        puts $out_file $header
        incr read_line_number
      }
    }
  }

  puts $out_file $line
  incr read_line_number

  if {$read_line_number >= $max_line_count} {
    set read_line_number 0
    incr out_file_number
    close $out_file
    set out_file 0
    puts "splitting $out_file_number"
  }
}

close $in_file
