#!/bin/bash

ghdl -a ../../15-cont-bcd-beh/Fuentes/contBCDBeh.vhd ../Fuentes/contBCD4dig.vhd ../Fuentes/contBCD4dig_tb.vhd
ghdl -s ../../15-cont-bcd-beh/Fuentes/contBCDBeh.vhd ../Fuentes/contBCD4dig.vhd ../Fuentes/contBCD4dig_tb.vhd
ghdl -e contBCD4dig_tb
ghdl -r contBCD4dig_tb --vcd=contBCD4dig_tb.vcd --stop-time=45100ns

gtkwave contBCD4dig_tb.vcd
