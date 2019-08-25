#!/bin/sh
vlib work
vmap work work
vlog ../src/pic2wave.sv
vsim -c -do run.do -novopt work.PIC2WAVE
gtkwave -f wave.vcd
