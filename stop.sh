#!/bin/bash

filename=pid.file
pid='cat $filename'
kill $pid
cp /dev/null filename
