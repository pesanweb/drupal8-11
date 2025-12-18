#!/bin/bash

# Tentukan lokasi folder (sesuaikan jika berbeda)
D8_PATH="./drupal8-src"
D11_PATH="./drupal11-src"

echo "Memulai perbaikan izin akses untuk Drupal 8 dan 11..."

# 1. Ubah owner ke UID 33 (www-data)
# Kita gunakan angka 33 agar kompatibel dengan container Alpine & Debian
sudo chown -R 33:33 $D8_PATH
sudo chown -R 33:33 $D11_PATH

# 2. Atur izin folder (755: rwxr-xr-x)
find $D8_PATH -type d -exec chmod 755 {} +
find $D11_PATH -type d -exec chmod 755 {} +

# 3. Atur izin file (644: rw-r--r--)
find $D8_PATH -type f -exec chmod 644 {} +
find $D11_PATH -type f -exec chmod 644 {} +

# 4. Berikan akses tulis khusus untuk folder 'files' dan 'settings.php'
# Agar installer Drupal bisa berjalan
[ -d "$D8_PATH/web/sites/default/files" ] && sudo chmod -R 775 "$D8_PATH/web/sites/default/files"
[ -d "$D11_PATH/web/sites/default/files" ] && sudo chmod -R 775 "$D11_PATH/web/sites/default/files"

echo "Perbaikan selesai! Sekarang Nginx dan PHP-FPM seharusnya bisa mengakses file."