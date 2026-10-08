<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AT Internet SmartTag (atsmarttag) — agent index

**Injects the AT Internet / Piano Analytics SmartTag tracker into front-end pages with configurable page names, chapters and click tracking.**

- **Version:** 2.0.x (2.0.0-beta1)
- **Core:** ^10.3 || ^11
- **Configure route:** `atsmarttag.settings` → `/admin/config/system/atsmarttag/settings` (permission `administer atsmarttag`)
- **Permission:** `administer atsmarttag`
- **Key code:** `atsmarttag.module` (`hook_page_attachments`, `hook_library_info_build`, `_atsmarttag_settings`), `src/ATSmartTagUtils.php` (library-from-URL / library-from-file helpers, default tracked-file extensions).
- **Alter hook:** `hook_atsmarttag_settings_alter(&$settings)` to modify the emitted analytics payload.

**Security:** single admin settings route gated by `administer atsmarttag`; tracker is only attached on non-admin routes; no anonymous or mutating endpoints. Privacy note: emits analytics cookies / CNIL-exemption settings — review against local consent requirements.

See [configure/atsmarttag.md](configure/atsmarttag.md)