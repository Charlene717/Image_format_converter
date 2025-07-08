###############################################################################
## HEIC → JPG batch conversion script
###############################################################################
# 0. Package setup ------------------------------------------------------------
if (!requireNamespace("magick", quietly = TRUE)) install.packages("magick")
library(magick)

input_dir <- "(C:\Path\To\Your\HEIC_Folder)"
# 1. Path settings ------------------------------------------------------------
# Option A ─ hard-code your folder path:
# input_dir <- r"(C:/Path/To/Your/HEIC_Folder)"      # single backslashes are fine in raw strings

# Option B ─ paste at runtime (recommended for convenience)
input_dir <- readline(prompt = "Paste the full folder path and press Enter:\n")
input_dir <- gsub("\\\\", "/", input_dir)                 # convert '\' to '/' for consistency
output_dir <- file.path(input_dir, "jpg")                 # output sub-folder

if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# 2. Gather all HEIC files ----------------------------------------------------
heic_files <- list.files(
  input_dir,
  pattern    = "(?i)\\.heic$",   # case-insensitive match
  full.names = TRUE
)

# 3. Convert each file --------------------------------------------------------
for (f in heic_files) {
  img      <- image_read(f)                                   # read HEIC
  base     <- tools::file_path_sans_ext(basename(f))          # strip extension
  out_path <- file.path(output_dir, paste0(base, ".jpg"))     # target path
  image_write(img, path = out_path, format = "jpg")           # write JPG
}

cat("✅ Conversion complete:", length(heic_files),
    "file(s) saved to:", output_dir, "\n")
