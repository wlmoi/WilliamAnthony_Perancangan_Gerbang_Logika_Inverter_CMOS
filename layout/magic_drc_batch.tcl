path search +layout
load Inverter

select top cell
drc check
set drc_count [drc count total]
if {$drc_count eq ""} {
	set drc_count 0
}

set report [open "layout/drc_report.txt" "w"]
puts $report "DRC Batch Report"
puts $report "================"
puts $report "Tool   : Magic"
puts $report "Tech   : GF180MCU"
puts $report "Topcell: Inverter"
puts $report "Violations: $drc_count"
close $report

quit -noprompt
