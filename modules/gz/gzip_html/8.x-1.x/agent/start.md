<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gzip Html output — agent index

**Gzip-compresses the rendered HTML output** of pages (reduce response size, save bandwidth). Configured via
core `system.performance_settings`. Version **8.x-1.4**. Core `^8||^9||^10||^11`.

Performance. Note the niche **BREACH** compression side-channel — worth a thought before compressing highly
sensitive dynamic responses that reflect user input; fine for normal public HTML. No content-access role.
