#!/bin/bash

ghdl -a ../../01-sumador-completo/Fuentes/sum1b.vhd ../../02-sum-4bits-estruct/Fuentes/sum4b.vhd ../Fuentes/sumrest4b.vhd ../Fuentes/sumrest4b_tb.vhd
ghdl -s ../../01-sumador-completo/Fuentes/sum1b.vhd ../../02-sum-4bits-estruct/Fuentes/sum4b.vhd ../Fuentes/sumrest4b.vhd ../Fuentes/sumrest4b_tb.vhd
ghdl -e sumrest4b_tb
ghdl -r sumrest4b_tb --vcd=sumrest4b_tb.vcd --stop-time=1100ns

gtkwave sumrest4b_tb.vcd
