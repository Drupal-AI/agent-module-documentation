<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bold/italic plugin alter

How ckeditor5_bold_italic makes CKEditor 5's built-in Bold and Italic buttons emit `<b>` and `<i>` instead of `<strong>` and `<em>`. There are no settings — enabling the module applies the change globally to every text format that uses CKEditor 5.

## Install / enable
```bash
composer require drupal/ckeditor5_bold_italic
drush en ckeditor5_bold_italic -y
```
Requires `drupal:ckeditor5`. No configuration form, no routes, no permissions. Uninstalling reverts to core's `<strong>`/`<em>` output.

## The alter hook
`ckeditor5_bold_italic_ckeditor5_plugin_info_alter(array &$plugin_definitions)` (in `ckeditor5_bold_italic.module`) receives the collected `CKEditor5PluginDefinition` objects and rewrites two of them:

- **Bold** (`ckeditor5_bold`): appends `drupalBold.DrupalBold` to `['ckeditor5']['plugins']`, then unsets `['drupal']['library']` and sets it to `ckeditor5_bold_italic/internal.drupal.ckeditor5.bold`. This loads the module's JS plugin alongside the core bold command.
- **Italic** (`ckeditor5_emphasis`): unsets `['ckeditor5']['plugins'][1]` (core's `DrupalEmphasis` entry that downcasts italic to `<em>`), then repoints `['drupal']['library']` to `core/ckeditor5.basic`. With the Drupal-specific `<em>` converter removed, CKEditor's stock italic downcast (`<i>`) applies.

Each modified array is wrapped back into `new CKEditor5PluginDefinition(...)` before being written to `$plugin_definitions`.

## The JS plugin (bold)
Built file: `js/build/drupalBold.js` (declared `{ minified: true }` in `ckeditor5_bold_italic.libraries.yml`, dependency `ckeditor5/ckeditor5`). Source under `js/ckeditor5_plugins/drupalBold/src/`:
- `index.js` exports `{ DrupalBold }`.
- `drupalbold.js` — `DrupalBold` plugin, `requires` = `[DrupalBoldEditing]`.
- `drupalboldediting.js` — `DrupalBoldEditing.init()` registers a downcast converter: `this.editor.conversion.for('downcast').attributeToElement({ model: 'bold', view: 'b', converterPriority: 'high' })`. The `high` priority overrides core's default `<strong>` downcast for the `bold` model attribute.

(The class comments say "italic command", but the code operates on the `bold` model — italic is handled entirely by the PHP alter above, not by this JS.)

## Text-format allowed-HTML
The module changes only what the editor writes; it does not touch filter config. If a format's "Limit allowed HTML tags" filter restricts tags, add `<b>` and `<i>` to the allowed list, otherwise the new tags are stripped on save. `<b>`/`<i>` are safe inline formatting tags carrying no attributes here.

## Verify
Edit content in a CKEditor 5 format, apply Bold/Italic, save, and inspect the stored markup — it should contain `<b>`/`<i>`. Toolbar buttons and keyboard shortcuts are unchanged.
