<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bert entity-reference selection handler

`src/Plugin/EntityReferenceSelection/BertSelection.php` — `class BertSelection extends
DefaultSelection` (core `Drupal\Core\Entity\Plugin\EntityReferenceSelection\DefaultSelection`).

```
@EntityReferenceSelection(
  id = "bert",
  label = "Bert selection",
  group = "bert",
  weight = 1,
  deriver = "Drupal\bert\Plugin\Derivative\BertSelectionDeriver"
)
```

## Deriver (`src/Plugin/Derivative/BertSelectionDeriver.php`)

`getDerivativeDefinitions()` loops every entity type from `entity_type.manager` and emits a
derivative `bert:<entity_type_id>` scoped to that type (`entity_types => [$id]`, label
"@entity_type bert selection"). If an entity type has **no `label` key**, the derivative's class
is swapped to core `PhpSelection` (which loads all candidates and filters in PHP — slower, but the
only way to match on a computed `label()`). This is why the widget wires the handler as
`bert:<target_type>`.

## Extra configuration (`defaultConfiguration()` + `buildConfigurationForm()`)

Adds these on top of core DefaultSelection settings (shown on the field's reference-method form):

| Key | Default | Effect (in `buildEntityQuery()` / `createOptions()`) |
|---|---|---|
| `label_formatter` | `title` | Which label-formatter plugin renders each suggestion's text. |
| `result_amount` | `0` | Overrides the query `limit` (0 = unlimited) in `loadEntities()`. |
| `same_language_only` | `FALSE` | Adds `condition(langcode, currentContentLanguage)` and scopes the sort translation. |
| `published_only` | `FALSE` | Adds `condition(publishedKey, TRUE)` when the type has a `published` key. |
| `disable_parent_entity_selection` | `FALSE` | Adds the parent entity's id to `ignored_entities` (only offered when the field references its own entity type — `referencesSameEntityType()`). |
| `ignored_entities` | `[]` | Ids excluded via `NOT IN` (the widget fills this with already-selected ids when duplicate selection is disabled). |

The form also injects a `_label` option into the core **Sort → field** select ("Entity label"),
enabling PHP-side natural-case sorting.

## Query building (`buildEntityQuery()`)

Overrides core to add: bundle filtering (`target_bundles`), label `CONTAINS` match,
`accessCheck(TRUE)` (core entity access is enforced), the `entity_reference` query tag +
`entity_reference_selection_handler` metadata, sort (skipped for `_` pseudo-fields like `_label`),
the `ignored`/parent exclusion, `same_language_only`, and `published_only`. `getConfiguration()`
also carries an `entity` (the parent) and `target_type`.

## Option formatting (`createOptions()`)

Groups results by bundle and sets each option label to
`Html::escape($labelFormatter->getLabel($entity))` — suggestion labels are escaped here. When the
sort field is `_label`, options within each bundle are `uasort`ed with `strnatcasecmp`.

## New-entity creation (`createNewEntity()`)

Overrides core so an autocreated **node** is `setPublished()` (otherwise it wouldn't be
referenceable). Other types use the core behaviour.

## Notes

- All queries run through the entity query builder with placeholders — no raw SQL.
- The handler is generic: it works for any content-entity reference because the deriver produces a
  per-type derivative, and access is always `accessCheck(TRUE)`.
