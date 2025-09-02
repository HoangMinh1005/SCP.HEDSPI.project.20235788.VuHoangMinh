
--Trigger thay doi tong tien trong hoa don khi them thuoc vao chi tiet hoa don
CREATE TRIGGER trg_CapNhatTongTienHoaDonThuoc_AfterInsert
ON ChiTietHoaDonThuoc
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    -- Cập nhật TongTien cho từng MaHoaDonThuoc có phát sinh chi tiết mới
    UPDATE HDT
    SET HDT.TongTien =
    (
        SELECT SUM(CTHD.SoLuongBan * T.DonGiaBan)
        FROM ChiTietHoaDonThuoc CTHD
        JOIN Thuoc T ON CTHD.MaThuoc = T.MaThuoc
        WHERE CTHD.MaHoaDonThuoc = HDT.MaHoaDonThuoc
    ),
    HDT.NgayLapHoaDon = GETDATE()
    FROM HoaDonThuoc HDT
    JOIN (
        SELECT DISTINCT MaHoaDonThuoc
        FROM inserted
    ) AS I ON HDT.MaHoaDonThuoc = I.MaHoaDonThuoc;
END;
-------------------------------------------------------------------------------
--Trigger thay doi tong tien trong hoa don khi bo thuoc khoi chi tiet hoa don
CREATE TRIGGER trg_CapNhatTongTienHoaDonThuoc_AfterDelete
ON ChiTietHoaDonThuoc
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    -- Cập nhật TongTien cho từng MaHoaDonThuoc bị ảnh hưởng
    UPDATE HDT
    SET HDT.TongTien =
    (
        SELECT ISNULL(SUM(CTHD.SoLuongBan * T.DonGiaBan), 0)
        FROM ChiTietHoaDonThuoc CTHD
        JOIN Thuoc T ON CTHD.MaThuoc = T.MaThuoc
        WHERE CTHD.MaHoaDonThuoc = HDT.MaHoaDonThuoc
    ),
    HDT.NgayLapHoaDon = GETDATE()
    FROM HoaDonThuoc HDT
    JOIN (
        SELECT DISTINCT MaHoaDonThuoc
        FROM deleted
    ) AS D ON HDT.MaHoaDonThuoc = D.MaHoaDonThuoc;
END;

------------------------------------------------------------------------------------
-- TRIGGER Tự động trừ số lượng tồn kho khi thuốc được thêm vào chi tiết hóa đơn  và kiểm tra xem có đủ hàng để bán không.

CREATE TRIGGER TR_ChiTietHoaDonThuoc_AfterInsert_UpdateSoLuongTon
ON ChiTietHoaDonThuoc
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM inserted)     -- Kiểm tra xem có dòng nào được chèn vào không
    BEGIN
        RETURN;
    END
    -- Kiểm tra xem có bất kỳ dòng nào trong đơn hàng có số lượng bán lớn hơn số lượng tồn kho không
    IF EXISTS (
        SELECT 1
        FROM Thuoc T
        INNER JOIN inserted I ON T.MaThuoc = I.MaThuoc
        WHERE T.SoLuongTon < I.SoLuongBan
    )
    BEGIN
        -- Nếu có, tạo một thông báo lỗi cụ thể và hủy giao dịch
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SELECT @ErrorMessage = STRING_AGG(
            CONCAT(N'Thuốc ''', T.TenThuoc, N''' (Mã: ', T.MaThuoc, N') chỉ còn tồn ', T.SoLuongTon, N' nhưng yêu cầu bán ', I.SoLuongBan, '.'),
            CHAR(13) + CHAR(10)
        )
        FROM Thuoc T
        INNER JOIN inserted I ON T.MaThuoc = I.MaThuoc
        WHERE T.SoLuongTon < I.SoLuongBan;
        -- Gửi thông báo lỗi và ROLLBACK lại toàn bộ giao dịch INSERT
        RAISERROR (@ErrorMessage, 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    -- CẬP NHẬT SỐ LƯỢNG TỒN KHO
    UPDATE T
    SET T.SoLuongTon = T.SoLuongTon - I.SoLuongBan
    FROM Thuoc AS T
    INNER JOIN inserted AS I ON T.MaThuoc = I.MaThuoc;

END;
GO

--------------------------------------------------------------------------------------
-- TRIGGER KHI XÓA CHI TIẾT HÓA ĐƠN (HỦY/TRẢ THUỐC)
--  Mục đích: Tự động cộng trả lại số lượng tồn kho khi một chi tiết bán thuốc bị xóa.
CREATE TRIGGER TR_ChiTietHoaDonThuoc_AfterDelete_UpdateSoLuongTon
ON ChiTietHoaDonThuoc
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM deleted)	-- Kiểm tra xem có thực sự có dòng nào bị xóa không
    BEGIN
        RETURN;
    END
    -- Cập nhật lại số lượng tồn kho
    -- Bảng 'deleted' là bảng ảo chứa các dòng vừa bị xóa đi
    UPDATE T
    SET T.SoLuongTon = T.SoLuongTon + D.SoLuongBan
    FROM Thuoc AS T
    INNER JOIN deleted AS D ON T.MaThuoc = D.MaThuoc;
END;
GO

-----------------------------------------------------------------
-- Trigger xử lý hóa đơn dịch vụ
CREATE TRIGGER trg_CapNhatTongTienHoaDonDichVu_AfterInsert
ON ChiTietHoaDonDichVu
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE HDV
    SET HDV.TongTienThanhToan = (
        SELECT SUM(CT.ThanhTien)
        FROM ChiTietHoaDonDichVu CT
        WHERE CT.MaHoaDonDichVu = HDV.MaHoaDonDichVu
    ),
    HDV.NgayLapHoaDon = GETDATE()
    FROM HoaDonDichVu HDV
    JOIN (
        SELECT DISTINCT MaHoaDonDichVu
        FROM inserted
    ) AS I ON HDV.MaHoaDonDichVu = I.MaHoaDonDichVu;
END;


CREATE TRIGGER trg_CapNhatTongTienHoaDonDichVu_AfterDelete
ON ChiTietHoaDonDichVu
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE HDV
    SET HDV.TongTienThanhToan = (
        SELECT ISNULL(SUM(CT.ThanhTien), 0)
        FROM ChiTietHoaDonDichVu CT
        WHERE CT.MaHoaDonDichVu = HDV.MaHoaDonDichVu
    ),
    HDV.NgayLapHoaDon = GETDATE()
    FROM HoaDonDichVu HDV
    JOIN (
        SELECT DISTINCT MaHoaDonDichVu
        FROM deleted
    ) AS D ON HDV.MaHoaDonDichVu = D.MaHoaDonDichVu;
END;


SELECT * FROM HoaDonThuoc
INSERT INTO ChiTietHoaDonThuoc (MaHoaDonThuoc, MaThuoc, SoLuongBan, LieuDung, DonGiaTaiThoiDiem, ThanhTien) VALUES
(1, 'ALPHA', 20, N'Ngày uống 2 lần, mỗi lần 2 viên sau ăn', 1500.00, 30000.00); -- PK 1

DELETE FROM ChiTietHoaDonThuoc where MaHoaDonThuoc = 1;
