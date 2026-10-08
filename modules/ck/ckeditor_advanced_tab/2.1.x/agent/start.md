<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Advanced Tab (ckeditor_advanced_tab) — agent index
**Registers the CKEditor 4 `dialogadvtab` plugin, adding the Advanced tab (id/style/class/dir) to element dialogs.**

- **Version:** 2.1.x
- **Core:** ^9.2 || ^10
- **Depends on:** `drupal:ckeditor` (CKEditor 4; deprecated in favor of CKEditor 5)
- **Plugin:** `@CKEditorPlugin(id="dialogadvtab")` in `src/Plugin/CKEditorPlugin/CKEditorAdvancedTab.php`; loads the plugin JS only.
- **Security:** No routes, permissions, forms, or services; editor-side only. Attributes editors add are still subject to the text format's filtering on save. Applies only to CKEditor 4 formats.
