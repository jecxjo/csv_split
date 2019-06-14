redo-ifchange csv_split.tcl lib/cmdline/cmdline.tcl lib/cmdline/pkgIndex.tcl

SDX=${SDX:-$(which sdx)}
TCLKIT=${TCLKIT:-$(which tclkit)}

if [ ! -e ${SDX} ]
then
  (>&2 echo "ERROR: sdx not installed")
  exit 1
fi

if [ ! -e ${TCLKIT} ]
then
  (>&2 echo "ERROR: tclkit not installed")
  exit 1
fi

{
  if [ -d csv_split.vfs ]
  then
    rm -rf csv_split.vfs
  fi
  ${SDX} qwrap csv_split.tcl
  ${SDX} unwrap csv_split.kit
  mkdir -p csv_split.vfs/lib/cmdline/
  cp -v LICENSE README.md csv_split.vfs/
  cp -v lib/cmdline/* csv_split.vfs/lib/cmdline/
  ${SDX} wrap $3 -vfs csv_split.vfs -runtime ${TCLKIT}
} >&2
