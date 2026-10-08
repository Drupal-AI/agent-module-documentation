<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading Progress Bar (reading_progress_bar) — agent index

**A block that renders a top-of-page bar filling as the visitor scrolls, indicating reading progress across the document or a selected container.**

- **Version:** 2.2.x
- **Core:** ^10 || ^11
- **Block plugin:** `ReadingProgressBarBlock` (id `reading_progress_bar_block`) with settings for height, color, background/transparency, border, minimum ratio, auto-hide delay, and `container_selector`.
- **Assets:** library `reading_progress_bar` (`js/reading_progress_bar.js`, theme CSS; depends on `core/drupal`, `core/once`); Twig hook `reading_progress_bar`.
- **Routes/permissions:** none of its own; placement uses core block admin.

**Security:** Front-end display only — no routes, no permissions, no user-input processing on the server. Configuration is limited to admins who can place blocks. No security-sensitive surface.