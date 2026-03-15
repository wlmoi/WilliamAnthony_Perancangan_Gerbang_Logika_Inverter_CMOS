# Panduan Menjalankan LVS (Netgen)

Nama: William Anthony  
NIM: 13223048

## Prasyarat
- Netgen terpasang
- PDK GF180MCU terpasang
- Variabel `PDK_ROOT` terdefinisi
- File tersedia:
  - `xschem/inverter_sch.spice`
  - `layout/inverter_layout.spice`

## Jalankan
Dari root proyek:

```bash
netgen -batch source lvs/netgen_lvs_auto.tcl
```

## Output
- Report: `lvs/lvs_report.log`
- Status yang diharapkan: `LVS MATCH` / tidak ada mismatch device/net

## Jika mismatch
1. Cek nama topcell (harus sama: `inverter`)
2. Cek pin order (`in out vdd gnd`)
3. Cek koneksi bulk/source transistor
4. Cek naming power net (`vdd`, `gnd`)
5. Cek device model mapping pada setup PDK
