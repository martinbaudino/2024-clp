#!/bin/bash

ghdl -a ../../15-cont-bcd-beh/Fuentes/contBCDBeh.vhd ../../17-gen-enable/Fuentes/genEna.vhd ../Fuentes/contBCD_Lento.vhd ../Fuentes/contBCD_Lento_tb.vhd
ghdl -s ../../15-cont-bcd-beh/Fuentes/contBCDBeh.vhd ../../17-gen-enable/Fuentes/genEna.vhd ../Fuentes/contBCD_Lento.vhd ../Fuentes/contBCD_Lento_tb.vhd
ghdl -e contBCD_Lento_tb
ghdl -r contBCD_Lento_tb --vcd=contBCD_Lento_tb.vcd --stop-time=7100ns

gtkwave contBCD_Lento_tb.vcd
