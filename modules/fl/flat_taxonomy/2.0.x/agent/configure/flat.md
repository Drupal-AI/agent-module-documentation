<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Making a vocabulary flat

There is **no admin settings page** (`configure = null`). Flatness is a per-vocabulary flag.

## In the UI

1. Go to *Structure → Taxonomy → <vocabulary> → Edit* (the vocabulary add/edit form).
2. Tick **Flat taxonomy** ("If checked, the taxonomy will be flat, terms can be ordered but
   can't be nested").
3. Save. If the vocabulary already had nested terms, they are **flattened immediately** (moved to
   the root) by the `flat_taxonomy.taxonomy_flattener` service.

## Where it is stored

A third-party setting on the vocabulary config entity:

```yaml
# taxonomy.vocabulary.tags
third_party_settings:
  flat_taxonomy:
    flat: '1'   # 1 = flat (FLAT_TAXONOMY_FLAT); unset/0 = normal
```

Schema: `taxonomy.vocabulary.*.third_party.flat_taxonomy` (`flat: text`). Unticking the box
**removes** the setting (`unsetThirdPartySetting`).

## What "flat" enforces (once set)

- Term add/edit form: the **parent** field is hidden and a validate handler errors if a parent is
  submitted.
- The **"Add child"** entity operation is removed from the term overview.
- The term-overview **drag-and-drop** loses its depth/parent grouping (reorder only, no indent).
- `hook_taxonomy_term_presave()` resets `parent` to `0` and logs/messages a warning if a term is
  saved with a parent programmatically (migration, REST, services).

## In code / for deployment

```php
$vocab = \Drupal::entityTypeManager()->getStorage('taxonomy_vocabulary')->load('tags');
$vocab->setThirdPartySetting('flat_taxonomy', 'flat', 1)->save();
\Drupal::service('flat_taxonomy.taxonomy_flattener')->flatten($vocab); // un-nest existing terms
```

Inspect: `drush config:get taxonomy.vocabulary.tags third_party_settings`.
