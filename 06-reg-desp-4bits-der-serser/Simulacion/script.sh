#!/bin/bash

ghdl -a ../../05-ffd-asc-res-ena/Fuentes/ffd.vhd ../Fuentes/reg4bits.vhd ../Fuentes/reg4bits_tb.vhd
ghdl -s ../../05-ffd-asc-res-ena/Fuentes/ffd.vhd ../Fuentes/reg4bits.vhd ../Fuentes/reg4bits_tb.vhd
ghdl -e reg4bits_tb
ghdl -r reg4bits_tb --vcd=reg4bits_tb.vcd --stop-time=1100ns

gtkwave reg4bits_tb.vcd
