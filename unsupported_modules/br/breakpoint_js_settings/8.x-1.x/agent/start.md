<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Breakpoint Javascript Settings (`breakpoint_js_settings`) — agent index
**Writes theme breakpoint min-width/device mappings into drupalSettings for front-end JS.**

- **Version:** 8.x-1.x  | **Core:** ^8 || ^9 || ^10
- **Depends on:** core `breakpoint`
- **Configure:** `/admin/config/system/breakpoint_js` (`breakpoint_js_settings.admin_settings`, `administer site configuration`)
- **Form:** `src/Form/SettingsForm.php`

**Security:** single admin-gated settings form; output is breakpoint metadata into drupalSettings. No findings.
