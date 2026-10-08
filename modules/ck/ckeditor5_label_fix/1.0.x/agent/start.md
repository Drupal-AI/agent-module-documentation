<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Label Fix (ckeditor5_label_fix) — agent index

A CKEditor 5 plugin that preserves `<label>` markup and its inline children (`a`, `cite`, `em`,
`strong`, `b`, `span`, `br`) which CKEditor 5 otherwise splits or drops. Package **CKEditor 5**.
Version **1.0.1**. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.

Depends only on core **`ckeditor5`**. No composer requirements, no permissions, no routes, no
config entity/schema, no settings form, no Drush.

## What it actually provides

- **CKEditor 5 plugin definition** (`ckeditor5_label_fix.ckeditor5.yml`): plugin
  `ckeditor5_label_fix_plugin` loads `htmlSupport.GeneralHtmlSupport` +
  `ckeditor5_label_fix.CKEditor5LabelFixPlugin`, declares the allowed `drupal.elements`, and
  exposes a hidden faux toolbar button `cke5_label_fix_dummy` ("Label Fix Dummy Plugin") that
  acts as the enable switch. → [plugins/editor-plugin.md](plugins/editor-plugin.md)
- **CKEditor 5 client plugin** (`js/label-fix-plugin.js`, class `CKEditor5LabelFixPlugin`):
  registers `label` in the editor model schema and wires upcast/downcast converters. Covered in
  the same doc above.
- **Text-format filter** `LabelLinkFixFilter` (id `label_link_fix_filter`), in
  `src/Plugin/Filter/LabelLinkFixFilter.php`: a `TYPE_TRANSFORM_IRREVERSIBLE`, weight-101 filter
  that reassembles already-split `label`/`a`/`cite` output. → [plugins/filter.md](plugins/filter.md)
- **`hook_form_alter`** via `src/Hook/Ckeditor5LabelFixHooks.php` (OOP `#[Hook]` + `#[LegacyHook]`
  shim in `.module`): attaches library `ckeditor5_label_fix/htmlsupport` to any form containing a
  `text_format` element when `ckeditor5` is installed. → [plugins/editor-plugin.md](plugins/editor-plugin.md)
- **Library** `ckeditor5_label_fix/htmlsupport` (`*.libraries.yml`): the JS plugin +
  `css/cke5.admin.css`, depends on `core/ckeditor5`.

## How to operate (no admin form)

Enable the module, then per text format at `/admin/config/content/formats/manage/<format>`:
enable the "Label Fix Dummy Plugin" on the CKEditor 5 toolbar (the enable switch), and enable the
"Fix CKEditor5 label/link nesting issue" filter. See the docs linked above.
