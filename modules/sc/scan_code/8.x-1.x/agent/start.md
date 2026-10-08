<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scan code - Barcode — agent index

Lets users **scan information from a barcode image** (camera/upload → extract encoded data for input).
Config at `scan_code.admin_config`; provides permissions. Version **8.x-1.0-beta4**. Core `^8||^9||^10||^11`.

Content-editing/input — scanned value is user input (validate/escape); camera prompts for permission. No
access role.
