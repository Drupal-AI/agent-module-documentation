<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Background Color (webform_background_color) — agent index

**Per-webform background-color picker, applied on the front end via a CSS/JS library and `drupalSettings`.**

- **Version:** 1.0.x — core `^10 || ^11`; depends on `webform`.
- **Config route:** `webform_background_color.config` → `/admin/config/webform/background-color` (`administer site configuration`) — choose enabled webforms + single/multiple mode.
- **Per-form:** form alter on `webform_settings_form` adds a `color` field for enabled webforms; stored as third-party setting `webform_background_color.background_color`.
- **Render:** `hook_preprocess_webform` attaches `webform_background_color/webform_background_color` and the color via `drupalSettings` (default `#ffffff`).
- **Security:** admin-gated config; stores only a color string; no external calls, no user-supplied persisted data, no mutating endpoints.
