<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# XSS File Scan — agent index

Scans **uploaded files for XSS content** (script/HTML that could execute if served inline — SVG/HTML
risk) and blocks flagged uploads. Config at `xss_file_scan.xss_file_scan_config_form`; provides
permissions. Version **1.0.1**. Core `^9||^10||^11`.

**Framing: heuristic scanning — one defense layer, not a guarantee** (evadable). **Complement** with
core protections: serve uploads off-origin or as `attachment`/non-executable types, restrict file types,
sanitize SVGs.
