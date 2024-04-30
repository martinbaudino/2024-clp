#!/bin/bash

ghdl -a --std=08 ../Fuentes/tipo_punto_flotante_pkg.vhd ../Fuentes/mult_flotante_pkg.vhd ../Fuentes/mult_flotante_pkg_tb.vhd
ghdl -s --std=08 ../Fuentes/tipo_punto_flotante_pkg.vhd ../Fuentes/mult_flotante_pkg.vhd ../Fuentes/mult_flotante_pkg_tb.vhd
ghdl -e --std=08 mult_flotante_pkg_tb
ghdl -r --std=08 mult_flotante_pkg_tb --vcd=mult_flotante_pkg_tb.vcd --stop-time=7100ns

gtkwave mult_flotante_pkg_tb.vcd
