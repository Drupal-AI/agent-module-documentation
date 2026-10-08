<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter: entity_reference_display_formatter

Class `EntityReferenceTabFormatter` in
`src/Plugin/Field/FieldFormatter/EntityReferenceTabFormatter.php`, `extends FormatterBase`.

```
@FieldFormatter(
  id = "entity_reference_display_formatter",
  label = "Entity reference Display formatter",
  field_types = { "entity_reference", "entity_reference_revisions" }
)
```

## Enable / select

1. Enable the module (`drush en entity_ref_display_formatter`).
2. On an entity_reference / entity_reference_revisions field's *Manage display* row, set the format
   to **"Entity reference Display formatter"** and open the gear to configure.

## Settings (`defaultSettings()`)

- `tab_title` (array) — machine names of referenced-entity fields used as the tab/section **title**.
- `tab_body` (array) — machine names used as the panel/section **body**.
- `style` (string) — one of `tabhorizontal`, `tabvertical`, `accordion`, `anchors`.
- `weights` (array), `detailsc` (array), `detailscb` (array) — hold the drag weight tables. In
  practice the per-item weights are stored at `detailsc['weights'][<field>]['weight']` (title) and
  `detailscb['weightsb'][<field>]['weight']` (body); `weights` is a legacy default.

Note: the module ships **no `config/schema/`**, so these settings have no schema definition
(expect a config-schema notice under strict schema checking).

## Settings form (`settingsForm()`)

- Reads `getFieldSettings()`: `target_type` and `handler_settings['target_bundles']`.
- `getEntityFields($entity_type_id, $bundle)` (private) uses the `entity_field.manager` service and
  keeps only definitions that are `instanceof FieldConfigInterface` — i.e. **configurable
  (added) fields only**; base fields such as `title`/`name` are not offered. It iterates
  `$bundles` but only the **last** bundle's field list survives the loop, so with multiple target
  bundles only the last bundle's fields populate the selects.
- Widgets: `tab_title` and `tab_body` are multi-select (`#multiple`, `#required`). `style` is a
  required radios element (Horizontal Tab / Vertical Tab / Accordion / Anchors). Two collapsible
  `details` ("Adjust weights Title" / "Adjust weights content") each contain a weight `table` row
  per selected field.
- `settingsSummary()` returns an **empty array** (no summary text on the Manage-display row).

## Render (`viewElements(FieldItemListInterface $items, $langcode)`)

- For each field item: `$id = $item->getValue()['target_id']`, then
  `\Drupal::entityTypeManager()->getStorage($target_type)->load($id)` to load the referenced entity.
- If the loaded entity `hasTranslation($langcode)` it uses `getTranslation($langcode)`, else the
  original.
- For each configured title field present and non-empty:
  `$titles[$weight] = $entity->get($field)->view('full')`; likewise for body fields into
  `$bodydata`. Both are `ksort()`ed by weight. Result per referenced id:
  `$tabs[$id] = ['title' => $titles, 'body' => $bodydata]`.
- Maps `style` → theme + attached library:
  - `tabhorizontal` → `entity_ref_tab_formatter` + `entity_ref_display_formatter/tab_formatter`
  - `accordion` → `entity_ref_accordion_formatter` + `.../accordion_formatter`
  - `anchors` → `entity_ref_anchor_formatter` + `.../anchor_formatter`
  - `tabvertical` → `entity_ref_tab2_formatter` + `.../tab_formatter_vertical`
- Returns a single render element at index `$delta` (the loop's last delta): `#theme` = chosen
  theme, `#tabs` = `$tabs`, `#attached[library]` = chosen library. Templates loop `tabs` and print
  each rendered field render-array (auto-escaped by Twig; the `|raw` in the template header is a
  comment, not live output).

## Templates & libraries

- `templates/entity-ref-tab-formatter.html.twig`, `-tab2-formatter`, `-accordion-formatter`,
  `-anchor-formatter`; registered by `entity_ref_display_formatter_theme()`.
- Libraries (`.libraries.yml`): horizontal tabs = `js/tab_formatter.js` (dep `core/once`); vertical
  tabs = `js/tab_formatter_vertical.js` + `css/tab_formatter.css` (dep `jquery_ui_tabs/tabs`);
  accordion = `js/accordion_formatter.js` (dep `jquery_ui_accordion/accordion`); anchors =
  `css/anchor_formatter.css` only.

## Caveats

- **Vertical Tab** and **Accordion** styles need the `jquery_ui_tabs` / `jquery_ui_accordion`
  contrib modules installed (their libraries are referenced but not declared as dependencies).
- Only added (configurable) fields can be chosen as title/body; base fields cannot.
- With multiple `target_bundles`, only the last bundle's fields appear in the selects.
- Each selected field is rendered with its own `full` field view mode; there is no "referenced
  entity view mode" option (this is not the core "Rendered entity" formatter).
