# Checklist Submission — Tugas 4

## A. File Teknis
- [ ] `xschem/inverter.sch`
- [ ] `xschem/inverter_sch.spice`
- [ ] `spice/inverter_tb.spice`
- [ ] `layout/Inverter.mag` atau `layout/inverter.gds`
- [ ] `layout/inverter_layout.spice` (hasil extraction)
- [ ] `layout/drc_report.txt`
- [ ] `lvs/netgen_lvs.tcl`
- [ ] `lvs/lvs_report.log`

## A1. Konsistensi Teknologi GF180MCU
- [ ] Layout menggunakan teknologi GF180MCU (bukan SKY130)
- [ ] Header `.mag` sesuai GF180 (`tech gf180mcuA/B/C/D` sesuai instalasi)
- [ ] DRC dijalankan dengan rule deck GF180MCU
- [ ] LVS dijalankan dengan setup Netgen GF180MCU

## B. Bukti Verifikasi
- [ ] Screenshot schematic
- [ ] Plot simulasi Vin/Vout
- [ ] Bukti DRC clean
- [ ] Bukti LVS match

## C. Laporan
- [ ] Laporan terisi lengkap pada `docs/LAPORAN_TUGAS4_WilliamAnthony_13223048.md`
- [ ] Semua gambar terbaca jelas
- [ ] Semua nilai parameter dan analisis sudah diisi

## D. Packaging
- [ ] Semua file dalam satu folder proyek
- [ ] Sudah dijalankan script zip di `submission/pack_submission.ps1`
- [ ] Nama zip mengikuti format yang diminta dosen (jika ada)
