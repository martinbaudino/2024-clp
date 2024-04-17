#!/bin/bash

ghdl -a ../Fuentes/barrelsh.vhd ../Fuentes/barrelsh_tb.vhd
ghdl -s ../Fuentes/barrelsh.vhd ../Fuentes/barrelsh_tb.vhd
ghdl -e barrelsh_tb
ghdl -r barrelsh_tb --vcd=barrelsh_tb.vcd --stop-time=1100ns

gtkwave barrelsh_tb.vcd
