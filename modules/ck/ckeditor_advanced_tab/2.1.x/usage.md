<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Advanced Tab registers the CKEditor 4 `dialogadvtab` plugin, which restores the "Advanced" tab (id, style, stylesheet classes, language direction) inside element dialogs.
---
The module is a thin integration: `src/Plugin/CKEditorPlugin/CKEditorAdvancedTab.php` is a `@CKEditorPlugin` (id `dialogadvtab`) that points CKEditor at the plugin's JavaScript so the advanced tab appears in link/image/table dialogs. It depends on Drupal core's `ckeditor` (CKEditor 4) module, which is deprecated/removed in favor of CKEditor 5 in newer Drupal — so this module applies only to sites still using the CKEditor 4 editor.

There is no configuration form, route, permission, or service beyond the plugin definition; enabling the module and using a text format configured with CKEditor 4 makes the advanced tab available. Because it only adds an editor-side dialog tab, its security surface is limited to what CKEditor 4 already exposes; the id/class/style fields are subject to the text format's normal filtering on save.
---
- Restore the Advanced tab in CKEditor 4 dialogs.
- Let editors set an element id in link/image dialogs.
- Allow adding CSS classes to elements via the dialog.
- Set inline style on elements from the dialog.
- Control text direction (dir) on elements.
- Enable the dialogadvtab plugin without manual JS.
- Support legacy CKEditor 4 text formats.
- Give editors fine-grained element attributes.
- Pair with link/image/table dialogs.
- Add advanced attributes without switching to source view.
- Keep editing on CKEditor 4 during migration.
- Apply per text-format via the editor toolbar config.
- Provide a no-config editor enhancement.
- Complement other CKEditor 4 dialog plugins.
- Expose stylesheet class fields to editors.
