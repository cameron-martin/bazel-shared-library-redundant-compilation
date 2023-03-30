#!/usr/bin/env bash

# Modify lib.cpp
echo "" >> lib.cpp

bazel build //:all -c opt --generate_json_trace_profile

profile_gz=$(bazel info output_base)/command.profile.gz

temp_dir=$(mktemp -d)
trap 'rm -rf -- "$temp_dir"' EXIT

gunzip -c $profile_gz > $temp_dir/profile.json

times_compiled=$(jq '[.traceEvents[] | select(.cat == "action processing" and .name == "Compiling lib.cpp")] | length' $temp_dir/profile.json)

if [ $times_compiled == 1 ]; then
    echo "Compiled once, like we expect!"
else
    echo "Compiled $times_compiled times, this is wrong!"
    exit 1
fi