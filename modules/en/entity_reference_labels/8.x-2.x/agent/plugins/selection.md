<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Descriptive entity-reference selection handler

Source: `src/Plugin/EntityReferenceSelection/DefaultDescriptiveSelection.php`,
`src/Plugin/EntityReferenceSelection/PhpDescriptiveSelection.php`,
`src/Plugin/Derivative/DefaultDescriptiveSelectionDeriver.php`.

## What it is

An `@EntityReferenceSelection` plugin group **`default_descriptive`** (id `default_descriptive`,
label *"Default (Descriptive)"*, `weight = 5`, `deriver = DefaultDescriptiveSelectionDeriver`). It is an
alternative *reference method* / *selection handler* — the dropdown you set on an entity-reference field's
settings, next to core's "Default". It changes the **options shown while selecting** a reference in a form
(autocomplete typeahead or select), not the display of an already-saved value.

There is no config schema, no settings form, no permission, no route, and no service. Enabling is purely a
per-field choice.

## Deriver — `DefaultDescriptiveSelection`

`DefaultDescriptiveSelectionDeriver extends DefaultSelectionDeriver` and overrides
`getDerivativeDefinitions()`. It loops **every** entity type from `entityTypeManager->getDefinitions()` and
creates one derivative per type (`default_descriptive:<entity_type_id>`), setting `entity_types`, a
`label` of `"@entity_type selection"`, and `base_plugin_label`. For any entity type that does **not**
declare a `label` key (`!$entity_type->hasKey('label')`), it swaps the derivative's `class` to
`PhpDescriptiveSelection`; all other types keep `DefaultDescriptiveSelection`.

Note: unlike core's `default` group (which maps node → `NodeSelection`, taxonomy_term → `TermSelection`,
user → `UserSelection`, comment → `CommentSelection`), this deriver assigns the generic
`DefaultDescriptiveSelection`/`PhpDescriptiveSelection` for all types.

## `DefaultDescriptiveSelection` (extends core `DefaultSelection`)

Only `getReferenceableEntities($match, $match_operator, $limit)` is overridden. It:

1. Builds the candidate query via the inherited `buildEntityQuery($match, $match_operator)` (core
   `DefaultSelection`; `accessCheck(TRUE)` and the `entity_reference` query tag apply exactly as in core),
   applies `range(0, $limit)` when `$limit > 0`, and `execute()`s it.
2. `loadMultiple()`s the result ids for `configuration['target_type']`.
3. For each entity, resolves the context translation with
   `entityRepository->getTranslationFromContext($entity)->label()`, reads `$entity->bundle()` and
   `$entity->language()->getId()`, and builds the option string
   `Html::escape($label . ' - (' . $entity_id . ' | ' . $bundle . ' | ' . $language . ')')`.
4. Returns options grouped as `$options[$bundle][$entity_id] = <escaped string>`.

So a candidate appears as, e.g., `Article title - (42 | article | en)`. The whole string is passed through
`Drupal\Component\Utility\Html::escape()` before it reaches the widget.

## `PhpDescriptiveSelection` (extends `DefaultDescriptiveSelection`)

An alternative used automatically (via the deriver) for entity types without a `label` key, where the entity
query cannot filter on a label column. It overrides `getReferenceableEntities()` and
`countReferenceableEntities()`:

- Empty/`NULL` `$match` → delegates to `parent::getReferenceableEntities()` (plain query, no PHP filtering).
- Otherwise it fetches the parent's options with **no** limit, lowercases + `Html::escape()`es the incoming
  `$match` (string, or each element of an array match) to compare against the already-escaped option labels,
  then filters in PHP with `matchLabel()` and stops once `$limit` matches are collected.
- `matchLabel($match, $match_operator, $label)` lowercases the label and implements the query operators
  itself: `=`, `>`, `<`, `>=`, `<=`, `<>`, `IN`, `NOT IN`, `STARTS_WITH`, `CONTAINS` (default widget mode),
  `ENDS_WITH`, `IS NOT NULL` (TRUE), `IS NULL` (FALSE); any other operator returns FALSE.

Trade-off documented in the deriver: `PhpDescriptiveSelection` loads *all* candidate entities before
filtering, so it is more expensive than a query-filtered handler.

## Enable / operate

1. Install and enable `entity_reference_labels` (Composer: `drupal/entity_reference_labels`; then
   `drush en entity_reference_labels`). No config is created.
2. On an entity-reference field's settings, set the **reference method** to **Default (Descriptive)**
   (shown as *"<Entity type> selection"* within that group).
3. On the bundle's *Manage form display*, use an autocomplete (or select) widget.
4. Editors then see the descriptive option strings while selecting; revert any time by switching the
   reference method back to core's "Default".
