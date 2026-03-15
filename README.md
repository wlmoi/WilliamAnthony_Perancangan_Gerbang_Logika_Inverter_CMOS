# Tugas 4 — Perancangan Gerbang Logika Inverter CMOS

Nama: William Anthony  
NIM: 13223048  
Mata Kuliah: EL4012 Analisis dan Perancangan IC Digital

## Tujuan
Menyelesaikan alur lengkap desain IC digital inverter CMOS berbasis GF180MCU:
1. Schematic capture (Xschem)
2. Simulasi (Ngspice)
3. Layout (Magic VLSI/KLayout)
4. DRC
5. LVS (Netgen)

## Struktur Folder
- `docs/` → laporan dan checklist submission
- `xschem/` → schematic (`.sch`) dan netlist hasil export
- `spice/` → testbench dan file simulasi
- `layout/` → layout (`.mag`/`.gds`) dan hasil DRC
- `lvs/` → deck/skrip LVS dan hasil report
- `submission/` → hasil akhir siap zip

## Catatan Penting GF180MCU
Pastikan PDK GF180MCU sudah terpasang dan path model/tech file disesuaikan dengan instalasi Anda.

Contoh variabel environment yang umum dipakai:
- `PDK_ROOT`
- `PDK=gf180mcuA`

## Alur Kerja Singkat
1. Buat schematic inverter di Xschem (`xschem/`)
2. Export netlist schematic ke SPICE
3. Jalankan simulasi transient memakai `spice/inverter_tb.spice`
4. Buat layout inverter di Magic/KLayout (`layout/`)
5. Jalankan DRC dan simpan report
6. Extract netlist layout
7. Jalankan LVS dengan Netgen (`lvs/netgen_lvs_auto.tcl`)
8. Lengkapi laporan (`docs/LAPORAN_TUGAS4_WilliamAnthony_13223048.md`)
9. Kumpulkan zip satu folder proyek

## Packaging
Gunakan script PowerShell `submission/pack_submission.ps1` untuk membuat zip final.
