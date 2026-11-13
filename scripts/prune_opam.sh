#!/bin/bash
# prune_opam.sh - prune opam of everything not needed to run liquidsoap
cd /home/radio/.opam/
echo "Starting prune..."
rm -rf download-cache repo
cd default
# dont need lib, all linked in.
rm -rf .opam-switch doc man lib
# remove compiler, and associated, leaving LS.
( cd bin && find \! -name liquidsoap -delete )
echo "Done"
