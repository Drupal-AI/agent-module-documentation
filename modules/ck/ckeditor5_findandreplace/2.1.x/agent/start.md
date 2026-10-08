# CKEditor5 find and replace — agent index

Registers the upstream CKEditor 5 `findAndReplace.FindAndReplace` plugin as a Drupal CKEditor 5 toolbar
button. No PHP logic (empty `.module`), no settings, no permissions, no config schema, no Drush. Depends
on core `ckeditor5`. Requires Drupal 11, PHP 8.1+. Configured per text format only.

- **Enabling the button on a text format + the plugin/library definitions** →
  [configure/toolbar.md](configure/toolbar.md)

Key facts:
- Plugin definition `ckeditor5_findandreplace.ckeditor5.yml` → CKEditor5 plugin
  `findAndReplace.FindAndReplace`, toolbar item `findandreplace`, `elements: false` (adds no HTML to
  saved content).
- Compiled JS: `js/build/find-and-replace.js` (library `ckeditor5_findandreplace/findandreplace`,
  depends on `core/ckeditor5`). All assets local; no CDN.
- No stored configuration beyond each text format's toolbar (`editor.editor.<format>`).
