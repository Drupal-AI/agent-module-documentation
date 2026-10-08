<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Customizing the output (context `settings`) and submodules

This module has **no config object and no settings form**. All tuning happens through the
serialization `$context['settings']` array, which higher-priority normalizers set before
handing an entity back to `ContentEntityNormalizer` / `ReferenceItemNormalizer`.

## The `settings` context keys

Both keyed by entity type id:

| Key | Read by | Effect |
|---|---|---|
| `settings[<entity_type>]['exclude_fields']` | `ContentEntityNormalizer` | Array of field names removed from the serialized entity (`array_diff_key`). |
| `settings[<entity_type>]['disable']` | `ReferenceItemNormalizer` | If truthy, references to that entity type are **not** expanded (left as bare targets). |

Nothing in this base module populates `settings`; it is written by add-on normalizers.

## Writing your own tuning normalizer

Register a normalizer with a **higher priority** than `rest_entity_recursive.normalizer.content`
(priority 9) for the entity/field type you want to shape, set the `settings` keys, then delegate
back to the serializer. Pattern taken from the bundled submodules:

```php
// In your normalizer's normalize(), before delegating:
$context['settings'][$data->getEntityTypeId()]['exclude_fields'] = ['field_internal', 'foo'];
// ... then let ContentEntityNormalizer handle the rest, or return your own array.
```

## Bundled submodules (each documented separately)

Enable these instead of writing your own for common cases; each adds higher-priority
normalizers and pre-sets `exclude_fields` for its entity type:

| Submodule | Adds | Extra deps |
|---|---|---|
| `rest_media_recursive` | Media / File / Image normalizers, emits image-style URLs | `media`, `consumer_image_styles` |
| `rest_menu_recursive` | Menu normalizer (expands a menu link tree) | — |
| `rest_paragraphs_recursive` | Paragraph + Paragraphs-Library normalizers | `paragraphs` |

## Notes

- There is no `configure` route, no `*.permissions.yml`, no Drush commands, and no plugin
  type — the module is purely a set of tagged Serialization services.
- The base module declares no `dependencies:` in its `.info.yml`, but it extends classes from
  core **Serialization** and is only useful with core **REST** (or another route that emits a
  `_format`), so both must be enabled.
