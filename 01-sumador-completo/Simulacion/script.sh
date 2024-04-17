#!/bin/bash

ghdl -a ../Fuentes/sum1b.vhd ../Fuentes/sum1b_tb.vhd
ghdl -s ../Fuentes/sum1b.vhd ../Fuentes/sum1b_tb.vhd
ghdl -e sum1b_tb
ghdl -r sum1b_tb --vcd=sum1b_tb.vcd --stop-time=1100ns

gtkwave sum1b_tb.vcd
