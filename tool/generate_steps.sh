#!/bin/bash

if [[ ! -z $(git status -s) ]]; then
  git status
  echo Error: You need a clean git working tree before running this command.
  exit 1
fi

for cur in `seq 0 5`;
do
  echo Downloading step_$cur...
  rm -rf step_$cur
  git clone --depth=1 --branch=step_$cur git@github.com:flutter/codelab_steps.git step_$cur
  rm -rf step_$cur/.git
done
