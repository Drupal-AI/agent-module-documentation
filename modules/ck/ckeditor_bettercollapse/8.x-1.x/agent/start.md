<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Better Collapse — agent start

Legacy CKEditor 4 plugin (`@CKEditorPlugin` id `ckeditor_bettercollapse`). Adds a per-format checkbox
("CKEditor Better Collapse enabled"); when on, sets `toolbarCanCollapse=TRUE`, `toolbarStartupExpanded=FALSE`
and its JS collapses only the 2nd toolbar row.

- No buttons, routes, or permissions. Configured via the CKEditor 4 text-format plugin settings.
- Key files: `src/Plugin/CKEditorPlugin/BetterCollapse.php`, `ckeditor-bettercollapse.js`.
- Only relevant where the legacy `ckeditor` (CKEditor 4) editor is still in use.
- See ../usage.md.
