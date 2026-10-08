<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Upload Size Limit (JS) — agent index

**Client-side (JavaScript)** file-size limiting on upload fields — warns/blocks over-size files before
upload (immediate feedback). Depends on core `file`. Config at `file_upload_size_limit.settings`.
Version **1.0.0-alpha7**. Core `^8||^9||^10||^11`.

**CAVEAT: JS-only — a usability aid, NOT a security control** (trivially bypassed). Enforce real limits
server-side (field settings + PHP `upload_max_filesize`/`post_max_size`).
