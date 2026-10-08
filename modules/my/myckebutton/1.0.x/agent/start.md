<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# My CKE Button (myckebutton) — agent index

**Admins define named custom text styles in a form; a CKEditor 4 plugin exposes a toolbar button that applies them.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Depends:** drupal:ckeditor (CKEditor 4)
- **Configure:** `/admin/config/content/myckebutton-styles` (route `myckebutton.myckebutton_styles`), permission `access myckebutton config`.

**Surface:** one config form (`MyCKEButtonConfigForm`), a `CKEditorPlugin` (`MyCKEButton`), config `ckeditor.plugin.myckebutton` (+ schema), and a JS library. No content-serving routes.

**Security:** style definition gated by `access myckebutton config`; styling applied client-side in the editor; output still passes the text format's filters. Targets legacy CKEditor 4 only.
