set pdk_root "$::env(HOME)/.volare"
set pdk_setup "$pdk_root/gf180mcuA/libs.tech/netgen/gf180mcuA_setup.tcl"
set sch_netlist "xschem/inverter_sch.spice"
set lay_netlist "layout/inverter_layout.spice"
set report_file "lvs/lvs_report.log"

if {![file exists $pdk_setup]} {
    puts "ERROR: PDK setup tidak ditemukan: $pdk_setup"
    quit
}
if {![file exists $sch_netlist]} {
    puts "ERROR: Schematic netlist tidak ditemukan: $sch_netlist"
    quit
}
if {![file exists $lay_netlist]} {
    puts "ERROR: Layout netlist tidak ditemukan: $lay_netlist"
    quit
}

lvs "$lay_netlist inverter" "$sch_netlist inverter" $pdk_setup $report_file
puts "LVS done. Report: $report_file"
quit
