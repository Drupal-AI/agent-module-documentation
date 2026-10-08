<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 highlight

CKEditor 5 highlighter (colored marker / pen) button. **Deprecated** — use `ckeditor5_plugin_pack` instead.


## What & when

- Adds a **Highlight** toolbar button to CKEditor 5 for marking text with colored markers/pens.
- Wraps the official `@ckeditor/ckeditor5-highlight` plugin (`highlight.Highlight`).
- Module is flagged `lifecycle: deprecated`; new sites should adopt `ckeditor5_plugin_pack`.

---

## Install & configure

- `composer require drupal/ckeditor5_highlight` then `drush en ckeditor5_highlight -y` (needs core `ckeditor5`, PHP 8.1, Drupal ^10.1).
- Edit a text format at *Configuration → Content authoring → Text formats and editors*.
- Drag the **Highlight** button from Available into the Active toolbar.
- Allowed markup includes `<mark>` and `<mark class="marker-yellow marker-green marker-pink marker-blue pen-red pen-green">`.
- The theme CSS library is attached automatically on fields whose format enables the highlight toolbar item (`hook_preprocess_field`).

---

## Usage & behaviour

- Highlight passages with yellow/green/pink/blue markers or red/green pens.
- Emphasise review comments or key sentences in body text.
- Output is plain `<mark>` with a color class — survives standard text-format filtering when the classes are allowed.
- Front-end display CSS is only attached when the format actually uses the highlight button.
- Admin-only styling library (`admin.highlight`) styles the toolbar config UI.
- No permissions, routes, or settings form beyond the text-format toolbar.
- The marker/pen palette matches CKEditor 5's default highlight configuration.
- Works per text format, so you can enable it only where appropriate.
- Because it is a thin wrapper, upgrading to `ckeditor5_plugin_pack` yields the same `<mark>` output.
- No stored data conversion needed — it emits standard HTML `<mark>` elements.
- Use sparingly in editorial guidelines; highlight is presentational only.
- Compatible with other CKEditor 5 plugins in the same toolbar.
- Deprecation is a project-lifecycle note, not a functional break; it still works on Drupal 10.1+.
- The library is minified and preprocess-disabled (`js/build/highlight.js`).
- No JavaScript API is exposed for other modules.
