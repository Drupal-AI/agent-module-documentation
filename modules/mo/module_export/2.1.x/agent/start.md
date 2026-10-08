<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Export (module_export) — agent index

**Generates a downloadable glue module (or CSV) that lists every currently enabled/installed module as dependencies, to replicate a module set on another site.**

- **Version:** 2.1.x
- **Core:** ^9.3 || ^10
- **Depends:** none
- **Configure:** `/admin/modules/export` (route `module_export.settings`), permission `administer users`.

**Surface:** one form (`SettingsForm`). Two submit paths: Download Module (tar.gz of generated `.info.yml` + `.module`) and Download CSV (module inventory). Files are written to `public://` and streamed as `BinaryFileResponse`.

**Security:** generated machine name sanitised to `[a-z0-9_]` (no traversal); exported files contain only a module inventory (names/versions/links), not secrets; behind the strong `administer users` permission. The version-check option writes a `hook_module_preinstall` that uninstalls version-mismatched modules on the target — powerful, review before use.
