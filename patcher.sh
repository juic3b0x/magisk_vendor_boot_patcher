#!/bin/bash
export KEEPVERITY=true
export KEEPFORCEENCRYPT=true

# Function to save log
save_log() {
  log_dir="../logs"
  mkdir -p "$log_dir"
  log_filename="$log_dir/LOG_$(date '+%Y%m%d%H%M%S')_$random_string.txt"
  touch "$log_filename"
  echo "Log for Magisk Vendor Boot Image Patcher" > "$log_filename"
  echo "Timestamp: $(date)" >> "$log_filename"
  echo "Patched Image: magisk_patched_vendor_boot_$random_string.img" >> "$log_filename"
  echo "------------------------" >> "$log_filename"
  echo "Console Output:" >> "$log_filename"
  cat "patch_console_output.txt" >> "$log_filename"
}

# Function to display banner
show_banner() {
  banner_file="res/banner"
  if [ -f "$banner_file" ]; then
    cat "$banner_file"
  else
    echo "Magisk Vendor Boot Image Patcher"
    echo ""
  fi
}

# Magisk Vendor Boot Image Patcher Menu
show_banner
echo "Magisk Version: 27.0-vb"
echo "Version: 0.01"
echo ""
echo "Press ENTER to continue"
read
clear

# Navigate to the bin directory
cd bin

# Run Magisk Vendor Boot Image Patcher and save console output
sh boot_patch.sh ../input/vendor_boot.img > patch_console_output.txt 2>&1

# Display console output to the user
cat patch_console_output.txt

# Cleanup unnecessary files
rm -rf *.cpio
rm -rf dtb
rm -rf ramdisk_table
rm -rf stock_vendor_boot.img

# Generate a random 5-digit alphanumeric string
random_string=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)

# Move the patched Vendor Boot Image with a random alphanumeric string
mv new-boot.img ../magisk_patched_vendor_boot_"$random_string".img

# Save log
save_log
rm -rf patch_console_output.txt

echo ""
echo ""
echo "The vendor boot image has been successfully patched with Magisk."
echo "Log saved as $log_filename"
echo ""
echo "Press ENTER to exit"
read
