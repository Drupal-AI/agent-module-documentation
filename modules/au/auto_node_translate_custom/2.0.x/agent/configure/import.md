<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import custom translations

Route `auto_node_translate_custom.config` → `/admin/config/system/custom-translations`, permission `configure auto node translate custom` (restricted).

- `ConfigForm` (uses `language_manager`, `entity_type.manager`, `file_system`) accepts a spreadsheet upload parsed with `PhpOffice\PhpSpreadsheet\IOFactory`.
- Rows define source→target translation pairs stored in `auto_node_translate_custom.settings`.
- The parent **Auto Node Translate** module applies these overrides during node auto-translation, so listed terms always translate exactly as specified.
- Re-upload a revised spreadsheet to update the dictionary.
