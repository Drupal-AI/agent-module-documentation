<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Rendered entities by delta" formatter

## Install & enable

```bash
composer require drupal/entity_delta_formatter
drush en entity_delta_formatter -y
```

No dependencies beyond Drupal core. No sub-modules, no permissions, no routes, no Drush commands.

## Enable it on a field

Plugin `EntityReferenceDeltaFormatter` (id **`entity_reference_delta_formatter`**, label
*"Rendered entities by delta"*) in
`src/Plugin/Field/FieldFormatter/EntityReferenceDeltaFormatter.php`. It applies to
**`entity_reference` fields** (`field_types = { "entity_reference" }`) — the same set core's
*Rendered entity* formatter targets. It **extends** `EntityReferenceEntityFormatter`, so it keeps all
of that formatter's settings (view mode, link, etc.) and adds one setting: `deltas`.

UI path: *Structure → (bundle) → Manage display* → set the reference field's format to
**Rendered entities by delta** → gear icon → set **Deltas**.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_refs.type entity_reference_delta_formatter -y
drush cr
```

## The `deltas` setting

From `defaultSettings()`: `deltas` defaults to `''` (empty ⇒ render **all** items, i.e. behaves like
the parent formatter). `settingsForm()` adds a `textfield` with an HTML5 `#pattern` restricting input
to comma-separated numbers/ranges; `settingsSummary()` appends `Deltas: <value>` to the display
summary. Config schema key `deltas` (type `string`) lives in
`config/schema/entity_delta_formatter.schema.yml`, whose type extends
`field.formatter.settings.entity_reference_entity_view`.

### Delta syntax (as parsed by `filterItemsByDelta` / `deltaNormalize`)

- **Positions are 1-based.** `1` = first item, `3` = third item.
- **Negative** counts from the end: `-1` = last, `-2` = second-to-last.
- **Range** with underscore, inclusive: `1_3` = items 1, 2, 3. `2_-1` = all but the first. If start > end
  they are swapped.
- **Comma** combines selections: `1_3, -1` = first three plus the last. Duplicate indices are
  de-duplicated.
- Out-of-range values are clamped: anything past the end resolves to the last item, anything before the
  start resolves to the first.

## Render path (`viewElements`)

```
viewElements($items, $langcode)
  → $selected = clone $items
  → filterItemsByDelta($selected)      // removes unselected deltas
  → return parent::viewElements($selected, $langcode)
```

- The original `$items` list is **cloned** before filtering, so nothing on the stored field is mutated.
- `filterItemsByDelta()`: returns early when `deltas` is empty; otherwise `preg_replace()`s the string
  down to digits/`,`/`-`/`_`, collapses repeated `_`/`-`, drops malformed dashes/underscores,
  `explode(',')`s it, and for each token normalizes with `deltaNormalize()`. It builds a `$preserve`
  array of 0-based indices, then loops the list **backwards** calling `removeItem($index)` for every
  index not in `$preserve` (backwards so indices don't shift mid-loop).
- `deltaNormalize($delta, $count)`: negatives become `$count + $delta`; positives are decremented
  (1-based → 0-based); the result is clamped to `[0, $count - 1]`.
- The actual rendering of each surviving referenced entity is done by **core**
  `EntityReferenceEntityFormatter::viewElements()` → `entity_view()`. That means the referenced-entity
  **view-access check and field sanitization come straight from core** — this module only chooses which
  deltas reach it; it does not build its own markup.

## Notes

- Empty `deltas` ⇒ identical output to core's *Rendered entity* formatter.
- Because selection happens on a clone before core's rendering, view access on referenced entities is
  still enforced by core's `getEntitiesToView()` (`$entity->access('view', …)`).
- The `#pattern` on the settings field is a client-side hint; `filterItemsByDelta()` also sanitizes the
  stored string server-side before parsing.
