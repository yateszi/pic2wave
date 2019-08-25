#!/bin/sh
cd ../tools
python2 py_kmeans.py -i ./hust.jpg -c 4
cd ../run
vlib work
vmap work work
vlog ../src/pic2wave.sv
vsim -c -do run.do -novopt work.PIC2WAVE
gtkwave -f wave.vcd

