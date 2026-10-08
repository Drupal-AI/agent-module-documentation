<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dropcap Ckeditor (dropcap_ckeditor) — agent index
**CKEditor 4 plugin: a toolbar button + dialog to insert a styled drop-cap into rich text.**

- **Version:** 8.4.x
- **Core:** ^9.3 || ^10
- **Plugin:** `@CKEditorPlugin("dropcap_ckeditor")` (`src/Plugin/CKEditorPlugin/Dropcap.php`), JS at `js/plugins/dropcap/plugin.js`, lib `core/drupal.ajax`.
- **Route:** `dropcap_ckeditor.dropcap_dialog` → `/plugin/dialog/dropcap/{filter_format}`, access `_entity_access: 'filter_format.use'`.

**Security:** Single route is gated by `filter_format.use` entity access (only users allowed to use the text format can open the dialog); no anonymous or mutating endpoints. Requires a full-HTML-style format (Basic HTML strips the needed tags).