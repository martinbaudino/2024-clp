# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Sintesis/13-bcd1seg.cache/wt [current_project]
set_property parent.project_path C:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Sintesis/13-bcd1seg.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:arty-z7-10:part0:1.1 [current_project]
set_property ip_output_repo c:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Sintesis/13-bcd1seg.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/pd/2024-CLP/01_guia_vhdl/15-cont-bcd-beh/Fuentes/contBCDBeh.vhd
  C:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Fuentes/contBCD_Lento.vhd
  C:/pd/2024-CLP/01_guia_vhdl/17-gen-enable/Fuentes/genEna.vhd
  C:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Sintesis/13-bcd1seg.srcs/sources_1/new/contBCD_VIO.vhd
}
read_ip -quiet C:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Sintesis/13-bcd1seg.srcs/sources_1/ip/vio_0/vio_0.xci
set_property used_in_implementation false [get_files -all c:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Sintesis/13-bcd1seg.srcs/sources_1/ip/vio_0/vio_0.xdc]
set_property used_in_implementation false [get_files -all c:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Sintesis/13-bcd1seg.srcs/sources_1/ip/vio_0/vio_0_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Fuentes/Arty-Z7-10-Master.xdc
set_property used_in_implementation false [get_files C:/pd/2024-CLP/01_guia_vhdl/18-cont-bcd-enable-sint/Fuentes/Arty-Z7-10-Master.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top contBCD_VIO -part xc7z010clg400-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef contBCD_VIO.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file contBCD_VIO_utilization_synth.rpt -pb contBCD_VIO_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
