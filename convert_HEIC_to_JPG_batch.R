###############################################################################
## HEIC → JPG 批次轉檔腳本
###############################################################################
# 0. 套件準備 ------------------------------------------------------------------
if (!requireNamespace("magick", quietly = TRUE)) install.packages("magick")
library(magick)

# 1. 設定路徑 ------------------------------------------------------------------

# input_dir  <- "C:/Path/To/Your/HEIC_Folder"          # ← 修改為 HEIC 來源資料夾

# input_dir <- r"(C:/Path/To/Your/HEIC_Folder)"   # 直接把路徑複製貼上（單反斜線 OK）
input_dir <- readline(prompt = "請貼上資料夾完整路徑：\n")
input_dir  <- gsub("\\\\", "/", input_dir)   # 把 Windows 的 \ 改成 /
output_dir <- file.path(input_dir, "jpg")            # 轉檔輸出資料夾

if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# 2. 取得 HEIC 檔清單 -----------------------------------------------------------
heic_files <- list.files(
  input_dir,
  pattern     = "(?i)\\.heic$",   # (?i) 不分大小寫
  full.names  = TRUE
)

# 3. 逐檔轉換 ------------------------------------------------------------------
for (f in heic_files) {
  img      <- image_read(f)                                      # 讀取 HEIC
  base     <- tools::file_path_sans_ext(basename(f))             # 檔名去副檔名
  out_path <- file.path(output_dir, paste0(base, ".jpg"))        # 輸出路徑
  image_write(img, path = out_path, format = "jpg")              # 寫出 JPG
}

cat("✅ 已完成轉換：", length(heic_files), " 個檔案；輸出於：", output_dir, "\n")
