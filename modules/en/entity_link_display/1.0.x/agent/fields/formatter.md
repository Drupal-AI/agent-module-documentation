<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Link formatter + computed field

Two pieces, no dependencies beyond core.

## Formatter: `EntityLinkDisplayFormatter`

File `src/Plugin/Field/FieldFormatter/EntityLinkDisplayFormatter.php`, extends
`Drupal\Core\Field\FormatterBase`.

- Annotation: id `entity_link_display`, label *"Display Link"*, `field_types = { "link" }` — it is
  selectable on any **link** field. It ignores the field item's stored URI and always links to the
  **host entity** (`$items->getEntity()`).
- `defaultSettings()`:
  - `link_text` = `'View content'`
  - `link_class` = `''`
  - `link_rel` = `[]`
  - `link_target` = `'_self'`
- `settingsForm()` exposes: `link_text` (textfield), `link_class` (textfield, space-separated CSS
  classes), `link_rel` (checkboxes: `nofollow`, `noopener`, `noreferrer`, `external`), `link_target`
  (select: `_self` / `_blank` / `_parent` / `_top`, with a `- None -` empty option).
- `settingsSummary()` returns four lines: link text, CSS class, rel (filtered + imploded), target.
- `viewElements(FieldItemListInterface $items, $langcode)`:
  - `$entity = $items->getEntity()`.
  - Only renders when `$entity && $entity->hasLinkTemplate('canonical')`; otherwise returns `[]`.
  - `$url = $entity->toUrl()` (canonical route of the host entity).
  - `$link_text = $this->getSetting('link_text') ?: $entity->label()` (empty text falls back to the
    entity label).
  - Builds `#attributes`: `class` from `array_filter(explode(' ', $link_class))`, `rel` from the
    filtered rel settings, `target` from `link_target` (each added only when non-empty).
  - Emits one element: `['#type' => 'link', '#title' => $link_text, '#url' => $url,
    '#attributes' => $attributes]`. Rendering goes through Drupal's render/link system — the title is
    auto-escaped and the URL is entity-derived, not user-supplied.

Note: because the URL comes from the host entity, the link is the same for every item and does not
use the link field's own value. There is no config schema shipped; the formatter settings are stored
in the view display config with core's generic handling.

## Computed base field: `ViewModeLinkComputedField`

File `src/Plugin/Field/FieldType/ViewModeLinkComputedField.php`, extends
`Drupal\Core\Field\FieldItemList` with `ComputedItemListTrait`.

- `computeValue()`: if `$entity->id()` and `$entity->hasLinkTemplate('canonical')`, creates one
  `link` item `{ uri: $entity->toUrl('canonical', ['absolute' => TRUE])->toString(),
  title: t('Display Link') }`. On any exception, or when there is no canonical/id, it sets an empty
  item (`uri => ''`, `title => ''`).

## Hook: base-field attachment

`entity_link_display_entity_base_field_info(EntityTypeInterface $entity_type)` in
`entity_link_display.module`:

- For every entity type where `$entity_type->hasLinkTemplate('canonical')`, defines a computed base
  field `entity_link_display` of type `link`, label *"Display Link"*, class
  `ViewModeLinkComputedField`, `setComputed(TRUE)`.
- Display: `setDisplayConfigurable('view', TRUE)`, `setDisplayConfigurable('form', FALSE)`,
  and a default view display option with `region => 'hidden'`, `visible => FALSE`, `type =>
  'entity_link_display'` — so the field appears in Manage Display but is disabled until placed.

## Enable / operate

1. `drush en entity_link_display` (or install via the UI). No further config required.
2. Go to **Manage Display** for a bundle + view mode.
3. Move the **Display Link** field (or apply the *"Display Link"* formatter to any link field) out of
   the *Disabled* region into a visible region.
4. Open the formatter settings gear and set link text, CSS class(es), rel attributes and target.
5. Save the display.

No routes, permissions, services or Drush commands are provided.
