-- View bệnh nhân có lịch hẹn hôm nay:
--Mục đích: Hỗ trợ bộ phận lễ tân hoặc bác sĩ xem danh sách bệnh nhân dự kiến đến khám trong ngày.
CREATE VIEW  vw_BenhNhanCoLichHenHomNay
	AS
	SELECT lh.MaLichHen, lh.MaBenhNhan, bn.HoTen, ThoiGianHen,LyDoHenKham, TrangThaiLichHen, nv.HoTen as BacSi
	FROM LichHen lh join BenhNhan bn on  lh.MaBenhNhan = bn.MaBenhNhan
	join NhanVien nv on lh.MaNhanVien = nv.MaNhanVien
	WHERE nv.VaiTro like 'Bac si'
	AND CONVERT(DATE, lh.ThoiGianHen) = CONVERT(DATE, GETDATE())

-- View lịch sử khám bệnh của tất cả các bệnh nhân 
CREATE VIEW vw_LichSuKhamBenhChiTiet AS
SELECT
    bn.MaBenhNhan,
    bn.HoTen AS TenBenhNhan,
    bn.NgaySinh,
    pk.NgayKham,
    nv.HoTen AS TenBacSi,
    ck.TenKhoa,
    pk.ChanDoan,
    hd.TongTienThanhToan
FROM BenhNhan bn
JOIN PhieuKham pk on bn.MaBenhNhan = pk.MaBenhNhan
JOIN NhanVien  nv  ON pk.MaBacSi  = nv.MaNhanVien 
join ChuyenKhoa ck on nv.MaKhoa = ck.MaKhoa
LEFT JOIN HoaDonDichVu hd ON pk.MaHoaDonDichVu  = hd.MaHoaDonDichVu;

--Test 
SELECT * FROM vw_LichSuKhamBenhChiTiet
WHERE MaBenhNhan = 5
ORDER BY TenBacSi ASC;

SELECT * FROM vw_LichSuKhamBenhChiTiet WHERE TenBenhNhan LIKE N'Nguyễn Văn A%';

--------------------------------------------------------------
CREATE VIEW vw_ThongTinChiTietHoaDonDichVu AS
SELECT
    -- Thông tin hóa đơn chính
    HDV.MaHoaDonDichVu,
    HDV.NgayLapHoaDon,
    HDV.TongTienThanhToan,
    HDV.HinhThucThanhToan,
    -- Thông tin nhân viên lập hóa đơn
    HDV.MaNhanVien AS MaNhanVienLap,
    NV.HoTen AS TenNhanVienLap,
    -- Thông tin bệnh nhân (liên kết qua phiếu khám)
    PK.MaPhieuKham,
    BN.MaBenhNhan,
    BN.HoTen AS TenBenhNhan,
    -- Thông tin chi tiết dịch vụ
    CTDV.MaChiTietHoaDonDichVu,
    DV.MaDichVu,
    DV.TenDichVu,
    DV.LoaiDichVu,
    CTDV.DonGiaTaiThoiDiem,
    CTDV.ThanhTien AS ThanhTienChiTiet,
    CTDV.KetQuaDichVu
FROM
    HoaDonDichVu AS HDV
LEFT JOIN ChiTietHoaDonDichVu AS CTDV ON HDV.MaHoaDonDichVu = CTDV.MaHoaDonDichVu
LEFT JOIN DichVuYTe AS DV ON CTDV.MaDichVu = DV.MaDichVu
LEFT JOIN NhanVien AS NV ON HDV.MaNhanVien = NV.MaNhanVien
LEFT JOIN PhieuKham AS PK ON HDV.MaHoaDonDichVu = PK.MaHoaDonDichVu
LEFT JOIN BenhNhan AS BN ON PK.MaBenhNhan = BN.MaBenhNhan;
GO
--TEST 
SELECT
    MaHoaDonDichVu,
    NgayLapHoaDon,
    TenBenhNhan,
    TenDichVu,
    DonGiaTaiThoiDiem,
    KetQuaDichVu
FROM
    vw_ThongTinChiTietHoaDonDichVu
WHERE
    MaHoaDonDichVu = 3;
-----------------------------------------------------
CREATE VIEW vw_ThongTinChiTietHoaDonThuoc AS
SELECT
    -- Thông tin hóa đơn chính
    HDT.MaHoaDonThuoc,
    HDT.NgayLapHoaDon,
    HDT.TongTien,
    HDT.HinhThucThanhToan,
    
    -- Thông tin dược sĩ/nhân viên xuất đơn
    HDT.MaNhanVien AS MaDuocSi,
    NV.HoTen AS TenDuocSi,
    
    -- Thông tin bệnh nhân (lấy qua phiếu khám)
    PK.MaPhieuKham,
    BN.MaBenhNhan,
    BN.HoTen AS TenBenhNhan,
    
    -- Thông tin chi tiết thuốc trong hóa đơn
    CTDT.MaChiTietHoaDonThuoc,
    T.MaThuoc,
    T.TenThuoc,
    T.DonViTinh,
    CTDT.SoLuongBan,
    CTDT.LieuDung,
    CTDT.DonGiaTaiThoiDiem,
    CTDT.ThanhTien AS ThanhTienChiTiet
FROM
    HoaDonThuoc AS HDT
LEFT JOIN ChiTietHoaDonThuoc AS CTDT ON HDT.MaHoaDonThuoc = CTDT.MaHoaDonThuoc
LEFT JOIN Thuoc AS T ON CTDT.MaThuoc = T.MaThuoc
LEFT JOIN NhanVien AS NV ON HDT.MaNhanVien = NV.MaNhanVien
LEFT JOIN PhieuKham AS PK ON HDT.MaPhieuKham = PK.MaPhieuKham
LEFT JOIN BenhNhan AS BN ON PK.MaBenhNhan = BN.MaBenhNhan;
GO
--TEST 
SELECT
    MaHoaDonThuoc,
    NgayLapHoaDon,
    TenBenhNhan,
    TenThuoc,
    SoLuongBan,
    DonGiaTaiThoiDiem,
    ThanhTienChiTiet,
    LieuDung
FROM
    vw_ThongTinChiTietHoaDonThuoc
WHERE
    MaHoaDonThuoc = 4;