#!/bin/bash

ghdl -a ../Fuentes/mux.vhd ../Fuentes/mux_tb.vhd
ghdl -s ../Fuentes/mux.vhd ../Fuentes/mux_tb.vhd
ghdl -e mux_tb
ghdl -r mux_tb --vcd=mux_tb.vcd --stop-time=1100ns

gtkwave mux_tb.vcd
