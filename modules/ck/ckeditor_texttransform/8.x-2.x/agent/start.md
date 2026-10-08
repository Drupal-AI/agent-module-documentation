<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text Transform (CKEditor) — agent start

Integration wrapper for the third-party CKEditor 4 "texttransform" plugin. Requires `ckeditor` AND the plugin
JS downloaded to `libraries/texttransform/plugin.js` (checked by `hook_requirements`).

- Buttons: TransformTextSwitcher, TransformTextToUppercase, TransformTextToLowercase, TransformTextCapitalize.
- Output is transformed plain text (no new markup) → filter-safe. Path resolved via libraries directory file finder.
- No routes/permissions/config schema. Key files: `src/Plugin/CKEditorPlugin/CkeditorTextTransform.php`,
  `ckeditor_texttransform.install`, `ckeditor_texttransform.module`.
- See ../usage.md.
