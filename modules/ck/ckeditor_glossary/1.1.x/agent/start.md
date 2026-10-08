<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Glossary — agent start

Legacy CKEditor 4 plugin (`@CKEditorPlugin` id `ckeditor_glossary`, configurable). Requires the `ckeditor` module.
Button wraps a selection in `<a class="glossary-entry" href="<base>/<firstLetter>#<slug>">`.

- Per-format setting `plugins.ckeditor_glossary.link` (base path, default `/glossary`); schema in
  `config/schema/ckeditor_glossary.schema.yml`.
- Output is a normal anchor filtered by the text format; allow `<a href class>`. No unfiltered HTML path.
- No routes/permissions. Key files: `src/Plugin/CKEditorPlugin/Glossary.php`, `js/plugins/ckeditor_glossary/plugin.js`.
- See ../usage.md.
