#!/bin/bash

ghdl -a ../../01-sumador-completo/Fuentes/sum1b.vhd ../Fuentes/sum4b.vhd ../Fuentes/sum4b_tb.vhd
ghdl -s ../../01-sumador-completo/Fuentes/sum1b.vhd ../Fuentes/sum4b.vhd ../Fuentes/sum4b_tb.vhd
ghdl -e sum4b_tb
ghdl -r sum4b_tb --vcd=sum4b_tb.vcd --stop-time=1100ns

gtkwave sum4b_tb.vcd
