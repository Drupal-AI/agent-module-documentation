<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ANT Custom Translations (auto_node_translate_custom) — agent index

**Spreadsheet-driven custom translation overrides for Auto Node Translate.**

- **Version:** 2.0.x (2.0.0), core `^8.8 || ^9 || ^10 || ^11`, package Multilingual
- **Depends on:** `auto_node_translate`
- **Config route:** `auto_node_translate_custom.config` → `/admin/config/system/custom-translations`
- **Permission:** `configure auto node translate custom` (`restrict access: true`)
- **Config:** `auto_node_translate_custom.settings`; upload parsed via PhpSpreadsheet
- **Security:** single restricted admin config route; no anonymous or mutating endpoints; spreadsheet upload handled by the core file system service.

See [configure/import.md](configure/import.md)
