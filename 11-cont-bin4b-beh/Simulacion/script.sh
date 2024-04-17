#!/bin/bash

ghdl -a ../Fuentes/contBin4bBeh.vhd ../Fuentes/contBin4bBeh_tb.vhd
ghdl -s ../Fuentes/contBin4bBeh.vhd ../Fuentes/contBin4bBeh_tb.vhd
ghdl -e contBin4bBeh_tb
ghdl -r contBin4bBeh_tb --vcd=contBin4bBeh_tb.vcd --stop-time=1100ns

gtkwave contBin4bBeh_tb.vcd
