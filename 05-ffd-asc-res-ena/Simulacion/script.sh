#!/bin/bash

ghdl -a ../Fuentes/ffd.vhd ../Fuentes/ffd_tb.vhd
ghdl -s ../Fuentes/ffd.vhd ../Fuentes/ffd_tb.vhd
ghdl -e ffd_tb
ghdl -r ffd_tb --vcd=ffd_tb.vcd --stop-time=1100ns

gtkwave ffd_tb.vcd
