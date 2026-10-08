<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CER presets (`corresponding_reference` config entities)

CER does nothing until at least one preset exists. Admin UI: `/admin/config/content/cer`
(+ `/add`, `/{id}`, `/{id}/delete`, `/{id}/sync`).

## Config shape

```yaml
# config name: cer.corresponding_reference.<id>
id: article_related
label: 'Article ↔ related article'
enabled: true
first_field: field_related_left
second_field: field_related_right     # may be the SAME field name as first_field
add_direction: append                 # 'append' | 'prepend'
bundles:
  node:
    - article
    - page
  commerce_product:
    - '*'                             # '*' = every bundle of that entity type
```

`config_export` is exactly those seven keys. Schema lives in `config/schema/cer.schema.yml`.

## What the form offers

- **First field / Second field** — `select`, options are every field of type
  `entity_reference` from `EntityFieldManager::getFieldMapByFieldType('entity_reference')`
  **whose machine name matches `/^field_.*$/`**. Base fields and non-`field_`-prefixed fields
  are therefore *not* selectable. Both are `#required`. The description explicitly says
  "It may be the same field."
- **Add Direction** — `prepend` or `append` (default `append`).
- **Bundles** — multi-select of `"<entity_type>:<bundle>"` strings, plus an
  `"<entity_type>:*"` option per entity type. Only entity types that actually have one of the
  chosen corresponding fields are listed. Stored as the `bundles` map above.
- **Enabled** — only enabled presets are loaded at runtime
  (`CorrespondingReferenceStorage::loadValid()` filters on `enabled = 1`).

## Create a preset with Drush

```bash
drush php:eval '
  \Drupal\cer\Entity\CorrespondingReference::create([
    "id" => "article_related",
    "label" => "Article related",
    "enabled" => TRUE,
    "first_field" => "field_cer_left",
    "second_field" => "field_cer_right",
    "add_direction" => "append",
    "bundles" => ["node" => ["article"]],
  ])->save();
'
```

A reciprocal single-field relationship (A lists B, B lists A, same field):

```bash
drush php:eval '
  \Drupal\cer\Entity\CorrespondingReference::create([
    "id" => "related_content",
    "label" => "Related content",
    "enabled" => TRUE,
    "first_field" => "field_related",
    "second_field" => "field_related",
    "add_direction" => "append",
    "bundles" => ["node" => ["*"]],
  ])->save();
'
```

## Read presets back

```bash
drush cget cer.corresponding_reference.article_related
drush config:status | grep cer.corresponding_reference
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("corresponding_reference")->loadMultiple() as $p) {
    printf("%s: %s <-> %s enabled=%d direction=%s bundles=%s\n",
      $p->id(), $p->getFirstField(), $p->getSecondField(),
      $p->isEnabled(), $p->getAddDirection(), json_encode($p->getBundles()));
  }
'
```

## Toggle / delete

```bash
drush php:eval '$p = \Drupal\cer\Entity\CorrespondingReference::load("article_related"); $p->setEnabled(FALSE)->save();'
drush php:eval '\Drupal\cer\Entity\CorrespondingReference::load("article_related")->delete();'
```

## Prerequisites for a preset to actually fire

`CorrespondingReference::isValid($entity)` requires **all** of:

1. the entity's **entity type** is a key in `bundles`;
2. the entity's **bundle** is listed there, or `*` is;
3. the entity **has** at least one of the two corresponding fields (`hasCorrespondingFields()`).

Then, per corresponding entity, `synchronizeCorrespondingField()` additionally requires:

4. the *target* field's `target_type` equals the saving entity's entity type;
5. the *target* field's `handler_settings.target_bundles` is empty **or** contains the saving
   entity's bundle.

If any of those fail, nothing is written and nothing is logged.

## Gotchas

- **Do not use the *Synchronize* tab.** `CorrespondingReferenceSyncForm::submitForm()` calls
  `$this->entity->delete()` — the confirm form deletes the preset. There is no working
  "sync existing content" feature; re-save the entities instead.
- Field cardinality matters: if the corresponding field is single-value, an added
  back-reference will overwrite/violate cardinality on save.
- Everything runs as the current user. If that user cannot view or update the corresponding
  entity, the sync silently does not happen (documented in the project README).
- `getAddDirection()` defaults to `append` when the stored value is empty.
- `loadValid()` ignores its `$entity` argument — it returns **all** enabled presets; the
  per-entity filtering happens later in `isValid()`.
