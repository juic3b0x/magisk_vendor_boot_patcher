#!/bin/bash

# Function to save log
save_log() {
  touch LOG_"$random_string".txt
  echo "Log for Magisk Vendor Boot Image Patcher" > LOG_"$random_string".txt
  echo "Timestamp: $(date)" >> LOG_"$random_string".txt
  echo "Patched Image: magisk_patched_vendor_boot_$random_string.img" >> LOG_"$random_string".txt
  echo "------------------------" >> LOG_"$random_string".txt
}

# Magisk Vendor Boot Image Patcher Menu
echo "Magisk Vendor Boot Image Patcher"
echo ""
echo "Magisk Version: 27.0-vb"
echo "Version: 0.01"
echo ""
echo "Press ENTER to continue"
read
clear

# Navigate to the appropriate directory (bin or res)
cd bin || cd res

# Run Magisk Vendor Boot Image Patcher
sh boot_patch.sh ../input/vendor_boot.img

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

echo ""
echo ""
echo "The vendor boot image has been successfully patched with Magisk."
echo "Log saved as LOG_$random_string.txt"
echo ""
echo "Press ENTER to exit"
read
