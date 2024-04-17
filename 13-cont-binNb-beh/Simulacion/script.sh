#!/bin/bash

ghdl -a ../Fuentes/contBinNbBeh.vhd ../Fuentes/contBinNbBeh_tb.vhd
ghdl -s ../Fuentes/contBinNbBeh.vhd ../Fuentes/contBinNbBeh_tb.vhd
ghdl -e contBinNbBeh_tb
ghdl -r contBinNbBeh_tb --vcd=contBinNbBeh_tb.vcd --stop-time=1100ns

gtkwave contBinNbBeh_tb.vcd
