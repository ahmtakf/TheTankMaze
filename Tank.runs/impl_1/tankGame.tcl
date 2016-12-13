proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/Electricity/Desktop/TankLast/Tank.cache/wt [current_project]
  set_property parent.project_path C:/Users/Electricity/Desktop/TankLast/Tank.xpr [current_project]
  set_property ip_cache_permissions disable [current_project]
  add_files -quiet C:/Users/Electricity/Desktop/TankLast/Tank.runs/synth_1/tankGame.dcp
  read_xdc C:/Users/Electricity/Desktop/TankLast/Tank.srcs/constrs_1/new/game.xdc
  link_design -top tankGame -part xc7a35ticpg236-1L
  write_hwdef -file tankGame.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force tankGame_opt.dcp
  report_drc -file tankGame_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force tankGame_placed.dcp
  report_io -file tankGame_io_placed.rpt
  report_utilization -file tankGame_utilization_placed.rpt -pb tankGame_utilization_placed.pb
  report_control_sets -verbose -file tankGame_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force tankGame_routed.dcp
  report_drc -file tankGame_drc_routed.rpt -pb tankGame_drc_routed.pb -rpx tankGame_drc_routed.rpx
  report_methodology -file tankGame_methodology_drc_routed.rpt -rpx tankGame_methodology_drc_routed.rpx
  report_timing_summary -warn_on_violation -max_paths 10 -file tankGame_timing_summary_routed.rpt -rpx tankGame_timing_summary_routed.rpx
  report_power -file tankGame_power_routed.rpt -pb tankGame_power_summary_routed.pb -rpx tankGame_power_routed.rpx
  report_route_status -file tankGame_route_status.rpt -pb tankGame_route_status.pb
  report_clock_utilization -file tankGame_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force tankGame_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force tankGame.mmi }
  write_bitstream -force -no_partial_bitfile tankGame.bit 
  catch { write_sysdef -hwdef tankGame.hwdef -bitfile tankGame.bit -meminfo tankGame.mmi -file tankGame.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

