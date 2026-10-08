<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Depth Widget (taxonomy_depth_widget) — agent index

Two **field widgets** for `entity_reference` fields that target `taxonomy_term`. Each replaces core's
flat option list with one built from `TermStorage::loadTree()`, so option labels are **indented by
depth** (a run of `-` equal to the term depth prefixes the name) and terms **outside a configured
depth are omitted**. Assigned per field under **Manage form display**. Depends only on core
`taxonomy`. Version **2.1.2**, core `^10 || ^11`. Ships no permissions, no config schema, no services
beyond `entity_type.manager`.

## The two widgets

- **`term_depth_options_select`** — "Term Depth Select list", renders a `<select>` (grouped by
  vocabulary label when more than one target bundle). Class `TermOptionsSelectWidget`.
- **`term_depth_options_buttons`** — "Term Depth Check boxes/radio buttons", renders `checkboxes`
  (multi-value) or `radios` (single). Class `TermOptionsButtonsWidget`.

Both extend `Drupal\Core\Field\Plugin\Field\FieldWidget\OptionsWidgetBase`, are
`multiple_values = TRUE`, and share identical settings + depth logic.

## Three depth modes (widget settings, mutually exclusive)

1. **`depth`** ("Depth/max depth", required, `0`–`15`) — `0` offers every level; `n>0` passes `n` as
   `loadTree`'s max-depth so only terms shallower than that cutoff appear.
2. **`deepest`** ("Deepest elements") — scans the tree for the single greatest depth present across
   all target vocabularies and offers **only** terms at that depth (the leaves).
3. **`depth_range`** + **`min_depth`** ("Set range between depths") — keeps only terms whose depth
   is within `min_depth..depth`. An `#element_validate` callback errors if `min_depth > depth`.

`deepest`, `depth_range`, and the plain `depth` cutoff are surfaced/hidden from each other via
`#states`. Labels are indented relative to the applicable minimum depth.

## Gotchas

- **Widget-only.** Constrains the edit form, not storage — migrations, JSON:API/REST, other form
  displays, or another widget can still save any term. Needs a **field constraint** to enforce.
- **Assumes a uniform tree.** `deepest` keys off one global maximum depth, so it hides the leaves of
  shallower branches in an irregular vocabulary.
- **No config schema.** Widget settings (`deepest`, `depth_range`, `min_depth`, `depth`) ship
  without a `*.schema.yml`, so they are unschemaed third-party-style settings on the form display.
- **Non-taxonomy targets** fall back to core's normal `getOptions()`.

## Files

- `agent/widgets/field-widgets.md` — full per-widget mechanism: settings form, `#states`, the
  `loadTree`/depth/indent logic in `formElement()`, and rendering differences.

## Detail docs

- `../usage.md` — orientation, three prose blocks + use-case bullets.
