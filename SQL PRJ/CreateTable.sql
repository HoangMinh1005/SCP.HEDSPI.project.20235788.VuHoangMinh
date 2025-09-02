
--chuyen khoa
CREATE TABLE ChuyenKhoa (
    MaKhoa INT IDENTITY(1,1) NOT NULL,
    TenKhoa NVARCHAR(100) NOT NULL,
    DiaChiKhoa NVARCHAR(255),
    PRIMARY KEY (MaKhoa)
);

--nhan vien: bac si, y ta, duoc si
CREATE TABLE NhanVien (
    MaNhanVien  INT IDENTITY(1,1) NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    GioiTinh char(1) NOT NULL CHECK (GioiTinh = 'M' or GioiTinh = 'F'),
    NgaySinh DATE,
    TenDangNhap VARCHAR(50) UNIQUE, -- Tên đăng nhập nên là duy nhất
    MatKhau VARCHAR(255) NOT NULL, -- Nên lưu trữ mật khẩu đã được hash
    VaiTro NVARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    SoDienThoai VARCHAR(15),
    DiaChi varchar(100),
    MaKhoa INT,
	TrangThai varchar(50),
    PRIMARY KEY (MaNhanVien),
    FOREIGN KEY (MaKhoa) REFERENCES ChuyenKhoa(MaKhoa)
    
);

CREATE TABLE BenhNhan (
    MaBenhNhan  INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE,
    GioiTinh char(1)NOT NULL check(GioiTinh = 'M' or GioiTinh ='F'),
    SoDienThoai VARCHAR(15) UNIQUE, -- Số điện thoại là duy nhất
    Email VARCHAR(100) NULL, --email co the la optional
    DiaChi NVARCHAR(255),	--thanh pho, xa phuong
    TienSuDiUng NVARCHAR(500),
    NgayTaoHoSo DATE,
   
);
-- dich vu y te
CREATE TABLE DichVuYTe (
    MaDichVu INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TenDichVu NVARCHAR(150) NOT NULL,
    DonGia DECIMAL(10, 2),
    LoaiDichVu NVARCHAR(50),
    MoTa NVARCHAR(500),
    TrangThaiKhaDung NVARCHAR(50) -- Ví dụ: 'Đang hoạt động', 'Ngừng hoạt động'
    
);

CREATE TABLE HoaDonDichVu (
    MaHoaDonDichVu INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NgayLapHoaDon DATE,
    TongTienThanhToan DECIMAL(18, 2) NULL,
    HinhThucThanhToan NVARCHAR(50) NULL,
    MaNhanVien INT, -- Nhân viên thu ngân/lập hóa đơn
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)
CREATE TABLE ChiTietHoaDonDichVu (
    MaChiTietHoaDonDichVu INT IDENTITY(1,1) NOT NULL  PRIMARY KEY, 
    MaHoaDonDichVu INT NOT NULL, -- Khóa ngoại đến HoaDonDichVu
    MaDichVu INT NOT NULL,
    DonGiaTaiThoiDiem DECIMAL(18, 2), -- Giá dịch vụ tại lúc thực hiện
    KetQuaDichVu NVARCHAR(1000),
    ThanhTien DECIMAL(18, 2),
  
    FOREIGN KEY (MaHoaDonDichVu) REFERENCES HoaDonDichVu(MaHoaDonDichVu)
        ON DELETE CASCADE -- Nếu xóa hóa đơn thì xóa chi tiết
        ON UPDATE CASCADE,
    FOREIGN KEY (MaDichVu) REFERENCES DichVuYTe(MaDichVu)
 
);

--phieu kham
CREATE TABLE PhieuKham (
    MaPhieuKham  INT IDENTITY(1,1) NOT NULL  PRIMARY KEY ,
    ThoiGianBatDauKham TIME,
    NgayKham DATE, -- Thêm ngày khám để dễ quản lý
    ChanDoan NVARCHAR(1000),
    LyDoKham NVARCHAR(500),
    KetQuaLamSang NVARCHAR(1000),
    PhuongPhapDieuTri NVARCHAR(1000),
    TrangThaiPhieu NVARCHAR(50), -- Ví dụ: 'Chờ khám', 'Đang khám', 'Hoàn thành', 'Đã hủy'
    MaBenhNhan INT NOT NULL,
    MaBacSi INT NOT NULL, -- MaNV của Bác sĩ
    MaHoaDonDichVu INT NULL, -- Liên kết đến hóa đơn dịch vụ nếu có
    FOREIGN KEY (MaBenhNhan) REFERENCES BenhNhan(MaBenhNhan),
    FOREIGN KEY (MaBacSi) REFERENCES NhanVien(MaNhanVien),
    FOREIGN KEY (MaHoaDonDichVu) REFERENCES HoaDonDichVu(MaHoaDonDichVu)
        ON DELETE SET NULL -- Nếu hóa đơn dịch vụ bị xóa, phiếu khám không nhất thiết bị xóa
        ON UPDATE CASCADE
);


--lich hen
CREATE TABLE LichHen (
    MaLichHen  INT IDENTITY(1,1) NOT NULL,
    ThoiGianHen DATETIME NOT NULL,
    TrangThaiLichHen NVARCHAR(50), -- Ví dụ: 'Chờ xác nhận', 'Đã xác nhận', 'Đã đến', 'Đã hủy'
    LyDoHenKham NVARCHAR(500),
    GhiChu NVARCHAR(500),
    MaBenhNhan int NOT NULL,
    MaPhieuKham INT NULL, -- Liên kết đến phiếu khám nếu lịch hẹn này đã được xử lý
    MaNhanVien INT, -- Nhân viên tạo/phụ trách lịch hẹn (lễ tân)
    PRIMARY KEY (MaLichHen),
    FOREIGN KEY (MaBenhNhan) REFERENCES BenhNhan(MaBenhNhan)
        ON DELETE CASCADE -- Nếu xóa bệnh nhân, xóa lịch hẹn 
        ON UPDATE CASCADE,
    FOREIGN KEY (MaPhieuKham) REFERENCES PhieuKham(MaPhieuKham)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
--thuoc
CREATE TABLE Thuoc (
    MaThuoc VARCHAR(20) NOT NULL  PRIMARY KEY ,
    TenThuoc NVARCHAR(150) NOT NULL,
    DonViTinh NVARCHAR(20),
    DonGiaBan DECIMAL(18, 2),
    SoLuongTon BIGINT, -- Có thể là INT nếu số lượng không quá lớn
    HamLuong NVARCHAR(50),
    GhiChu NVARCHAR(500)

);

CREATE TABLE HoaDonThuoc (
    MaHoaDonThuoc INT IDENTITY(1,1) NOT NULL PRIMARY KEY ,
    NgayLapHoaDon DATE NOT NULL,
    TongTien DECIMAL(18, 2) NULL,
    HinhThucThanhToan NVARCHAR(50) NULL,
    MaNhanVien INT, -- Nhân viên thu ngân/lập hóa đơn
    MaPhieuKham INT NOT NULL, -- Mã Phiếu Khám liên quan
     FOREIGN KEY (MaNhanVien ) REFERENCES NhanVien(MaNhanVien ),
    FOREIGN KEY (MaPhieuKham) REFERENCES PhieuKham(MaPhieuKham)
        
);

CREATE TABLE ChiTietHoaDonThuoc (
    MaChiTietHoaDonThuoc INT identity(1,1) NOT NULL PRIMARY KEY,
    MaHoaDonThuoc INT NOT NULL,
    MaThuoc VARCHAR(20) NOT NULL,
    SoLuongBan INT NOT NULL,
    LieuDung NVARCHAR(255),
    DonGiaTaiThoiDiem DECIMAL(18,2) NOT NULL, -- Giá thuốc tại thời điểm bán
    ThanhTien DECIMAL(18, 2) NOT NULL,

    FOREIGN KEY (MaHoaDonThuoc) REFERENCES HoaDonThuoc(MaHoaDonThuoc)
        ON DELETE CASCADE -- Nếu xóa hóa đơn thì xóa chi tiết
        ON UPDATE CASCADE,
    FOREIGN KEY (MaThuoc) REFERENCES Thuoc(MaThuoc)
);


-----------------------------------------------------------


