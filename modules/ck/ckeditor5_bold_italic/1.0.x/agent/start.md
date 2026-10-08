<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Bold and Italic (ckeditor5_bold_italic) — agent index

**Alters the core CKEditor 5 bold/italic plugins so the existing toolbar buttons output `<b>`/`<i>` instead of `<strong>`/`<em>`.**

- **Version dir:** 1.0.x (installed 1.0.5)
- **Core:** `^9.4 || ^10 || ^11`
- **Dependency:** `drupal:ckeditor5`
- **Package:** CKEditor
- **Config / routes / permissions / services / entities:** none.

## What it provides
- `hook_ckeditor5_plugin_info_alter()` in `ckeditor5_bold_italic.module` — rewrites the `ckeditor5_bold` and `ckeditor5_emphasis` plugin definitions.
- Library `ckeditor5_bold_italic/internal.drupal.ckeditor5.bold` (`ckeditor5_bold_italic.libraries.yml`) loading the built plugin `js/build/drupalBold.js`.
- CKEditor 5 JS plugin `DrupalBold` / `DrupalBoldEditing` (`js/ckeditor5_plugins/drupalBold/src/`) — a `downcast` converter mapping the `bold` model to the `<b>` view element at `high` priority.
- `hook_help()` for `help.page.ckeditor5_bold_italic`.

## Mechanism (bold path)
Appends `drupalBold.DrupalBold` to `ckeditor5_bold`'s CKEditor plugin list and repoints its Drupal library to this module's library.

## Mechanism (italic path)
Removes the emphasis plugin's second CKEditor entry (`unset(...['ckeditor5']['plugins'][1])`, the Drupal `<em>` downcast) and repoints its library to `core/ckeditor5.basic`, so italic falls back to CKEditor's default `<i>` output.

## Solution docs
- [Bold/italic plugin alter](plugins/bold-italic-alter.md) — install, the alter hook, JS plugin, and text-format allowed-HTML interaction.
