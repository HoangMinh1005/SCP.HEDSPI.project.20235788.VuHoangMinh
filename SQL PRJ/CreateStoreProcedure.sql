
--Dùng thủ tục lưu trữ lưu thông tin bệnh nhân mới vào hệ thống: truyền tham số là thông tin của bệnh nhân mới

CREATE PROC usp_AddPatient(
	@HoTen nvarchar(100),
	@NgaySinh DATE,
	@GioiTinh char(1),
	@SoDienThoai varchar(15),
	@email varchar(100),
	@DiaChi nvarchar(255),
	@TienSuDiUng nvarchar(500),
	@NewMaBN INT OUTPUT -- tra ve MaBN moi duoc tao
	)
	AS
	BEGIN
		IF @HoTen IS NULL
		BEGIN
			PRINT N'Họ tên bệnh nhân không được để trống.'
			RETURN;
		END
		IF @GioiTinh NOT IN ('M','F')
		BEGIN
			PRINT N'Giới tính không hợp lệ!'
			RETURN;
		END
		IF EXISTS (select 1 from BenhNhan where SoDienThoai = @SoDienThoai and @SoDienThoai is not null)
		Begin
			PRINT 'SDT da ton tai'
			return;
		end
		BEGIN 
			INSERT INTO BenhNhan(
			HoTen,
            NgaySinh,
            GioiTinh,
            SoDienThoai,
            Email,
            DiaChi,
            TienSuDiUng,
            NgayTaoHoSo 
			)
			Values(
			@HoTen,
            @NgaySinh,
            @GioiTinh,
            @SoDienThoai,
            @Email,
            @DiaChi,
            @TienSuDiUng,
			GETDATE()
			);
			SET @NewMaBN = SCOPE_IDENTITY()-- Lấy ID của bản ghi vừa chèn 
			PRINT 'da tao thanh cong benh nhan moi co ma: '
			PRINT CONVERT(varchar(6), @NewMaBN)
		END
	END;
	------------------------------------------------------------------------
	CREATE INDEX idx_BenhNhan_SoDienThoai ON BenhNhan(SoDienThoai);
	CREATE INDEX idx_tenThuoc on Thuoc(TenThuoc)

-- Thay đổi thông tin bệnh nhân 
	CREATE PROCEDURE usp_UpdatePatient(
    @MaBN INT,
    @HoTenBN NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh CHAR(1),
    @SoDienThoai VARCHAR(15),
    @Email VARCHAR(100),
    @DiaChi NVARCHAR(255),
    @TienSuDiUng NVARCHAR(500)
)
AS
BEGIN

    -- Kiểm tra MaBN có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM BenhNhan WHERE MaBenhNhan = @MaBN)
    BEGIN
        RAISERROR(N'Không tìm thấy bệnh nhân.', 16, 1);
        RETURN;
    END
    -- Kiểm tra SĐT/Email mới có bị trùng với người khác không
    IF @SoDienThoai IS NOT NULL AND EXISTS (SELECT 1 FROM BenhNhan WHERE SoDienThoai = @SoDienThoai AND MaBenhNhan <> @MaBN)
    BEGIN
        RAISERROR(N'Số điện thoại mới đã được sử dụng bởi bệnh nhân khác.', 16, 1);
        RETURN;
    END
    IF @Email IS NOT NULL AND EXISTS (SELECT 1 FROM BenhNhan WHERE Email = @Email AND MaBenhNhan <> @MaBN)
    BEGIN
        RAISERROR(N'Email mới đã được sử dụng bởi bệnh nhân khác.', 16, 1);
        RETURN;
    END
    BEGIN TRY
        UPDATE BenhNhan
        SET HoTen = @HoTenBN,
            NgaySinh = @NgaySinh,
            GioiTinh = @GioiTinh,
            SoDienThoai = @SoDienThoai,
            Email = @Email,
            DiaChi = @DiaChi,
            TienSuDiUng = @TienSuDiUng
        WHERE MaBenhNhan = @MaBN;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- TEST 
DECLARE @NewMaBN_Output INT;
EXEC usp_AddPatient
    @HoTen = N'Nguyễn Văn An',       -- Họ tên có dấu tiếng Việt
    @NgaySinh = '1990-05-15',
    @GioiTinh = 'M',
    @SoDienThoai = '0901234567',
    @email = 'an.nguyen@email.com',
    @DiaChi = N'123 Đường ABC, Quận 1, TP. HCM',
    @TienSuDiUng = N'Dị ứng với phấn hoa',
    @NewMaBN = @NewMaBN_Output OUTPUT;

SELECT @NewMaBN_Output AS MaBenhNhanMoiTao; -- Hiển thị mã bệnh nhân mới
GO


DECLARE @NewMaBN_Output INT;
EXEC usp_AddPatient
    @HoTen = NULL,
    @NgaySinh = '1992-08-20',
    @GioiTinh = 'F',
    @SoDienThoai = '0987654321',
    @email = 'binh.tran@email.com',
    @DiaChi = N'456 Đường XYZ, Quận 2, TP. HCM',
    @TienSuDiUng = N'Không có',
    @NewMaBN = @NewMaBN_Output OUTPUT;
GO
-- Sẽ có thông báo lỗi từ PRINT trong stored procedure

DECLARE @NewMaBN_Output INT;
EXEC usp_AddPatient
    @HoTen = N'Trần Thị Bình',
    @NgaySinh = '1992-08-20',
    @GioiTinh = 'X', -- Giới tính không hợp lệ
    @SoDienThoai = '0912345678',
    @email = 'binh.tran2@email.com',
    @DiaChi = N'789 Đường LMN, Quận 3, TP. HCM',
    @TienSuDiUng = N'Không có',
    @NewMaBN = @NewMaBN_Output OUTPUT;
GO
-- Sẽ có thông báo lỗi từ PRINT


DECLARE @NewMaBN_Output INT;
EXEC usp_AddPatient
    @HoTen = N'Lê Văn Cường',
    @NgaySinh = '1985-11-10',
    @GioiTinh = 'M',
    @SoDienThoai = '0901234567', -- Số điện thoại trùng
    @email = 'cuong.le@email.com',
    @DiaChi = N'101 Đường OPQ, Quận 4, TP. HCM',
    @TienSuDiUng = N'Dị ứng hải sản',
    @NewMaBN = @NewMaBN_Output OUTPUT;
GO
-- Sẽ có thông báo lỗi từ PRINT

-------------------------------------------------------------
--Chức năng: Thêm nhân viên
CREATE PROCEDURE usp_ThemNhanVien
    @HoTen NVARCHAR(100),
    @GioiTinh NVARCHAR(10), -- 'M', 'F', 'Khác'
    @NgaySinh DATE,
    @SoDienThoai VARCHAR(15),
    @Email VARCHAR(100),
    @VaiTro NVARCHAR(50),
    @TenDangNhap VARCHAR(50),
    @MatKhau VARCHAR(255) 
AS
BEGIN
    SET NOCOUNT ON;
    -- Kiểm tra trùng lặp
    IF EXISTS (SELECT 1 FROM NhanVien WHERE TenDangNhap = @TenDangNhap)
    BEGIN
        RAISERROR(N'Tên đăng nhập đã tồn tại.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM NhanVien WHERE Email = @Email)
    BEGIN
        RAISERROR(N'Email đã tồn tại.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM NhanVien WHERE SoDienThoai = @SoDienThoai)
    BEGIN
        RAISERROR(N'Số điện thoại đã tồn tại.', 16, 1);
        RETURN;
    END
    -- Lưu ý: Nếu muốn hash mật khẩu, có thể dùng HASHBYTES hoặc thực hiện ở phía ứng dụng
    INSERT INTO NhanVien (
        HoTen, GioiTinh, NgaySinh, SoDienThoai,
        Email, VaiTro, TenDangNhap, MatKhau
    )
    VALUES (
        @HoTen, @GioiTinh, @NgaySinh, @SoDienThoai,
        @Email, @VaiTro, @TenDangNhap, @MatKhau
    );

    PRINT N'Thêm nhân viên thành công.';
END;

--Chức năng: Vô hiệu hóa tài khoản nhân viên
CREATE PROCEDURE usp_NgungHoatDongNhanVien
    @MaNhanVien INT = NULL,
    @TenDangNhap NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NhanVienID INT;

    IF @MaNhanVien IS NOT NULL
        SELECT @NhanVienID = MaNhanVien FROM NhanVien WHERE MaNhanVien = @MaNhanVien;
    ELSE IF @TenDangNhap IS NOT NULL
        SELECT @NhanVienID = MaNhanVien FROM NhanVien WHERE TenDangNhap = @TenDangNhap;

    IF @NhanVienID IS NULL
    BEGIN
        RAISERROR(N'Không tìm thấy nhân viên.', 16, 1);
        RETURN;
    END

    -- Cập nhật trạng thái
    UPDATE NhanVien
    SET TrangThai = N'Ngừng hoạt động'
    WHERE MaNhanVien = @NhanVienID;

    PRINT N'Đã cập nhật trạng thái: Ngừng hoạt động.';
END;
--TEST 
EXEC usp_ThemNhanVien
    @HoTen = N'Nguyễn Văn B',
    @GioiTinh = N'M',
    @NgaySinh = '1990-01-01',
    @SoDienThoai = '0901234568',
    @Email = 'vanb@example.com',
    @VaiTro = N'Bác sĩ',
    @TenDangNhap = 'nguyenvanb',
    @MatKhau = 'MatKhau123';

EXEC usp_NgungHoatDongNhanVien @MaNhanVien = 10;

EXEC usp_NgungHoatDongNhanVien @TenDangNhap = 'nguyenvana';
--------------------------------------------------------------------
--Chức năng: Thêm dịch vụ
CREATE PROCEDURE usp_ThemDichVuYTe
    @TenDichVu NVARCHAR(100),
    @LoaiDichVu NVARCHAR(100),
    @DonGia DECIMAL(10,2),
    @MoTa NVARCHAR(255) = NULL,
    @TrangThaiKhaDung NVARCHAR(50) = N'Đang hoạt động'
AS
BEGIN
    SET NOCOUNT ON;
    IF @DonGia <= 0
    BEGIN
        RAISERROR(N'Đơn giá phải lớn hơn 0.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM DichVuYTe WHERE TenDichVu = @TenDichVu)
    BEGIN
        RAISERROR(N'Tên dịch vụ đã tồn tại.', 16, 1);
        RETURN;
    END
    INSERT INTO DichVuYTe (TenDichVu, LoaiDichVu, DonGia, MoTa, TrangThaiKhaDung)
    VALUES (@TenDichVu, @LoaiDichVu, @DonGia, @MoTa, @TrangThaiKhaDung);
    PRINT N'Thêm dịch vụ thành công.';
END;

-- Chức năng: Sửa thông tin dịch vụ
CREATE PROCEDURE usp_CapNhatDichVuYTe
    @MaDichVu INT,
    @TenDichVu NVARCHAR(100) = NULL,
    @LoaiDichVu NVARCHAR(100) = NULL,
    @DonGia DECIMAL(10,2) = NULL,
    @MoTa NVARCHAR(255) = NULL,
    @TrangThaiKhaDung NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM DichVuYTe WHERE MaDichVu = @MaDichVu)
    BEGIN
        RAISERROR(N'Dịch vụ không tồn tại.', 16, 1);
        RETURN;
    END
    IF @TenDichVu IS NOT NULL
    BEGIN
        IF EXISTS (
            SELECT 1 FROM DichVuYTe
            WHERE TenDichVu = @TenDichVu AND MaDichVu <> @MaDichVu
        )
        BEGIN
            RAISERROR(N'Tên dịch vụ đã tồn tại.', 16, 1);
            RETURN;
        END
    END
	 IF @DonGia <= 0
    BEGIN
        RAISERROR(N'Đơn giá phải lớn hơn 0.', 16, 1);
        RETURN;
    END
    UPDATE DichVuYTe
    SET
        TenDichVu = ISNULL(@TenDichVu, TenDichVu),
        LoaiDichVu = ISNULL(@LoaiDichVu, LoaiDichVu),
        DonGia = ISNULL(@DonGia, DonGia),
        MoTa = ISNULL(@MoTa, MoTa),
        TrangThaiKhaDung = ISNULL(@TrangThaiKhaDung, TrangThaiKhaDung)
    WHERE MaDichVu = @MaDichVu;
    PRINT N'Cập nhật dịch vụ thành công.';
END;

--Chức năng: Vô hiệu hóa dịch vụ
CREATE PROCEDURE usp_NgungSuDungDichVuYTe
    @MaDichVu INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM DichVuYTe WHERE MaDichVu = @MaDichVu)
    BEGIN
        RAISERROR(N'Dịch vụ không tồn tại.', 16, 1);
        RETURN;
    END
    UPDATE DichVuYTe
    SET TrangThaiKhaDung = N'Ngưng hoạt động'
    WHERE MaDichVu = @MaDichVu;
    PRINT N'Cập nhật trạng thái thành công: Dịch vụ đã được ngừng sử dụng.';
END;
--TEST
EXEC usp_ThemDichVuYTe
    @TenDichVu = N'Khám tim mạch',
    @LoaiDichVu = N'Khám bệnh',
    @DonGia = 300000,
    @MoTa = N'Khám tổng quát tim mạch và huyết áp',
    @TrangThaiKhaDung = N'Đang hoạt động';

EXEC usp_CapNhatDichVuYTe
    @MaDichVu = 2,
    @DonGia = 370000,
    @MoTa = N'Cập nhật: bao gồm công thức máu + mỡ máu + đường huyết';

EXEC usp_NgungSuDungDichVuYTe @MaDichVu = 7;

----------------------------------------------------------------------------------
--Chức năng tra cứu chi tiết/ danh sách hóa đơn dich vu
CREATE PROCEDURE usp_TraCuuHoaDonDichVu
    @MaHoaDonDichVu INT = NULL,
    @TuNgay DATE = NULL,
    @DenNgay DATE = NULL,
    @HinhThucThanhToan NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Truy vấn danh sách hóa đơn dịch vụ
    SELECT
        HDV.MaHoaDonDichVu,
        HDV.NgayLapHoaDon,
        HDV.TongTienThanhToan,
        HDV.HinhThucThanhToan
    FROM HoaDonDichVu HDV
    WHERE (@MaHoaDonDichVu IS NULL OR HDV.MaHoaDonDichVu = @MaHoaDonDichVu)
      AND (@TuNgay IS NULL OR HDV.NgayLapHoaDon >= @TuNgay)
      AND (@DenNgay IS NULL OR HDV.NgayLapHoaDon <= @DenNgay)
      AND (@HinhThucThanhToan IS NULL OR HDV.HinhThucThanhToan = @HinhThucThanhToan);

    -- Nếu truyền mã hóa đơn cụ thể thì hiển thị chi tiết dịch vụ
    IF @MaHoaDonDichVu IS NOT NULL
    BEGIN
        SELECT
            DV.TenDichVu,
            CT.DonGiaTaiThoiDiem,
            CT.ThanhTien,
            CT.KetQuaDichVu
        FROM ChiTietHoaDonDichVu CT
        JOIN DichVuYTe DV ON CT.MaDichVu = DV.MaDichVu
        WHERE CT.MaHoaDonDichVu = @MaHoaDonDichVu;
    END
END;
--TEST
EXEC usp_TraCuuHoaDonDichVu @TuNgay = '2023-01-01', @DenNgay = '2025-01-31';
GO


------------------------------------------------------------------------------------
--Ban thuoc
--Chức năng tra cứu chi tiết/ danh sách hóa đơn thuốc
CREATE PROCEDURE usp_TraCuuHoaDonThuoc
	@MaHoaDonThuoc INT = NULL,
	@TuNgay DATE = NULL,
	@DenNgay DATE = NULL,
	@HinhThucThanhToan NVARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Truy vấn danh sách hóa đơn
	SELECT
        HDT.MaHoaDonThuoc,
        HDT.NgayLapHoaDon,
        HDT.TongTien,
        HDT.HinhThucThanhToan
	FROM HoaDonThuoc HDT
	WHERE (@MaHoaDonThuoc IS NULL OR HDT.MaHoaDonThuoc = @MaHoaDonThuoc)
  	  AND (@TuNgay IS NULL OR HDT.NgayLapHoaDon >= @TuNgay)
  	  AND (@DenNgay IS NULL OR HDT.NgayLapHoaDon <= @DenNgay)
  	  AND (@HinhThucThanhToan IS NULL OR HDT.HinhThucThanhToan = @HinhThucThanhToan);

	-- Nếu có truyền mã hóa đơn cụ thể, hiển thị chi tiết thuốc
	IF @MaHoaDonThuoc IS NOT NULL
	BEGIN
    	SELECT
            T.TenThuoc,
            CT.SoLuongBan,
            CT.DonGiaTaiThoiDiem,
            CT.ThanhTien,
            CT.LieuDung
    	FROM ChiTietHoaDonThuoc CT
    	JOIN Thuoc T ON CT.MaThuoc = T.MaThuoc
    	WHERE CT.MaHoaDonThuoc = @MaHoaDonThuoc;
	END
END
 -- Chức năng hủy đơn thuốc
CREATE PROCEDURE usp_HuyHoaDonThuoc
	@MaHoaDonThuoc INT
AS
BEGIN
	SET NOCOUNT ON;
	IF NOT EXISTS (
    	SELECT 1 FROM HoaDonThuoc WHERE MaHoaDonThuoc = @MaHoaDonThuoc -- Kiểm tra hóa đơn có tồn tại
	)
	BEGIN
        RAISERROR(N'Hóa đơn không tồn tại.', 16, 1);
    	RETURN;
	END
	BEGIN TRY
    	BEGIN TRANSACTION;
    	-- Hoàn lại tồn kho thuốc
    	UPDATE T
    	SET T.SoLuongTon = T.SoLuongTon + CT.SoLuongBan
    	FROM Thuoc T
    	JOIN ChiTietHoaDonThuoc CT ON T.MaThuoc = CT.MaThuoc
    	WHERE CT.MaHoaDonThuoc = @MaHoaDonThuoc;
    	-- Xóa các dòng liên kết thuốc trong hóa đơn
    	DELETE FROM ChiTietHoaDonThuoc
    	WHERE MaHoaDonThuoc = @MaHoaDonThuoc;
    	-- Xóa hóa đơn
    	DELETE FROM HoaDonThuoc
    	WHERE MaHoaDonThuoc = @MaHoaDonThuoc;
 
    	COMMIT TRANSACTION;
    	PRINT N'Hủy hóa đơn thành công.';
	END TRY
	BEGIN CATCH
    	ROLLBACK TRANSACTION;
    	DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
	END CATCH
END

---test 
EXEC usp_TraCuuHoaDonThuoc @MaHoaDonThuoc = 2;
EXEC usp_HuyHoaDonThuoc @MaHoaDonThuoc = 2;

-----------------------------------------------------
--Chức năng: Thêm thuốc vào kho
CREATE PROC usp_AddMedicine(
		@MaThuoc  varchar(20),
		@TenThuoc varchar(100),
		@DonViTinh varchar(50),
		@DonGiaBan decimal(18,2),
		@SoLuongNhap int,
		@HamLuong varchar(50),
		@GhiChuSuDung nvarchar(200) --optional
		--tra lai ma thuoc moi sau khi add thanh cong
	)
	AS
	BEGIN
		DECLARE @ErrorMessage NVARCHAR(4000);
		IF @TenThuoc IS NULL
		Begin 
			SET @ErrorMessage = N'Tên thuốc không được để trống.';
			RAISERROR(@ErrorMessage, 16, 1);
			RETURN; 
		End 
		IF EXISTS (select 1 from Thuoc where TenThuoc = @TenThuoc and @TenThuoc is not null)
		Begin
			SET @ErrorMessage = N'Tên thuốc "' + @TenThuoc + N'" đã tồn tại trong hệ thống.';
			RAISERROR(@ErrorMessage, 16, 1);
			RETURN; -- Kết thúc SP
		End 
		IF @DonGiaBan IS NOT NULL AND @DonGiaBan < 0
		BEGIN
        SET @ErrorMessage = N'Đơn giá bán không thể là số âm.';
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
		END
		IF @SoLuongNhap < 0
		BEGIN
        SET @ErrorMessage = N'Số lượng nhập không thể là số âm.';
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
		END
		Begin  
			INSERT INTO Thuoc(
				MaThuoc,
				    TenThuoc,
				    DonViTinh,
					DonGiaBan,
					SoLuongTon,
					HamLuong,
					GhiChu
			)
			VALUES(
				@MaThuoc,
				@TenThuoc,
				@DonViTinh,
				@DonGiaBan,
				@SoLuongNhap,
				@HamLuong,
				@GhiChuSuDung
			)
			PRINT N'Đã thêm thành công thuốc mới vào hệ thống. Mã thuốc: ' + @MaThuoc;
		End
	END

--Chức năng: Thay đổi thông tin thuốc trong kho

CREATE PROCEDURE usp_UpdateThuocInfo
    -- Tham số đầu vào
    @MaThuoc VARCHAR(20),                       -- Bắt buộc: Mã thuốc cần cập nhật
    @TenThuoc NVARCHAR(150) = NULL,             -- Không bắt buộc: Tên mới của thuốc
    @DonViTinh NVARCHAR(20) = NULL,             -- Không bắt buộc: Đơn vị tính mới
    @DonGiaBan DECIMAL(18, 2) = NULL,           -- Không bắt buộc: Đơn giá bán mới
    @HamLuong NVARCHAR(50) = NULL,              -- Không bắt buộc: Hàm lượng mới
    @GhiChu NVARCHAR(500) = NULL                -- Không bắt buộc: Ghi chú mới
AS
BEGIN
    SET NOCOUNT ON; -- Ngăn chặn trả về số dòng bị ảnh hưởng

    -- BƯỚC 1: KIỂM TRA ĐẦU VÀO 
    IF NOT EXISTS (SELECT 1 FROM Thuoc WHERE MaThuoc = @MaThuoc)
    BEGIN
        RAISERROR (N'Lỗi: Không tìm thấy thuốc với mã [%s]. Không thể thực hiện cập nhật.', 16, 1, @MaThuoc);
        RETURN; -- Dừng thực thi
    END

    IF @DonGiaBan IS NOT NULL AND @DonGiaBan < 0
    BEGIN
        RAISERROR (N'Lỗi: Đơn giá bán không thể là một số âm.', 16, 1);
        RETURN;
    END

    -- BƯỚC 2: THỰC HIỆN CẬP NHẬT
    BEGIN TRY
        UPDATE Thuoc
        SET
            -- Giữ lại giá trị cũ nếu tham số truyền vào là NULL
            TenThuoc    = ISNULL(@TenThuoc, TenThuoc),
            DonViTinh   = ISNULL(@DonViTinh, DonViTinh),
            DonGiaBan   = ISNULL(@DonGiaBan, DonGiaBan),
            HamLuong    = ISNULL(@HamLuong, HamLuong),
            GhiChu      = ISNULL(@GhiChu, GhiChu)
        WHERE
            MaThuoc = @MaThuoc;
        PRINT N'Cập nhật thông tin cho thuốc có mã ''' + @MaThuoc + N''' thành công.';
        SELECT * FROM Thuoc WHERE MaThuoc = @MaThuoc;

    END TRY
    BEGIN CATCH
        RAISERROR (N'Đã có lỗi xảy ra trong quá trình cập nhật. Vui lòng thử lại.', 16, 1);
    END CATCH
END
GO

--TEST
EXEC usp_UpdateThuocInfo
    @MaThuoc = 'PARA500',
    @TenThuoc = NULL,
    @DonGiaBan = 999.00;

EXEC usp_AddMedicine
    @MaThuoc = 'IBU400',
    @TenThuoc = N'Ibuprofen 400mg',
    @DonViTinh = N'Viên',
    @DonGiaBan = 2500.00,
    @SoLuongNhap = 1000,
    @HamLuong = N'400mg',
    @GhiChuSuDung = N'Giảm đau, kháng viêm. Uống sau khi ăn.';

-- Ngay sau đó, kiểm tra xem thuốc đã có trong bảng chưa
SELECT * FROM Thuoc WHERE MaThuoc = 'IBU400';

--------------------------------------------------------------
--Chức năng báo cáo 
    --Chức năng báo cáo danh sách bệnh nhân
CREATE PROCEDURE usp_BaoCaoDanhSachBenhNhan
	@TuNgay DATE,
	@DenNgay DATE
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
    	BN.MaBenhNhan,
    	BN.HoTen,
        BN.SoDienThoai,
    	BN.Email,
        BN.TienSuDiUng,
    	BN.NgayTaoHoSo
	FROM
    	BenhNhan BN
	WHERE
    	BN.NgayTaoHoSo BETWEEN @TuNgay AND @DenNgay
	ORDER BY
    	BN.NgayTaoHoSo DESC;
END


-- Báo cáo bệnh nhân đến khám từ 01/01/2023 đến 31/12/2025
EXEC usp_BaoCaoDanhSachBenhNhan @TuNgay = '2023-01-01', @DenNgay = '2025-12-31';




 Chức năng báo cáo doanh thu bán thuốc
CREATE PROCEDURE usp_BaoCaoDoanhThuBanThuoc
	@TuNgay DATE,
	@DenNgay DATE,
	@MaThuoc VARCHAR(20)= NULL,           	-- Tùy chọn lọc theo mã thuốc
	@TenThuoc NVARCHAR(100) = NULL 	-- Tùy chọn lọc theo tên thuốc
AS
BEGIN
	SET NOCOUNT ON;
 
	SELECT
    	T.MaThuoc,
    	T.TenThuoc,
        SUM(CT.SoLuongBan) AS TongSoLuongBan,
        SUM(CT.ThanhTien) AS TongDoanhThu
	FROM
    	HoaDonThuoc HDT
	JOIN
    	ChiTietHoaDonThuoc CT ON HDT.MaHoaDonThuoc = CT.MaHoaDonThuoc
	JOIN
    	Thuoc T ON CT.MaThuoc = T.MaThuoc
	WHERE
        HDT.NgayLapHoaDon BETWEEN @TuNgay AND @DenNgay
    	AND (@MaThuoc IS NULL OR T.MaThuoc = @MaThuoc)
    	AND (@TenThuoc IS NULL OR T.TenThuoc LIKE N'%' + @TenThuoc + '%')
	GROUP BY
    	T.MaThuoc, T.TenThuoc
	ORDER BY
    	TongDoanhThu DESC;
END


EXEC usp_BaoCaoDoanhThuBanThuoc 
    @TuNgay = '2023-01-01', 
    @DenNgay = '2025-12-31';

	EXEC usp_BaoCaoDoanhThuBanThuoc 
    @TuNgay = '2024-01-01', 
    @DenNgay = '2024-12-31', 
    @MaThuoc = 'PARA500';
 
 
--  Chức năng báo cáo dịch vụ y tế đã sử dụng
CREATE PROCEDURE usp_BaoCaoDichVuYTeDaSuDung 
	@TuNgay DATE,
	@DenNgay DATE,
	@MaDichVu INT = NULL,             	-- Tùy chọn lọc theo mã dịch vụ
	@TenDichVu NVARCHAR(100) = NULL   	-- Tùy chọn lọc theo tên dịch vụ
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
    	DV.MaDichVu,
    	DV.TenDichVu,
    	COUNT(*) AS TongLuotChiTietHoaDonDichVu,
        SUM(ISNULL(CT.ThanhTien, 0)) AS TongDoanhThu
	FROM
    	ChiTietHoaDonDichVu CT
	INNER JOIN
    	DichVuYTe DV ON CT.MaDichVu = DV.MaDichVu
	INNER JOIN
    	PhieuKham PK ON CT.MaHoaDonDichVu = PK.MaHoaDonDichVu
	WHERE
        PK.NgayKham BETWEEN @TuNgay AND @DenNgay
    	AND (@MaDichVu IS NULL OR DV.MaDichVu = @MaDichVu)
    	AND (@TenDichVu IS NULL OR DV.TenDichVu LIKE N'%' + @TenDichVu + '%')
	GROUP BY
    	DV.MaDichVu, DV.TenDichVu
	ORDER BY
    	TongLuotChiTietHoaDonDichVu DESC;
END



EXEC usp_BaoCaoDichVuYTeDaSuDung 
    @TuNgay = '2023-01-01',
    @DenNgay = '2025-06-07',
    @MaDichVu = NULL,
    @TenDichVu = N'Xét nghiệm';
 
 
   -- Chức năng báo cáo thuốc tồn kho
CREATE PROCEDURE usp_BaoCaoTonKhoThuoc
	@TenThuoc NVARCHAR(100) = NULL,	-- Tùy chọn lọc theo tên thuốc
	@NguongTon INT = NULL          	-- Tùy chọn lọc các thuốc có tồn kho dưới ngưỡng
AS
BEGIN
	SET NOCOUNT ON;
 
	SELECT
    	MaThuoc,
    	TenThuoc,
    	SoLuongTon,
    	DonGiaBan
	FROM
    	Thuoc
	WHERE
    	(@TenThuoc IS NULL OR TenThuoc LIKE N'%' + @TenThuoc + '%')
    	AND (@NguongTon IS NULL OR SoLuongTon < @NguongTon)
	ORDER BY
    	SoLuongTon ASC;
END
 


 EXEC usp_BaoCaoTonKhoThuoc;

 EXEC usp_BaoCaoTonKhoThuoc @TenThuoc = N'Para', @NguongTon = 10;

 
 --Chức năng báo cáo hoạt động nhân viên

 CREATE PROCEDURE usp_BaoCaoHoatDongNhanVien
	@MaNhanVien NVARCHAR(20) = NULL,   -- Tùy chọn lọc theo mã nhân viên
	@TenNhanVien NVARCHAR(100) = NULL, -- Tùy chọn lọc theo tên
	@TuNgay DATE = NULL,
	@DenNgay DATE = NULL
AS
BEGIN
	SET NOCOUNT ON;
 
	SELECT
    	nv.MaNhanVien,
    	nv.HoTen,
    	COUNT(DISTINCT lh.MaLichHen) AS SoLichHenDaLap,
    	COUNT(DISTINCT pk.MaPhieuKham) AS SoPhieuKhamDaThucHien
	FROM
    	NhanVien nv
	LEFT JOIN
    	LichHen lh ON lh.MaNhanVien = nv.MaNhanVien
        	AND (@TuNgay IS NULL OR lh.ThoiGianHen >= @TuNgay)
        	AND (@DenNgay IS NULL OR lh.ThoiGianHen <= @DenNgay)
	LEFT JOIN
    	PhieuKham pk ON pk.MaBacSi = nv.MaNhanVien
        	AND (@TuNgay IS NULL OR pk.NgayKham >= @TuNgay)
        	AND (@DenNgay IS NULL OR pk.NgayKham <= @DenNgay)
	WHERE
    	(@MaNhanVien IS NULL OR nv.MaNhanVien = @MaNhanVien)
    	AND (@TenNhanVien IS NULL OR nv.HoTen LIKE N'%' + @TenNhanVien + '%')
	GROUP BY
    	nv.MaNhanVien, nv.HoTen
	ORDER BY
        SoPhieuKhamDaThucHien DESC, SoLichHenDaLap DESC;
END


EXEC usp_BaoCaoHoatDongNhanVien 
    @TuNgay = '2023-01-01', 
    @DenNgay = '2025-06-07';


