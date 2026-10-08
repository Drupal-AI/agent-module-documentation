<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — render a reference field as a Slick carousel

There is **no module settings form**. All configuration is per field, on the
`entity_view_display` (Field UI "Manage display") of the entity/bundle that owns the
reference field. You choose the formatter, a view mode for the referenced entities, and a
Slick optionset that controls the carousel.

## Prerequisites

- The field must be an `entity_reference`, `entity_reference_revisions`, or (for the sibling
  formatter) `dynamic_entity_reference` field, and must be **multi-value** (cardinality > 1
  or unlimited). The formatter is hidden on single-value fields — `isApplicable()` requires
  `$storage->isMultiple()`.
- The Slick module must be installed (it is a dependency) and at least one **Slick optionset**
  must exist. A `default` optionset ships out of the box. Create/edit optionsets with the
  Slick UI submodule at `/admin/config/media/slick` (route `entity.slick.collection`).

## In the UI

1. Go to Manage display for the bundle, e.g. `/admin/structure/types/manage/article/display`.
2. For the reference field, set **Format** to **"Slick Entity Reference Vanilla"**
   (`slick_entityreference_vanilla`).
3. Open the formatter's settings gear and pick:
   - **Optionset** — which Slick optionset drives the carousel (setting key `optionset`).
   - **View mode** — how each referenced entity is rendered per slide (key `view_mode`).
   - Inherited Slick options: optional thumbnail/nav optionset, skin, image style, cache, etc.
4. Save.

## Via config / Drush (scriptable)

The component lives in the `entity_view_display` config entity
`core.entity_view_display.{entity_type}.{bundle}.{view_mode}`. The relevant leaf:

```yaml
content:
  field_slick_refs:
    type: slick_entityreference_vanilla
    label: hidden
    settings:
      optionset: default        # a slick config entity id
      view_mode: default        # view mode used to render each referenced entity
    third_party_settings: {}
```

Set it programmatically (works under `drush php:eval` or in an update hook):

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default');
$display->setComponent('field_slick_refs', [
  'type' => 'slick_entityreference_vanilla',
  'label' => 'hidden',
  'settings' => ['optionset' => 'default', 'view_mode' => 'default'],
])->save();
```

Read back which formatter/optionset a field currently uses:

```php
$c = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->getComponent('field_slick_refs');
// $c['type'] === 'slick_entityreference_vanilla'
// $c['settings']['optionset'] === 'default'
```

Or inspect the exported config directly:

```bash
drush config:get core.entity_view_display.node.article.default content.field_slick_refs
```

## Notes

- The carousel's arrows, dots, autoplay, fade, vertical, responsive breakpoints, and skin are
  **all** properties of the chosen Slick optionset, not of this module — change the look by
  editing the optionset at `/admin/config/media/slick`, not the formatter.
- `optionset` defaults to `default` (from Slick's `SlickDefault`); `view_mode` defaults to the
  entity's `default` view mode.
- For Paragraphs, use this formatter on the `entity_reference_revisions` field (or see the
  dedicated `slick_paragraphs` module for richer image/overlay slides).
