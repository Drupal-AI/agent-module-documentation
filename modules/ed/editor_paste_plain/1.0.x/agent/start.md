# Editor Paste Plain — agent index

A single CKEditor 5 plugin (`editor_paste_plain_text`) that forces clipboard content to paste as plain
text, per text format. No global config page (`configure` null), no permissions, no Drush. Depends on
core `ckeditor5`.

- **Enabling it on a text format, the config location, and how the JS strips markup** →
  [configure/enable.md](configure/enable.md)

Key facts:
- Plugin definition: `editor_paste_plain.ckeditor5.yml` → id `editor_paste_plain_text`, class
  `Drupal\editor_paste_plain\Plugin\CKEditor5Plugin\ForcePastePlainText`, only active when
  `conditions.requiresConfiguration.force_paste_plain_text: true`.
- Single setting `force_paste_plain_text` (bool, default FALSE); schema
  `ckeditor5.plugin.editor_paste_plain_text`, stored in the editor entity's `settings.plugins`.
- JS (`js/build/forcePastePlainText.js`) hooks the CKEditor `clipboardInput` event and runs
  `plainTextToHtml(getData('text/plain'))`, skipping when the editor is read-only.
