* ==============================================================
* TESTBENCH KHAO SAT KHOI NAND2 PRE-LAYOUT (SCHEMATIC)
* ==============================================================
* 1. Gọi thư viện PDK 
.include '.../reference_models.inc'

* 2. Gọi file Netlist của khối NAND2 
.include 'nand2.sp'

* Khai báo các biến toàn cục 
.global vdd! gnd!

* ==============================================================
* 3. KHAI BÁO NGUỒN NUÔI VÀ NGUỒN TÍN HIỆU 
* ==============================================================
* Nguồn DC 1.2V
V_VDD  vdd!  0  1.2V
V_GND  gnd!  0  0V

* Tạo xung ngõ vào A và B để quét đủ 4 trường hợp: 00, 01, 10, 11
V_A  a  0  PULSE (0 1.2 2n 50p 50p 2n 4n)
V_B  b  0  PULSE (0 1.2 4n 50p 50p 4n 8n)

* ==============================================================
* 4. GỌI KHỐI DUT (Device Under Test)
* ==============================================================
* Thứ tự chân phải khớp với dòng .subckt nand2 a b y trong netlist
X_DUT  a b y  nand2

* ==============================================================
* 5. THIẾT LẬP MÔ PHỎNG TRANSIENT
* ==============================================================
* Khảo sát trong miền thời gian 10ns với bước nhảy 10ps
.tran 10p 10n

* ==============================================================
* 6. ĐO ĐẠC THÔNG SỐ (MEASUREMENTS) -
* ==============================================================
* Đo công suất tiêu thụ trung bình
.meas tran avg_power avg p(V_VDD) from=0 to=10n

* --- 2. Đo thời gian trễ (Propagation Delay) từ A truyền tới Y ---
* Mốc đo ở 50% mức điện áp VDD (0.6V).
* Sử dụng TD (Time Delay) để phần mềm bỏ qua nhiễu (glitch) ở mốc 4ns.

* tpHL: Trễ khi A kéo lên 1 làm Y rớt xuống 0 (Xảy ra ở mốc 6ns -> Đợi 5ns mới đo)
.meas tran delay_tpHL trig v(a) val=0.6V rise=1 TD=5n targ v(y) val=0.6V fall=1 TD=5n

* tpLH: Trễ khi A rớt xuống 0 làm Y kéo lên 1 (Xảy ra ở mốc 8ns -> Đợi 7ns mới đo)
.meas tran delay_tpLH trig v(a) val=0.6V fall=1 TD=7n targ v(y) val=0.6V rise=1 TD=7n

* --- 3. Đo Rise Time (Tr) và Fall Time (Tf) của ngõ ra Y ---
* Mốc đo từ 10% đến 90% VDD (0.12V <-> 1.08V)

* Tf: Y giảm từ 90% (1.08V) xuống 10% (0.12V) (Đo ở mốc 6ns)
.meas tran tfall_y trig v(y) val=1.08V fall=1 TD=5n targ v(y) val=0.12V fall=1 TD=5n

* Tr: Y tăng từ 10% (0.12V) lên 90% (1.08V) (Đo ở mốc 8ns)
.meas tran trise_y trig v(y) val=0.12V rise=1 TD=7n targ v(y) val=1.08V rise=1 TD=7n

* ==============================================================
* 7. CẤU HÌNH VÀ XUẤT SÓNG
* ==============================================================
.option post=2 nomod autostop
.probe tran v(a) v(b) v(y)

.end