-- Vô hiệu hóa kiểm tra khóa ngoại để chèn dữ liệu theo thứ tự logic
-- (Tùy chọn, hữu ích nếu script được chạy lại nhiều lần và có thể gây lỗi)
-- EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

-- Dữ liệu cho bảng ChuyenKhoa (8 khoa)
INSERT INTO ChuyenKhoa (TenKhoa, DiaChiKhoa) VALUES
(N'Khoa Nội tổng quát', N'Tầng 1, Tòa nhà A, 78 Giải Phóng, Đống Đa, Hà Nội'),
(N'Khoa Nhi', N'Tầng 2, Tòa nhà A, 78 Giải Phóng, Đống Đa, Hà Nội'),
(N'Khoa Sản - Phụ khoa', N'Tầng 3, Tòa nhà A, 78 Giải Phóng, Đống Đa, Hà Nội'),
(N'Khoa Tai Mũi Họng', N'Tầng 1, Tòa nhà B, 78 Giải Phóng, Đống Đa, Hà Nội'),
(N'Khoa Răng Hàm Mặt', N'Tầng 2, Tòa nhà B, 78 Giải Phóng, Đống Đa, Hà Nội'),
(N'Khoa Da liễu', N'Tầng 3, Tòa nhà B, 78 Giải Phóng, Đống Đa, Hà Nội'),
(N'Khoa Chẩn đoán hình ảnh', N'Tầng 1, Tòa nhà C, 78 Giải Phóng, Đống Đa, Hà Nội'),
(N'Phòng xét nghiệm', N'Tầng 2, Tòa nhà C, 78 Giải Phóng, Đống Đa, Hà Nội');

-- Dữ liệu cho bảng NhanVien
-- Bác sĩ (MaKhoa từ 1-6)
INSERT INTO NhanVien (HoTen, GioiTinh, NgaySinh, TenDangNhap, MatKhau, VaiTro, Email, SoDienThoai, DiaChi, MaKhoa) VALUES
(N'Nguyễn Văn An', 'M', '1980-05-20', 'annv', 'hashed_password_placeholder', N'Bác sĩ', 'annv.bs@phongkham.vn', '0912345678', N'123 Trường Chinh, Hà Nội', 1),
(N'Trần Thị Bình', 'F', '1985-11-15', 'binhtt', 'hashed_password_placeholder', N'Bác sĩ', 'binhtt.bs@phongkham.vn', '0987654321', N'456 Lê Duẩn, Hà Nội', 2),
(N'Lê Minh Cường', 'M', '1978-02-10', 'cuonglm', 'hashed_password_placeholder', N'Bác sĩ', 'cuonglm.bs@phongkham.vn', '0905112233', N'789 Xã Đàn, Hà Nội', 3),
(N'Phạm Thị Dung', 'F', '1988-09-01', 'dungpt', 'hashed_password_placeholder', N'Bác sĩ', 'dungpt.bs@phongkham.vn', '0978123456', N'101 Bà Triệu, Hà Nội', 4),
(N'Hoàng Văn Giang', 'M', '1982-07-22', 'gianghv', 'hashed_password_placeholder', N'Bác sĩ', 'gianghv.bs@phongkham.vn', '0915654789', N'212 Nguyễn Trãi, Hà Nội', 5),
(N'Vũ Thu Hà', 'F', '1990-03-30', 'havt', 'hashed_password_placeholder', N'Bác sĩ', 'havt.bs@phongkham.vn', '0988111222', N'333 Cầu Giấy, Hà Nội', 6),
-- Y tá, Dược sĩ, Thu ngân/Lễ tân
(N'Nguyễn Thị Lan', 'F', '1992-06-18', 'lannn', 'hashed_password_placeholder', N'Y tá', 'lannn.yt@phongkham.vn', '0966555444', N'55 Tôn Đức Thắng, Hà Nội', 1),
(N'Trần Văn Hùng', 'M', '1995-01-25', 'hungtv', 'hashed_password_placeholder', N'Dược sĩ', 'hungtv.ds@phongkham.vn', '0933222111', N'88 Láng Hạ, Hà Nội', NULL),
(N'Lê Thị Mai', 'F', '1998-08-08', 'mailt', 'hashed_password_placeholder', N'Lễ tân', 'mailt.lt@phongkham.vn', '0944777888', N'99 Kim Mã, Hà Nội', NULL),
(N'Phạm Văn Tuấn', 'M', '1993-12-12', 'tuanpv', 'hashed_password_placeholder', N'Thu ngân', 'tuanpv.tn@phongkham.vn', '0922333444', N'111 Trần Duy Hưng, Hà Nội', NULL),
(N'Bùi Quang Khải', 'M', '1986-04-12', 'khaibq', 'hashed_password_placeholder', N'Bác sĩ', 'khaibq.bs@phongkham.vn', '0918765432', N'25 Láng Hạ, Hà Nội', 6), -- Bác sĩ Da liễu, MaKhoa = 6
(N'Đỗ Thùy Linh', 'F', '1996-10-05', 'linhdt', 'hashed_password_placeholder', N'Y tá', 'linhdt.yt@phongkham.vn', '0967890123', N'18 Hoàng Cầu, Hà Nội', 1); -- Y tá khoa Nội


-- Dữ liệu cho bảng BenhNhan (10 bệnh nhân)
INSERT INTO BenhNhan (HoTen, NgaySinh, GioiTinh, SoDienThoai, Email, DiaChi, TienSuDiUng, NgayTaoHoSo) VALUES
(N'Nguyễn Văn A', '1995-10-10', 'M', '0981112221', 'nguyenvana@email.com', N'Số 10, ngõ 20, Hồ Tùng Mậu, Cầu Giấy, Hà Nội', N'Không có', '2023-01-15'),
(N'Trần Thị B', '2019-05-22', 'F', '0981112222', 'tranthib@email.com', N'Số 5, đường Hoàng Quốc Việt, Cầu Giấy, Hà Nội', N'Dị ứng sữa bò', '2023-02-20'),
(N'Lê Văn C', '1988-03-15', 'M', '0981112223', 'levanc@email.com', N'P201, Chung cư Times City, Minh Khai, Hai Bà Trưng, Hà Nội', N'Dị ứng hải sản', '2023-03-10'),
(N'Phạm Thị D', '1992-07-01', 'F', '0981112224', NULL, N'Số 15, phố Chùa Láng, Đống Đa, Hà Nội', N'Không có', '2023-04-05'),
(N'Hoàng Văn E', '1975-11-30', 'M', '0981112225', 'hoangvane@email.com', N'Số 8, ngõ 100, Tây Sơn, Đống Đa, Hà Nội', N'Dị ứng Penicillin', '2023-05-11'),
(N'Vũ Thị F', '2001-01-20', 'F', '0981112226', 'vuthif@email.com', N'Ký túc xá Mễ Trì, Thanh Xuân, Hà Nội', N'Dị ứng phấn hoa', '2023-06-18'),
(N'Đặng Văn G', '1960-12-25', 'M', '0981112227', NULL, N'Số 22, đường Láng, Đống Đa, Hà Nội', N'Không có', '2023-07-21'),
(N'Bùi Thị H', '1999-08-19', 'F', '0981112228', 'buithih@email.com', N'Số 30, phố Phạm Ngọc Thạch, Đống Đa, Hà Nội', N'Không có', '2023-08-02'),
(N'Ngô Văn I', '2022-02-14', 'M', '0981112229', NULL, N'P505, Tòa S2, Vinhomes Smart City, Tây Mỗ, Nam Từ Liêm, Hà Nội', N'Không có', '2023-09-09'),
(N'Doãn Thị K', '1985-06-09', 'F', '0981112230', 'doanthik@email.com', N'Số 45, phố Huế, Hoàn Kiếm, Hà Nội', N'Dị ứng tôm', '2023-10-14'),
(N'Phan Anh Tuấn', '1955-08-20', 'M', '0982223331', 'tuanpa@email.com', N'Số 12, ngõ 50, Võng Thị, Tây Hồ, Hà Nội', N'Không có', '2024-01-20'),
(N'Đỗ Mỹ Linh', '1994-02-14', 'F', '0982223332', 'linhdm@email.com', N'P1102, Chung cư Royal City, Nguyễn Trãi, Thanh Xuân, Hà Nội', N'Dị ứng bụi mịn', '2024-02-15'),
(N'Lê Minh Nhật', '2005-09-30', 'M', '0982223333', NULL, N'Số 8, Triều Khúc, Thanh Trì, Hà Nội', N'Không có', '2024-03-01'),
(N'Trịnh Thu Trang', '1998-11-11', 'F', '0982223334', 'trangtt@email.com', N'Số 24, phố Hàng Bài, Hoàn Kiếm, Hà Nội', N'Dị ứng thuốc Aspirin', '2024-03-22'),
(N'Nguyễn Hoàng Lâm', '1982-01-01', 'M', '0982223335', NULL, N'Số 5, ngách 10, ngõ 158 Nguyễn Khánh Toàn, Cầu Giấy, Hà Nội', N'Không có', '2024-04-10'),
(N'Vũ Ngọc Anh', '2021-07-19', 'F', '0982223336', 'anhvn@email.com', N'P801, Tòa T1, Thăng Long Number One, Cầu Giấy, Hà Nội', N'Không có', '2024-04-18'),
(N'Trần Bảo Nam', '2015-06-05', 'M', '0982223337', NULL, N'Số 19, phố Nguyễn Khuyến, Văn Quán, Hà Đông, Hà Nội', N'Hen suyễn', '2024-05-02'),
(N'Bùi Phương Nga', '1991-03-08', 'F', '0982223338', 'ngabp@email.com', N'Số 10, đường Mỹ Đình, Nam Từ Liêm, Hà Nội', N'Không có', '2024-05-05'),
(N'Đặng Tiến Dũng', '1979-12-15', 'M', '0982223339', 'dungdt@email.com', N'Số 44, phố Trần Hưng Đạo, Hoàn Kiếm, Hà Nội', N'Dị ứng hải sản có vỏ', '2024-05-10'),
(N'Hoàng Yến Chi', '2000-10-27', 'F', '0982223340', NULL, N'Số 33, ngõ 2, Phạm Văn Đồng, Cầu Giấy, Hà Nội', N'Không có', '2024-05-15');


-- Dữ liệu cho bảng DichVuYTe
INSERT INTO DichVuYTe (TenDichVu, DonGia, LoaiDichVu, MoTa, TrangThaiKhaDung) VALUES
(N'Khám lâm sàng tổng quát', 150000.00, N'Khám bệnh', N'Bác sĩ thăm khám, hỏi bệnh và đưa ra chỉ định ban đầu', N'Đang hoạt động'),
(N'Siêu âm ổ bụng tổng quát', 250000.00, N'Chẩn đoán hình ảnh', N'Siêu âm kiểm tra các tạng trong ổ bụng: gan, mật, tụy, lách, thận...', N'Đang hoạt động'),
(N'Xét nghiệm công thức máu', 120000.00, N'Xét nghiệm', N'Phân tích các thành phần của máu, phát hiện các bệnh lý về máu', N'Đang hoạt động'),
(N'Nội soi tai mũi họng', 300000.00, N'Chẩn đoán hình ảnh', N'Sử dụng ống nội soi để quan sát bên trong tai, mũi, họng', N'Đang hoạt động'),
(N'Lấy cao răng', 200000.00, N'Nha khoa', N'Làm sạch mảng bám và cao răng', N'Đang hoạt động'),
(N'Khám thai định kỳ', 200000.00, N'Khám bệnh', N'Theo dõi sức khỏe của mẹ và sự phát triển của thai nhi', N'Đang hoạt động'),
(N'Siêu âm thai 2D', 180000.00, N'Chẩn đoán hình ảnh', N'Siêu âm theo dõi hình thái thai nhi', N'Đang hoạt động'),
(N'Xét nghiệm nước tiểu', 80000.00, N'Xét nghiệm', N'Phân tích các chỉ số trong nước tiểu', N'Đang hoạt động'),
(N'Khám chuyên khoa Da liễu', 200000.00, N'Khám bệnh', N'Khám và tư vấn các bệnh về da', N'Đang hoạt động'),
(N'Xét nghiệm đường huyết mao mạch', 50000.00, N'Xét nghiệm', N'Kiểm tra nhanh đường huyết tại chỗ', N'Đang hoạt động'),
(N'Điện tâm đồ (ECG)', 150000.00, N'Chẩn đoán chức năng', N'Ghi lại hoạt động điện của tim', N'Đang hoạt động'),
(N'Soi da', 250000.00, N'Chẩn đoán hình ảnh', N'Phân tích tình trạng da bằng máy soi chuyên dụng', N'Đang hoạt động');

-- Dữ liệu cho bảng Thuoc
INSERT INTO Thuoc (MaThuoc, TenThuoc, DonViTinh, DonGiaBan, SoLuongTon, HamLuong, GhiChu) VALUES
('PARA500', N'Paracetamol 500mg', N'Viên', 1000.00, 5000, '500mg', N'Thuốc hạ sốt, giảm đau'),
('AMOXI250', N'Amoxicillin 250mg', N'Gói', 3000.00, 2000, '250mg', N'Kháng sinh'),
('BERBERIN', N'Berberin 50mg', N'Viên', 500.00, 10000, '50mg', N'Trị tiêu chảy, nhiễm khuẩn đường ruột'),
('CLORAN', N'Clorpheniramin 4mg', N'Viên', 800.00, 3000, '4mg', N'Thuốc chống dị ứng'),
('OBIMIN', N'Obimin Plus', N'Viên', 4000.00, 1500, NULL, N'Vitamin tổng hợp cho bà bầu'),
('ALPHA', N'Alpha Choay', N'Viên', 1500.00, 4000, '4.2mg', N'Thuốc kháng viêm, giảm phù nề'),
('AMLOR', N'Amlor 5mg', N'Viên', 2000.00, 2000, '5mg', N'Thuốc điều trị tăng huyết áp'),
('AUGMENTIN', N'Augmentin 625mg', N'Viên', 12000.00, 1000, '625mg', N'Kháng sinh phổ rộng'),
('FUCIDIN', N'Fucidin H Cream', N'Tuýp', 95000.00, 500, '15g', N'Kem bôi trị viêm da, nhiễm khuẩn'),
('VENTOLIN', N'Ventolin Nebules', N'Ống', 8000.00, 800, '2.5mg', N'Thuốc giãn phế quản, dùng cho máy khí dung');


--- BẮT ĐẦU CHU TRÌNH TẠO 10 PHIẾU KHÁM ---

-- Hóa đơn dịch vụ (tạm thời tạo trước, Tổng tiền sẽ được cập nhật sau hoặc để NULL)
-- Giả sử nhân viên thu ngân (MaNhanVien=10) lập các hóa đơn này
INSERT INTO HoaDonDichVu (NgayLapHoaDon, TongTienThanhToan, HinhThucThanhToan, MaNhanVien) VALUES
('2024-05-10', 370000.00, N'Tiền mặt', 10), -- PK 1
('2024-05-11', 150000.00, N'Chuyển khoản', 10), -- PK 2
('2024-05-12', 400000.00, N'Thẻ tín dụng', 10), -- PK 3
('2024-05-13', 300000.00, N'Tiền mặt', 10), -- PK 4
('2024-05-14', 350000.00, N'Tiền mặt', 10), -- PK 5
('2024-05-15', 150000.00, N'Chuyển khoản', 10), -- PK 6
('2024-05-16', 150000.00, N'Tiền mặt', 10), -- PK 7
('2024-05-17', 380000.00, N'Thẻ tín dụng', 10), -- PK 8
(NULL, NULL, NULL, NULL), -- PK 9 không dùng dịch vụ
('2024-05-19', 380000.00, N'Tiền mặt', 10), -- PK 10
('2024-05-20', 320000.00, N'Tiền mặt', 10),       -- PK 11
('2024-05-20', 150000.00, N'Chuyển khoản', 10),    -- PK 12
('2024-05-21', 450000.00, N'Thẻ tín dụng', 10),    -- PK 13
('2024-05-21', 300000.00, N'Tiền mặt', 10),       -- PK 14
('2024-05-22', 150000.00, N'Tiền mặt', 10),       -- PK 15
('2024-05-22', 120000.00, N'Chuyển khoản', 10),    -- PK 16
('2024-05-23', 300000.00, N'Tiền mặt', 10),       -- PK 17
('2024-05-23', 200000.00, N'Tiền mặt', 10),       -- PK 18
('2024-05-24', 250000.00, N'Thẻ tín dụng', 10),    -- PK 19
('2024-05-24', 380000.00, N'Chuyển khoản', 10),    -- PK 20
(NULL, NULL, NULL, NULL),                        -- PK 21 (Không dùng dịch vụ)
('2024-05-25', 150000.00, N'Tiền mặt', 10),       -- PK 22
('2024-05-25', 150000.00, N'Chuyển khoản', 10),    -- PK 23
('2024-05-26', 400000.00, N'Thẻ tín dụng', 10),    -- PK 24
('2024-05-26', 150000.00, N'Tiền mặt', 10);      -- PK 25

-- Phiếu Khám (10 phiếu)
-- Lưu ý: MaHoaDonDichVu có thể NULL nếu không sử dụng dịch vụ.
INSERT INTO PhieuKham (ThoiGianBatDauKham, NgayKham, ChanDoan, LyDoKham, KetQuaLamSang, PhuongPhapDieuTri, TrangThaiPhieu, MaBenhNhan, MaBacSi, MaHoaDonDichVu) VALUES
('08:30:00', '2024-05-10', N'Viêm dạ dày cấp', N'Đau bụng vùng thượng vị, ợ chua', N'Ấn vùng thượng vị bệnh nhân đau. Xét nghiệm máu bình thường.', N'Kê đơn thuốc điều trị, tư vấn chế độ ăn uống', N'Hoàn thành', 1, 1, 1),
('09:00:00', '2024-05-11', N'Sốt virus', N'Bé sốt cao, ho nhẹ', N'Họng đỏ nhẹ, phổi thông khí tốt. Bé tỉnh táo, chơi bình thường.', N'Hạ sốt, theo dõi thêm tại nhà', N'Hoàn thành', 2, 2, 2),
('10:15:00', '2024-05-12', N'Theo dõi thai 12 tuần', N'Khám thai định kỳ', N'Tim thai 150l/p. Thai phát triển bình thường.', N'Siêu âm, kê vitamin tổng hợp, hẹn tái khám sau 4 tuần.', N'Hoàn thành', 3, 3, 3),
('14:00:00', '2024-05-13', N'Viêm họng cấp', N'Đau họng, khó nuốt', N'Họng đỏ, amidan sưng. Nội soi thấy nhiều dịch nhầy.', N'Kê đơn kháng sinh, kháng viêm, thuốc súc họng.', N'Hoàn thành', 4, 4, 4),
('15:30:00', '2024-05-14', N'Viêm nha chu', N'Chảy máu chân răng, hôi miệng', N'Nhiều cao răng, lợi sưng đỏ.', N'Lấy cao răng, kê đơn thuốc, hướng dẫn vệ sinh răng miệng.', N'Hoàn thành', 5, 5, 5),
('09:45:00', '2024-05-15', N'Viêm da dị ứng', N'Nổi mẩn đỏ, ngứa ở tay', N'Da vùng cánh tay có nhiều sẩn đỏ, khô, bong vảy nhẹ.', N'Kê đơn thuốc bôi và thuốc uống chống dị ứng.', N'Hoàn thành', 6, 6, 6),
('11:00:00', '2024-05-16', N'Tăng huyết áp', N'Kiểm tra sức khỏe định kỳ', N'Huyết áp 150/90 mmHg. Tim đều.', N'Kê đơn thuốc hạ áp, tư vấn thay đổi lối sống.', N'Hoàn thành', 7, 1, 7),
('16:00:00', '2024-05-17', N'Khám thai 32 tuần', N'Khám thai định kỳ', N'Thai phát triển tốt, ngôi thuận.', N'Siêu âm màu, xét nghiệm nước tiểu, hẹn tái khám hàng tuần.', N'Hoàn thành', 8, 3, 8),
('10:30:00', '2024-05-18', N'Viêm mũi dị ứng', N'Hắt hơi, sổ mũi trong', N'Niêm mạc mũi phù nề, nhợt màu.', N'Kê đơn thuốc xịt mũi và thuốc chống dị ứng.', N'Hoàn thành', 9, 4, NULL),
('08:00:00', '2024-05-19', N'Tiêu chảy cấp', N'Bé đi ngoài phân lỏng nhiều lần', N'Bụng mềm, không chướng. Bé có dấu hiệu mất nước nhẹ.', N'Bù điện giải (Oresol), kê men vi sinh, berberin.', N'Hoàn thành', 10, 2, 10),
('08:15:00', '2024-05-20', N'Tăng huyết áp vô căn', N'Tái khám huyết áp cao', N'HA 160/95 mmHg. Tim đều, phổi trong.', N'Điều chỉnh liều thuốc, hẹn tái khám 1 tháng. Xét nghiệm máu.', N'Hoàn thành', 11, 1, 11),
('08:45:00', '2024-05-20', N'Cảm cúm thông thường', N'Ho, sốt nhẹ', N'Họng đỏ, không có dấu hiệu viêm phổi.', N'Nghỉ ngơi, uống nhiều nước, kê đơn thuốc hạ sốt.', N'Hoàn thành', 12, 1, 12),
('09:30:00', '2024-05-21', N'Viêm da cơ địa', N'Da nổi mẩn đỏ, ngứa', N'Da khô, bong tróc, có vùng sẩn đỏ. Soi da thấy tổn thương.', N'Kê đơn kem bôi, thuốc chống dị ứng. Tránh chất kích ứng.', N'Hoàn thành', 13, 11, 13),
('10:00:00', '2024-05-21', N'Viêm mũi họng cấp', N'Đau họng, nghẹt mũi', N'Niêm mạc họng đỏ, sung huyết.', N'Kê đơn kháng sinh, giảm đau, thuốc xịt mũi.', N'Hoàn thành', 14, 4, 14),
('10:45:00', '2024-05-22', N'Rối loạn tiêu hóa', N'Đầy bụng, khó tiêu', N'Bụng mềm, không có điểm đau khu trú.', N'Kê đơn men tiêu hóa, tư vấn chế độ ăn.', N'Hoàn thành', 15, 1, 15),
('11:15:00', '2024-05-22', N'Khám sức khỏe tổng quát cho trẻ', N'Khám định kỳ', N'Bé phát triển thể chất, tinh thần bình thường.', N'Tư vấn dinh dưỡng, lịch tiêm chủng.', N'Hoàn thành', 16, 2, 16),
('14:00:00', '2024-05-23', N'Cơn hen phế quản cấp', N'Khó thở, ho khò khè', N'Phổi có ran rít, ran ngáy lan tỏa 2 bên.', N'Khí dung Ventolin, kê đơn thuốc dự phòng.', N'Hoàn thành', 17, 2, 17),
('14:30:00', '2024-05-23', N'Khám phụ khoa định kỳ', N'Kiểm tra sức khỏe', N'Cổ tử cung không có tổn thương bất thường.', N'Tư vấn vệ sinh, hẹn tái khám sau 1 năm.', N'Hoàn thành', 18, 3, 18),
('15:15:00', '2024-05-24', N'Sâu răng', N'Đau răng', N'Phát hiện lỗ sâu ở răng số 6 hàm dưới trái.', N'Tư vấn trám răng, kê đơn giảm đau tạm thời.', N'Hoàn thành', 19, 5, 19),
('16:00:00', '2024-05-24', N'Theo dõi thai 20 tuần', N'Siêu âm hình thái thai', N'Thai phát triển tương đương 20 tuần, các chỉ số bình thường.', N'Siêu âm, xét nghiệm nước tiểu, kê sắt và canxi.', N'Hoàn thành', 20, 3, 20),
('16:30:00', '2024-05-24', N'Tái khám sau điều trị viêm dạ dày', N'Tái khám', N'Bệnh nhân hết đau bụng, ăn uống tốt hơn.', N'Ngưng thuốc, duy trì chế độ ăn uống lành mạnh.', N'Hoàn thành', 1, 1, NULL),
('08:00:00', '2024-05-25', N'Tái khám mề đay', N'Da vẫn còn ngứa', N'Còn vài nốt mẩn đỏ rải rác.', N'Tiếp tục dùng thuốc chống dị ứng.', N'Hoàn thành', 6, 6, 22),
('09:00:00', '2024-05-25', N'Viêm kết mạc', N'Mắt đỏ, chảy ghèn', N'Kết mạc cương tụ, có nhiều ghèn vàng.', N'Kê đơn thuốc nhỏ mắt kháng sinh.', N'Hoàn thành', 4, 1, 23),
('10:00:00', '2024-05-26', N'Đau thần kinh tọa', N'Đau lưng lan xuống chân', N'Dấu hiệu Lasègue (+).', N'Kê đơn giảm đau, giãn cơ. Tư vấn vật lý trị liệu.', N'Hoàn thành', 7, 1, 24),
('11:00:00', '2024-05-26', N'Tư vấn tiêm chủng cho trẻ', N'Bé đến lịch tiêm', N'Bé khỏe mạnh, đủ điều kiện tiêm.', N'Thực hiện tiêm chủng theo lịch.', N'Hoàn thành', 9, 2, 25);

-- Chi Tiết Hóa Đơn Dịch Vụ (liên kết với HoaDonDichVu và PhieuKham)
INSERT INTO ChiTietHoaDonDichVu (MaHoaDonDichVu, MaDichVu, DonGiaTaiThoiDiem, KetQuaDichVu, ThanhTien) VALUES
(1, 1, 150000.00, N'Khám lâm sàng', 150000.00), -- PK 1
(1, 3, 120000.00, N'Các chỉ số trong giới hạn bình thường', 120000.00), -- PK 1
(2, 1, 150000.00, N'Khám lâm sàng', 150000.00), -- PK 2
(3, 6, 200000.00, N'Khám thai', 200000.00), -- PK 3
(3, 7, 180000.00, N'Thai phát triển tốt, DKLD 55mm', 180000.00), -- PK 3
(4, 1, 150000.00, N'Khám lâm sàng', 150000.00), -- PK 4
(4, 4, 300000.00, N'Amidan sưng đỏ, có mủ', 300000.00), -- PK 4
(5, 1, 150000.00, N'Khám lâm sàng', 150000.00), -- PK 5
(5, 5, 200000.00, N'Làm sạch cao răng 2 hàm', 200000.00), -- PK 5
(6, 1, 150000.00, N'Khám lâm sàng', 150000.00), -- PK 6
(7, 1, 150000.00, N'Khám lâm sàng', 150000.00), -- PK 7
(8, 6, 200000.00, N'Khám thai', 200000.00), -- PK 8
(8, 8, 80000.00, N'Protein niệu âm tính', 80000.00), -- PK 8
(10, 1, 150000.00, N'Khám lâm sàng', 150000.00), -- PK 10
(10, 8, 80000.00, N'Tỷ trọng 1.020', 80000.00), -- PK 10
(11, 1, 150000.00, N'Khám lâm sàng', 150000.00), (11, 3, 120000.00, N'Công thức máu trong giới hạn bình thường', 120000.00), (11, 10, 50000.00, N'Đường huyết 6.5 mmol/L', 50000.00),
(12, 1, 150000.00, N'Khám lâm sàng', 150000.00),
(13, 9, 200000.00, N'Khám chuyên khoa', 200000.00), (13, 12, 250000.00, N'Da khô, lớp sừng dày', 250000.00),
(14, 4, 300000.00, N'Nội soi tai mũi họng', 300000.00),
(15, 1, 150000.00, N'Khám lâm sàng', 150000.00),
(16, 2, 120000.00, N'Khám tổng quát nhi', 120000.00),
(17, 1, 150000.00, N'Khám lâm sàng', 150000.00), (17, 11, 150000.00, N'Nhịp xoang nhanh', 150000.00),
(18, 6, 200000.00, N'Khám phụ khoa', 200000.00),
(19, 1, 150000.00, N'Khám lâm sàng', 150000.00), (19, 5, 200000.00, N'Cần làm sạch cao răng', 200000.00),
(20, 6, 200000.00, N'Khám thai', 200000.00), (20, 7, 180000.00, N'Siêu âm thai 2D', 180000.00),
(22, 1, 150000.00, N'Khám lâm sàng', 150000.00),
(23, 1, 150000.00, N'Khám lâm sàng', 150000.00),
(24, 1, 150000.00, N'Khám lâm sàng', 150000.00), (24, 2, 250000.00, N'Siêu âm ổ bụng, không thấy bất thường', 250000.00),
(25, 2, 150000.00, N'Khám nhi trước tiêm', 150000.00);


-- Hóa Đơn Thuốc (tương ứng với các phiếu khám có kê đơn)
-- Giả sử dược sĩ (MaNhanVien=8) xuất các hóa đơn này
INSERT INTO HoaDonThuoc (NgayLapHoaDon, TongTien, HinhThucThanhToan, MaNhanVien, MaPhieuKham) VALUES
('2024-05-10', 30000.00, N'Tiền mặt', 8, 1),
('2024-05-11', 10000.00, N'Chuyển khoản', 8, 2),
('2024-05-12', 120000.00, N'Thẻ tín dụng', 8, 3),
('2024-05-13', 45000.00, N'Tiền mặt', 8, 4),
('2024-05-14', 15000.00, N'Tiền mặt', 8, 5),
('2024-05-15', 23000.00, N'Chuyển khoản', 8, 6),
('2024-05-16', 15000.00, N'Tiền mặt', 8, 7),
('2024-05-18', 8000.00, N'Thẻ tín dụng', 8, 9),
('2024-05-19', 10000.00, N'Tiền mặt', 8, 10),
('2024-05-20', 60000.00, N'Tiền mặt', 8, 11),
('2024-05-20', 10000.00, N'Chuyển khoản', 8, 12),
('2024-05-21', 103000.00, N'Thẻ tín dụng', 8, 13),
('2024-05-21', 135000.00, N'Tiền mặt', 8, 14),
('2024-05-22', 50000.00, N'Tiền mặt', 8, 15),
('2024-05-23', 80000.00, N'Tiền mặt', 8, 17),
('2024-05-24', 15000.00, N'Thẻ tín dụng', 8, 19),
('2024-05-24', 120000.00, N'Chuyển khoản', 8, 20),
('2024-05-25', 8000.00, N'Tiền mặt', 8, 22),
('2024-05-25', 45000.00, N'Chuyển khoản', 8, 23),
('2024-05-26', 75000.00, N'Thẻ tín dụng', 8, 24);

-- Chi Tiết Hóa Đơn Thuốc
INSERT INTO ChiTietHoaDonThuoc (MaHoaDonThuoc, MaThuoc, SoLuongBan, LieuDung, DonGiaTaiThoiDiem, ThanhTien) VALUES
(1, 'ALPHA', 20, N'Ngày uống 2 lần, mỗi lần 2 viên sau ăn', 1500.00, 30000.00), -- PK 1
(2, 'PARA500', 10, N'Uống khi sốt trên 38.5 độ C, mỗi lần 1 viên', 1000.00, 10000.00), -- PK 2
(3, 'OBIMIN', 30, N'Ngày uống 1 viên sau ăn sáng', 4000.00, 120000.00), -- PK 3
(4, 'AMOXI250', 10, N'Ngày uống 2 lần, mỗi lần 1 gói', 3000.00, 30000.00), -- PK 4
(4, 'ALPHA', 10, N'Ngày uống 2 lần, mỗi lần 1 viên', 1500.00, 15000.00), -- PK 4
(5, 'ALPHA', 10, N'Ngậm dưới lưỡi 4-6 viên/ngày', 1500.00, 15000.00), -- PK 5
(6, 'CLORAN', 10, N'Uống 1 viên buổi tối', 800.00, 8000.00), -- PK 6 (Thuốc uống)
(7, 'PARA500', 15, N'Uống 1 viên khi đau đầu', 1000.00, 15000.00), -- PK 7
(8, 'CLORAN', 10, N'Uống 1 viên khi cần', 800.00, 8000.00), -- PK 9
(9, 'BERBERIN', 20, N'Ngày uống 2 lần, mỗi lần 2 viên', 500.00, 10000.00), -- PK 10
(10, 'AMLOR', 30, N'Uống 1 viên vào buổi sáng', 2000.00, 60000.00),
(11, 'PARA500', 10, N'Uống khi sốt', 1000.00, 10000.00),
(12, 'FUCIDIN', 1, N'Bôi vùng da tổn thương 2 lần/ngày', 95000.00, 95000.00),
(12, 'CLORAN', 10, N'Uống 1 viên buổi tối khi ngứa nhiều', 800.00, 8000.00),
(13, 'AUGMENTIN', 10, N'Uống 2 lần/ngày sau ăn', 12000.00, 120000.00),
(13, 'ALPHA', 10, N'Ngậm 2 viên/lần', 1500.00, 15000.00),
(14, 'BERBERIN', 100, N'Uống 5 viên/lần khi đau bụng', 500.00, 50000.00),
(15, 'VENTOLIN', 10, N'Dùng khi có cơn khó thở', 8000.00, 80000.00),
(16, 'PARA500', 15, N'Uống 1 viên khi đau', 1000.00, 15000.00),
(17, 'OBIMIN', 30, N'Uống 1 viên/ngày', 4000.00, 120000.00),
(18, 'CLORAN', 10, N'Uống khi ngứa', 800.00, 8000.00),
(19, 'AMOXI250', 15, N'Uống 3 lần/ngày', 3000.00, 45000.00),
(20, 'ALPHA', 50, N'Ngậm 4-6 viên/ngày', 1500.00, 75000.00);


-- Dữ liệu cho bảng LichHen (giả định các phiếu khám này đều có lịch hẹn trước)
-- Giả sử lễ tân (MaNhanVien=9) tạo các lịch hẹn này
INSERT INTO LichHen (ThoiGianHen, TrangThaiLichHen, LyDoHenKham, GhiChu, MaBenhNhan, MaPhieuKham, MaNhanVien) VALUES
('2024-05-10 08:30:00', N'Đã đến', N'Đau bụng', N'BN đặt qua điện thoại', 1, 1, 9),
('2024-05-11 09:00:00', N'Đã đến', N'Bé bị sốt', NULL, 2, 2, 9),
('2024-05-12 10:15:00', N'Đã đến', N'Khám thai', N'BN đặt qua website', 3, 3, 9),
('2024-05-13 14:00:00', N'Đã đến', N'Đau họng', NULL, 4, 4, 9),
('2024-05-14 15:30:00', N'Đã đến', N'Kiểm tra răng', N'BN cũ tái khám', 5, 5, 9),
('2024-05-15 09:45:00', N'Đã đến', N'Ngứa da', NULL, 6, 6, 9),
('2024-05-16 11:00:00', N'Đã đến', N'Đo huyết áp', N'BN đặt qua điện thoại', 7, 7, 9),
('2024-05-17 16:00:00', N'Đã đến', N'Khám thai', NULL, 8, 8, 9),
('2024-05-18 10:30:00', N'Đã đến', N'Sổ mũi', N'BN vãng lai', 9, 9, 9),
('2024-05-19 08:00:00', N'Đã đến', N'Bé bị tiêu chảy', N'BN đặt qua app', 10, 10, 9),
('2024-06-10 09:00:00', N'Đã xác nhận', N'Tái khám tiểu đường', N'Hẹn với BS An', 11, NULL, 9),
('2024-06-11 10:30:00', N'Đã xác nhận', N'Tái khám thai', N'Hẹn với BS Cường', 20, NULL, 9),
('2024-06-12 15:00:00', N'Chờ xác nhận', N'Tư vấn da', N'Khách mới đặt qua web', 13, NULL, 9),
('2024-05-20 08:15:00', N'Đã đến', N'Tái khám huyết áp', NULL, 11, 11, 9),
('2024-05-20 08:45:00', N'Đã đến', N'Bị cảm', NULL, 12, 12, 9),
('2024-05-21 09:30:00', N'Đã đến', N'Khám da', N'BN đặt qua app', 13, 13, 9),
('2024-05-21 10:00:00', N'Đã đến', N'Đau họng', NULL, 14, 14, 9),
('2024-05-22 10:45:00', N'Đã đến', N'Khó tiêu', NULL, 15, 15, 9),
('2024-05-22 11:15:00', N'Đã đến', N'Khám cho bé', N'BN đặt qua điện thoại', 16, 16, 9),
('2024-05-23 14:00:00', N'Đã đến', N'Bé khó thở', NULL, 17, 17, 9),
('2024-05-23 14:30:00', N'Đã đến', N'Khám phụ khoa', NULL, 18, 18, 9),
('2024-05-24 15:15:00', N'Đã đến', N'Đau răng', N'BN vãng lai', 19, 19, 9),
('2024-05-24 16:00:00', N'Đã đến', N'Siêu âm thai', NULL, 20, 20, 9),
('2024-05-24 16:30:00', N'Đã đến', N'Tái khám dạ dày', NULL, 1, 21, 9),
('2024-05-25 08:00:00', N'Đã đến', N'Tái khám mề đay', N'BN cũ', 6, 22, 9),
('2024-05-25 09:00:00', N'Đã đến', N'Đau mắt đỏ', NULL, 4, 23, 9),
('2024-05-26 10:00:00', N'Đã đến', N'Đau lưng', NULL, 7, 24, 9),
('2024-05-26 11:00:00', N'Đã đến', N'Tiêm chủng', NULL, 9, 25, 9);

-- Kích hoạt lại kiểm tra khóa ngoại sau khi chèn xong
-- EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"