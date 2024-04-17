#!/bin/bash

ghdl -a ../Fuentes/genEna.vhd ../Fuentes/genEna_tb.vhd
ghdl -s ../Fuentes/genEna.vhd ../Fuentes/genEna_tb.vhd
ghdl -e genEna_tb
ghdl -r genEna_tb --vcd=genEna_tb.vcd --stop-time=1100ns

gtkwave genEna_tb.vcd
