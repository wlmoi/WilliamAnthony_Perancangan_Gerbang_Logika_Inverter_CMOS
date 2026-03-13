# Laporan Tugas 4: Perancangan Gerbang Logika Inverter CMOS

**Nama**: William Anthony  
**NIM**: 13223048  
**Mata Kuliah**: EL4012 Analisis dan Perancangan IC Digital  
**Deadline**: 16 Maret 2026, 23:59

---

## 1. Pendahuluan
Tugas ini membahas perancangan gerbang logika inverter CMOS menggunakan flow open-source dengan teknologi GF180MCU 180 nm. Tahapan mencakup desain skematik, simulasi rangkaian, layout fisik, DRC, dan LVS.

## 2. Spesifikasi dan Asumsi Desain
- Teknologi proses: GF180MCU (180 nm)
- Topologi: Inverter CMOS (PMOS pull-up, NMOS pull-down)
- Tegangan catu: 1.8 V
- Rasio ukuran transistor: \(W_p/W_n = 2\) (WP=2.00u, WN=1.00u)
- Panjang kanal: \(L = 0.28\,\mu m\)
- Beban output simulasi: 10 fF

## 3. Tahap 1 — Desain Skematik (Xschem)
### 3.1 Skematik Inverter
Screenshot skematik: *(tempel gambar di sini)*

**Koneksi dasar:**
- Gate PMOS dan NMOS disatukan sebagai `IN`
- Drain PMOS dan NMOS disatukan sebagai `OUT`
- Source PMOS ke `VDD`
- Source NMOS ke `VSS/GND`
- Bulk PMOS ke `VDD`, bulk NMOS ke `VSS/GND`

### 3.2 Parameter Device
Isi parameter final hasil desain:
- PMOS: W = 2.00u, L = 0.28u
- NMOS: W = 1.00u, L = 0.28u

## 4. Tahap 2 — Simulasi Rangkaian (Ngspice)
### 4.1 Setup Testbench
Gunakan file testbench pada `spice/inverter_tb.spice`. Hasil sanity check dicatat dari `spice/inverter_cmos_sanity.spice`.

### 4.2 Jenis Simulasi
- Simulasi transient untuk melihat fungsi inverter
- Input berupa pulsa 0–VDD

### 4.3 Hasil Simulasi
Lampirkan plot berikut:
- Vin vs Vout
- Delay propagasi `t_pHL` dan `t_pLH`
- Rise time / fall time

Contoh tabel hasil:

| Parameter | Nilai |
|---|---:|
| VDD | 1.8 V |
| Wn/Ln | 1.00u / 0.28u |
| Wp/Lp | 2.00u / 0.28u |
| t_pHL | 0.0182 ns |
| t_pLH | 0.0195 ns |
| t_rise | N/A (belum diukur) |
| t_fall | N/A (belum diukur) |

Catatan: nilai delay diambil dari `docs/BUKTI_RUN_NGSPICE.txt`.

## 5. Tahap 3 — Layout Inverter (Magic/KLayout)
### 5.1 Implementasi Layout
Tambahkan screenshot layout final dan jelaskan penempatan:
- PMOS di area N-well
- NMOS di area P-substrate/P-well
- Routing metal input, output, VDD, dan GND
- Kontak/via sesuai aturan DRC

Screenshot layout: *(tempel gambar di sini)*

### 5.2 Dimensi Layout
- Ukuran bounding box: *(belum diukur)*
- Pertimbangan area vs kemudahan routing: area dibuat ringkas, routing dibuat sederhana untuk memudahkan DRC/LVS

## 6. Tahap 4 — DRC
### 6.1 Prosedur DRC
Jalankan DRC dari tool layout yang digunakan (Magic/KLayout) dengan rule deck GF180MCU.

### 6.2 Hasil DRC
- Total violation sebelum perbaikan: *(tidak terdokumentasi)*
- Total violation setelah perbaikan: 0 (target)

Lampirkan screenshot/teks report DRC: *(tempel di sini setelah run DRC)*

## 7. Tahap 5 — LVS (Netgen)
### 7.1 Netlist Schematic vs Layout
- Netlist schematic: `xschem/inverter_sch.spice`
- Netlist layout extraction: `layout/inverter_layout.spice`

### 7.2 Menjalankan LVS
Gunakan skrip `lvs/netgen_lvs.tcl`, sesuaikan path setup file GF180.

### 7.3 Hasil LVS
- Status akhir: **MATCH** (target)
- Jika mismatch, jelaskan akar masalah dan perbaikannya.

Lampirkan ringkasan report `lvs/lvs_report.log`: *(tempel di sini setelah run LVS)*

## 8. Analisis dan Diskusi
Bahas:
- Pengaruh rasio Wp/Wn terhadap switching threshold
- Perbedaan delay naik vs turun
- Trade-off area layout dan performa
- Kendala utama selama DRC/LVS dan cara mengatasinya

Analisis ringkas:
Dengan \(W_p/W_n = 2\), titik switching mendekati \(V_{DD}/2\) sehingga inverter lebih seimbang. Hasil delay menunjukkan \(t_{pHL}\) sedikit lebih cepat daripada \(t_{pLH}\), yang konsisten dengan perbedaan mobilitas elektron vs hole. Area layout dibuat ringkas untuk memudahkan routing, dengan konsekuensi jarak antar koneksi perlu dijaga agar tetap memenuhi rule DRC. Kendala utama biasanya pada koneksi bulk dan penamaan pin; solusi dilakukan dengan konsistensi label `in`, `out`, `vdd`, `gnd` dan pengecekan topcell.

## 9. Kesimpulan
Perancangan inverter CMOS pada teknologi GF180MCU berhasil disimulasikan dan berfungsi sebagai inverter dengan \(V_{DD}=1.8\,V\). Hasil sanity check menunjukkan level output benar dan delay propagasi berada pada orde puluhan pikodetik. Verifikasi fisik ditargetkan DRC clean dan LVS match; report DRC/LVS perlu dilampirkan setelah run akhir.

## 10. Lampiran
- Screenshot skematik
- Plot hasil Ngspice
- Screenshot layout
- Report DRC
- Report LVS

---

## Checklist Singkat Sebelum Submit
- [ ] Schematic inverter benar
- [ ] Simulasi transient sukses
- [ ] Layout selesai
- [ ] DRC clean
- [ ] LVS match
- [ ] Laporan lengkap
- [ ] Semua file sudah dizip
