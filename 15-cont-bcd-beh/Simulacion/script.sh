#!/bin/bash

ghdl -a ../Fuentes/contBCDBeh.vhd ../Fuentes/contBCDBeh_tb.vhd
ghdl -s ../Fuentes/contBCDBeh.vhd ../Fuentes/contBCDBeh_tb.vhd
ghdl -e contBCDBeh_tb
ghdl -r contBCDBeh_tb --vcd=contBCDBeh_tb.vcd --stop-time=1100ns

gtkwave contBCDBeh_tb.vcd
