<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Depth Widget — field widgets

Two widgets, both for `entity_reference` fields, both `multiple_values = TRUE`, both extending
`Drupal\Core\Field\Plugin\Field\FieldWidget\OptionsWidgetBase`. Assign under **Structure → (entity
type) → Manage form display** on a field that references `taxonomy_term`. Namespace
`Drupal\taxonomy_depth_widget\Plugin\Field\FieldWidget`.

## `term_depth_options_select` — "Term Depth Select list"

- Class `TermOptionsSelectWidget`. Renders `#type => 'select'`. Injects `entity_type.manager` via
  `create()`/`ContainerFactoryPluginInterface`.
- Overrides `getEmptyLabel()` (adds `- None -` / `- Select a value -`), `supportsGroups()` (returns
  `TRUE`, so options are grouped under each vocabulary's label when more than one bundle is
  targeted; a single group is flattened with `reset()`), and `sanitizeLabel()` as
  `Html::decodeEntities(strip_tags($label))`.

## `term_depth_options_buttons` — "Term Depth Check boxes/radio buttons"

- Class `TermOptionsButtonsWidget`. Renders `#type => 'checkboxes'` when `$this->multiple`, otherwise
  `#type => 'radios'` (single default value via `reset($selected)`). Preselects the sole option when
  the field is required and exactly one option exists. `getEmptyLabel()` returns `N/A` for
  non-required single-value fields.
- Options are a **flat** `tid => label` array (no per-vocabulary grouping). Does not override
  `sanitizeLabel`.

## Settings (identical on both widgets)

`defaultSettings()`: `deepest => FALSE`, `depth_range => FALSE`, `min_depth => ''`, `depth => 0`
(plus `OptionsWidgetBase` defaults). The settings form (`settingsForm()`):

- `deepest` — checkbox "Deepest elements." Visible only while `depth_range` is unchecked.
- `depth_range` — checkbox "Set range between depths." Visible only while `deepest` is unchecked.
- `min_depth` — number `1..15`, "Minimum depth of the taxonomy tree." Visible + required only while
  `depth_range` is checked (via `#states`).
- `depth` — number `0..15`, required, "Depth/max depth of the taxonomy tree" (`0` = all levels).
  Visible only while `deepest` is unchecked.
- `#element_validate` adds `taxonomyDepthSelectRangeWidgetValidate()`: when `depth_range` is on and
  `min_depth > depth`, sets an error on `min_depth`.

`settingsSummary()` reports "Deepest elements", or "Depths set between @min and @depth", or
"Taxonomy depth: @depth".

> Note: no `config/schema/*.yml` is shipped, so these four settings are unschemaed on the form
> display config. Functional, but they trigger core's "no schema" strict-config warnings in tests.

## `formElement()` — the depth + indent logic

Runs only when the field's `target_type` is `taxonomy_term` (otherwise falls back to
`parent::getOptions($entity)`). Steps:

1. Resolve the effective range:
   - `deepest = getSetting('deepest') ?: FALSE`.
   - `max_depth = depth != 0 ? depth : NULL`, then forced to `NULL` if `deepest` (deepest ignores the
     max cutoff while scanning).
   - If not `deepest` and `depth_range`: `min_depth = (min_depth == 0) ? 0 : min_depth - 1`
     (converts the 1-based setting to a 0-based tree depth).
2. Load vocabularies via
   `entityTypeManager->getStorage('taxonomy_vocabulary')->loadMultiple($handler_settings['target_bundles'])`
   and the term storage `taxonomy_term`.
3. If `deepest`: loop every vocabulary's `loadTree(vid, 0, max_depth)`, track the greatest
   `$term->depth` seen, then set `max_depth = max_depth_value + 1`.
4. For each vocabulary, `loadTree(vid, 0, max_depth)` and for each term build the label
   `str_repeat('-', term_depth) . $term->name`:
   - **deepest mode** keeps only terms where `$term->depth == max_depth - 1` (the leaf level),
     indenting by `max_depth` dashes.
   - **otherwise** keeps terms where `min_depth` is null (no lower bound) or `min_depth <= depth`,
     indenting by `term->depth` (or `term->depth - min_depth` inside a range) dashes.
   - Select widget keys options as `options[vocabularyLabel][tid]`; buttons widget as `options[tid]`.
5. Select widget: flatten to a single group if only one vocabulary, then prepend `_none => emptyLabel`
   when applicable. Buttons widget: preselect single required option; assign to checkboxes/radios.

Depth here is core taxonomy tree depth: root terms are depth `0`, their children depth `1`, etc. The
hyphen prefix is purely cosmetic indentation in the label text; the stored value is always the plain
`tid`.
