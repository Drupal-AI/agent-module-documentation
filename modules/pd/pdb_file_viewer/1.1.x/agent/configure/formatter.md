<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter + settings

Global settings: `/admin/config/user-interface/pdb_file_viewer` (`administer site configuration`) — `supported_extensions` (space-separated), `allow_all_extensions`, `use_cdn` (cdn|local).

Per-display formatter `pdb_file_viewer` (file fields): `show_file_link`, `show_file_size`, `max_file_size` (bytes, 0 = unlimited), `return_empty` (blank if unrecognized; pairs with fallback_formatter).

Rendering: emits `<div id="viewport">` + attaches library `pdb_file_viewer.<cdn|local>` and `drupalSettings.files` (filename, filepath, extension); NGL loads the file client-side.

**Security:** file is a managed entity from `getEntitiesToView()` (core file access) — no path traversal/arbitrary read; default CDN is `unpkg.com` (use local to harden).
