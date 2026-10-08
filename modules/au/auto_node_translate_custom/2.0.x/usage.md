<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ANT Custom Translations extends Auto Node Translate with a spreadsheet-driven dictionary of custom translation overrides.

---

The module adds a single admin form at `/admin/config/system/custom-translations` (permission `configure auto node translate custom`, marked `restrict access: true`) where an administrator uploads a spreadsheet (parsed with PhpSpreadsheet / `PhpOffice\PhpSpreadsheet`) of source→target translation pairs. Those custom pairs are stored in `auto_node_translate_custom.settings` and consulted by the parent Auto Node Translate module when it auto-translates node content, so specific terms are always rendered the way you want rather than however the machine-translation provider renders them.

It is a thin, admin-only configuration submodule: it has one permission (restricted), one config route, no anonymous or mutating public endpoints, and it requires the parent `auto_node_translate` module. The spreadsheet upload uses the core file system service and is only reachable by users with the restricted admin permission.

---
- Install alongside the parent Auto Node Translate module
- Open `/admin/config/system/custom-translations`
- Upload a spreadsheet of source/target translation pairs
- Force specific terms to translate a fixed way
- Maintain a brand/glossary dictionary for auto-translation
- Override machine-translation output for key phrases
- Keep product names untranslated across languages
- Manage custom translations per configured language
- Grant `configure auto node translate custom` only to trusted admins
- Update the dictionary by re-uploading a revised spreadsheet
- Ensure consistent terminology in auto-translated nodes
- Complement Auto Node Translate's provider with manual overrides
- Import a bulk glossary in one spreadsheet upload
- Store overrides in `auto_node_translate_custom.settings` config
- Restrict the config route with the restricted admin permission
- Review the current dictionary before a translation run
