USE `session03_qlct` ;
-- EX2
ALTER TABLE `building`
ADD CONSTRAINT `fk_building_host`
FOREIGN KEY (`host_id`) REFERENCES `host`(`id`);

-- Thêm khóa ngoại `contractor_id` vào bảng `building`
ALTER TABLE `building`
ADD CONSTRAINT `fk_building_contractor`
FOREIGN KEY (`contractor_id`) REFERENCES `contractor`(`id`);

-- Thêm khóa ngoại `building_id` và `architect_id` vào bảng `design`
ALTER TABLE `design`
ADD CONSTRAINT `fk_design_building`
FOREIGN KEY (`building_id`) REFERENCES `building`(`id`),
ADD CONSTRAINT `fk_design_architect`
FOREIGN KEY (`architect_id`) REFERENCES `architect`(`id`);

-- Thêm khóa ngoại `building_id` và `worker_id` vào bảng `work`
ALTER TABLE `work`
ADD CONSTRAINT `fk_work_building`
FOREIGN KEY (`building_id`) REFERENCES `building`(`id`),
ADD CONSTRAINT `fk_work_worker`
FOREIGN KEY (`worker_id`) REFERENCES `worker`(`id`);
-- EX3

-- Hiển thị toàn bộ nội dung của bảng Architect
SELECT * FROM architect;

-- Hiển thị danh sách gồm họ tên và giới tính của kiến trúc sư
 SELECT `name`, `sex`
 FROM architect;
 
 -- Hiển thị những năm sinh có thể có của các kiến trúc sư
SELECT DISTINCT birthday FROM architect;

-- Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh tăng dần)
SELECT `name`, `birthday`
FROM `architect`
ORDER BY `birthday` ASC;

-- Hiển thị danh sách các kiến trúc sư (họ tên và năm sinh) (giá trị năm sinh giảm dần)
SELECT `name`, `birthday`
FROM `architect`
ORDER BY `birthday` DESC;

-- Hiển thị danh sách các công trình có chi phí từ thấp đến cao. Nếu 2 công trình có chi phí bằng nhau sắp xếp tên thành phố theo bảng chữ cái building
SELECT * FROM `building`
ORDER BY `cost` ASC, `city` ASC;

-- EX4

-- Hiển thị tất cả thông tin của kiến trúc sư "le thanh tung"
SELECT * 
FROM `architect`
WHERE name = 'le thanh tung';

-- Hiển thị tên, năm sinh các công nhân có chuyên môn hàn hoặc điện
SELECT `name`, `birthday` 
FROM `worker`
WHERE `skill` IN ('han', 'dien');

-- Hiển thị tên các công nhân có chuyên môn hàn hoặc điện và năm sinh lớn hơn 1948
SELECT `name` 
FROM `worker`
WHERE `skill` IN ('han', 'dien')
AND `birthday` > 1948;

-- Hiển thị những công nhân bắt đầu vào nghề khi dưới 20 (birthday + 20 > year)
SELECT *
FROM `worker`
WHERE birthday + 20 > year;

-- Hiển thị những công nhân có năm sinh 1945, 1940, 1948 (Bằng 2 cách)
SELECT *
FROM `worker`
WHERE `birthday` IN (1945, 1940, 1948);

SELECT * FROM `worker`
WHERE `birthday` = 1945 
OR `birthday` = 1940 
OR `birthday` = 1948;

-- Tìm những công trình có chi phí đầu tư từ 200 đến 500 triệu đồng (Bằng 2 cách)
SELECT *
FROM `building`
WHERE `cost` BETWEEN 200 AND 500;

SELECT *
FROM `building`
WHERE `cost` >= 200 AND `cost` <= 500;

-- Tìm kiếm những kiến trúc sư có họ là nguyen: % chuỗi
SELECT * 
FROM `architect`
WHERE `name` LIKE 'nguyen%';

-- Tìm kiếm những kiến trúc sư có tên đệm là anh
SELECT * 
FROM `architect`
WHERE `name` LIKE '% anh %';

-- Tìm kiếm những kiến trúc sư có tên bắt đầu th và có 3 ký tự
SELECT * 
FROM `architect`
WHERE `name` LIKE 'th_';

-- Tìm chủ thầu không có phone
SELECT * 
FROM `contractor`
WHERE `phone` IS NULL 
OR `phone` = '';
