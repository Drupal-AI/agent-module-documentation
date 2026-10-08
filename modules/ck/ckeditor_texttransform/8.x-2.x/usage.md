<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text Transform (CKEditor)

Integrates the external CKEditor 4 "Text Transform" plugin (uppercase/lowercase/capitalize/switch case).


## What & when

- Use it to add buttons that change the case of selected text in the CKEditor 4 editor.
- It is only a Drupal integration wrapper — the actual plugin JS is a third-party download.
- Targets the legacy CKEditor 4 (`ckeditor`) editor.

---

## Install & configure

- `composer require drupal/ckeditor_texttransform` then `drush en ckeditor_texttransform -y`.
- Download the "texttransform" plugin from ckeditor.com and place it at `libraries/texttransform/` (so `libraries/texttransform/plugin.js` exists).
- `hook_requirements` reports OK once the plugin.js is detected (via the libraries directory file finder), ERROR otherwise.
- In a text format's CKEditor settings, add the four Text Transform buttons to the toolbar.
- No permissions or routes.

---

## Usage & behaviour

- Add a **Transform Text Switcher** button to cycle case on the selection.
- Add **Transform Text to Uppercase** / **to Lowercase** / **Capitalize Text** buttons.
- The plugin path is resolved from the libraries directory (`texttransform` or `ckeditor/plugins/texttransform`).
- If the library is missing, the status report shows an error with a download link.
- Button images come from the downloaded library's `images/` folder.
- Case transformation happens in the browser on the current selection.
- Output is plain text (no new markup), so it is inherently filter-safe.
- Help page renders the module README (Markdown if the markdown module is present).
- Works across Drupal 8/9/10 with the legacy CKEditor 4 module.
- No server-side data is stored.
- Useful for enforcing heading/title casing conventions.
- Compatible with other CKEditor 4 plugins.
- Plugin id is `texttransform`; buttons: TransformTextSwitcher/ToUppercase/ToLowercase/Capitalize.
- The integration adds no config schema of its own beyond toolbar placement.
- Because the JS is external, keep the library updated separately from the module.
