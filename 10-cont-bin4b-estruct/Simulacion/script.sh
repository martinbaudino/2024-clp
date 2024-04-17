#!/bin/bash

ghdl -a ../../05-ffd-asc-res-ena/Fuentes/ffd.vhd ../Fuentes/contBin4b.vhd ../Fuentes/contBin4b_tb.vhd
ghdl -s ../../05-ffd-asc-res-ena/Fuentes/ffd.vhd ../Fuentes/contBin4b.vhd ../Fuentes/contBin4b_tb.vhd
ghdl -e contBin4b_tb
ghdl -r contBin4b_tb --vcd=contBin4b_tb.vcd --stop-time=1100ns

gtkwave contBin4b_tb.vcd
