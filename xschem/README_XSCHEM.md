# Panduan Xschem — Inverter CMOS GF180MCU

Nama: William Anthony  
NIM: 13223048

## Langkah ringkas
1. Buka Xschem dengan environment GF180MCU aktif.
2. Place device PMOS dan NMOS dari library GF180.
3. Hubungkan:
   - Gate PMOS/NMOS ke `in`
   - Drain PMOS/NMOS ke `out`
   - Source+bulk PMOS ke `vdd`
   - Source+bulk NMOS ke `gnd`
4. Tambahkan pin `in`, `out`, `vdd`, `gnd`.
5. Simpan sebagai `xschem/inverter.sch`.
6. Netlist/export menjadi `xschem/inverter_sch.spice` dengan topcell `inverter`.

## Catatan
- Nama model transistor harus konsisten dengan model file ngspice GF180 yang Anda pakai.
- Jika model 3.3V digunakan, cek aturan bias sesuai PDK.
