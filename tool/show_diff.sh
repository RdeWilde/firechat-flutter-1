#!/bin/bash

for cur in `seq 1 7`;
do
  prev=$(($cur-1))
  echo ================= $prev...$cur =====================
  diff step_$prev/lib/main.dart step_$cur/lib/main.dart
done
