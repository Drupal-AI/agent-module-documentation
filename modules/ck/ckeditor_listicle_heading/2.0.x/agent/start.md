<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Listicle Heading — agent start

Legacy CKEditor 4 plugin (`@CKEditorPlugin` id `listicleheading`). Inserts a `div.listicle-heading` with a
heading (h1–h6) containing `span.number`, `span.separator`, `span.title`, via a dialog.

- Values set through CKEditor DOM API (setText/createElement); output filtered by the text format (no raw HTML path).
- Allow `div`, heading tags and `span[class]` in the format. Info.yml declares no explicit ckeditor dependency but it is a CKEditor 4 plugin.
- No routes/permissions/settings form. Key files: `src/Plugin/CKEditorPlugin/ListicleHeading.php`,
  `js/plugins/listicleheading/plugin.js`, `.../dialogs/listicleheading.js`.
- See ../usage.md.
