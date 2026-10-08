<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form — enable the edit-form autofill per bundle

Route `imagefield_default_alt_and_title.settings` → `/admin/config/search/imagefield-default-alt-and-title`
(admin menu link under *Configuration › Search and metadata*, local task tab "Settings").
Permission: core `administer site configuration`. Form class
`Drupal\imagefield_default_alt_and_title\Form\ImagefieldDefaultAltAndTitleForm` (form id
`imagefield_default_alt_and_title`), a `ConfigFormBase`.

## The one field

| Element | Type | Options |
|---|---|---|
| `imagefield_default_alt_and_title_entity_types` | `checkboxes` | every bundle of entity types `node_type`, `taxonomy_vocabulary`, `commerce_product_type` |

`getEntityList()` builds the options by loading the bundle entities of those three types; the
option **key and value are both the bundle machine name** (e.g. `article`). On submit the whole
checkboxes value is saved to config object `imagefield_default_alt_and_title.settings`, key
`imagefield_default_alt_and_title_entity_types` (an array keyed by bundle machine name; checked
entries hold the machine name, unchecked hold `0`).

## What the setting does at runtime

`imagefield_default_alt_and_title_form_alter()` (in the `.module`) runs on every entity form.
If the edited entity's `bundle()` is in the configured list, it attaches the JS library
`imagefield_default_alt_and_title/image-data`. That library
(`js/imagefield_default_alt_and_title.js`, behavior `initImgAltTitle`, deps `core/once`,
`core/drupal`) on the edit form:

- Selects the image-widget text inputs (`.image-widget input.form-text`,
  `.image-widget-data input.form-text`) — i.e. the Alt and Title inputs — and the entity's
  Title/Name input (`.field--name-title input`, `.field--name-name input`).
- Prefills each **empty** image input with the current title value, and keeps syncing it as the
  editor types the title — until the editor edits that image input by hand, at which point it is
  marked done (tracked per input via `dataset.imgAltTitle.needAdd`).

This is purely a client-side convenience; the value the editor sees is submitted through the
normal image-widget form fields.

## Set it programmatically

```php
\Drupal::configFactory()->getEditable('imagefield_default_alt_and_title.settings')
  ->set('imagefield_default_alt_and_title_entity_types', [
    'article' => 'article',
    'page' => 'page',
  ])
  ->save();
```

Or: `drush cset imagefield_default_alt_and_title.settings imagefield_default_alt_and_title_entity_types.article article -y`

## Notes

- **No config schema ships** (there is no `config/schema` directory), so the config object is
  schemaless. `hook_uninstall()` deletes `imagefield_default_alt_and_title.settings`.
- This setting drives **only** the edit-form autofill. The batch backfill
  ([configure/batch.md](batch.md)) has its own per-run selection and does **not** read this config.
