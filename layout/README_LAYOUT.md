# Panduan Layout (Magic/KLayout) — Inverter CMOS GF180MCU

Nama: William Anthony  
NIM: 13223048

## File Referensi yang Dipakai
- File referensi layout Anda: `layout/Inverter.mag`
- Header teknologi sudah diarahkan ke GF180 (`tech gf180mcuA`).
- Jika instalasi PDK Anda memakai varian lain (`gf180mcuB/C/D`), sesuaikan nama tech saat membuka di Magic.
- Karena file ini awalnya dijadikan referensi, tetap wajib jalankan DRC + LVS GF180 dan perbaiki hingga clean/match.

## Target minimal
- Satu PMOS (dalam N-well) + satu NMOS
- Pin: `in`, `out`, `vdd`, `gnd`
- DRC clean
- Bisa diextract ke SPICE untuk LVS

## Flow di Magic (contoh)
1. Load tech GF180MCU.
   - Contoh: buka Magic dengan tech GF180 yang sesuai instalasi Anda.
2. Gambar active/poly/contacts/metal sesuai aturan.
3. Definisikan label pin dan port topcell `inverter`.
4. Jalankan DRC:
   - `drc check`
   - `drc count`
   - `drc why`
5. Ekstraksi netlist:
   - `extract all`
   - `ext2spice lvs`
   - `ext2spice`
6. Simpan netlist extraction sebagai `layout/inverter_layout.spice`.
7. Simpan ringkasan DRC pada `layout/drc_report.txt`.

## Verifikasi Minimal Sebelum DRC/LVS
- Pastikan topcell benar (`inverter` atau nama yang konsisten dengan LVS script).
- Pastikan pin ada dan jelas: `in`, `out`, `vdd`, `gnd`.
- Pastikan bulk PMOS terhubung ke `vdd` dan bulk NMOS ke `gnd`.
- Pastikan file extract netlist final disimpan ke `layout/inverter_layout.spice`.

## Flow di KLayout (alternatif)
- Gunakan deck DRC/LVS GF180.
- Export netlist layout dan jalankan Netgen untuk pembandingan dengan schematic.
