<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View modes + auto-mapped layouts

No settings form. `configure: null`. Two ways to use the inventory.

## What install gives you

`config/install/core.entity_view_mode.node.*.yml` creates 17 node view modes on enable:

- `impressed_card_{xsmall,small,medium,large,xlarge}` → layout `card_impressed`
- `featured_card_{xsmall,small,medium,large,xlarge}` → layout `card_featured`
- `text_card_{small,medium,large}` → layout `card_text`
- `overlay_card_{medium,large,xlarge}` → layout `card_overlay`
- `hero_card` → layout `card_hero`

The view mode → layout / template map is `src/assets/layouts.mapping.vmi.yml`; the plain list
is `src/assets/view_modes.list.vmi.yml`. Layout ids are `ui_patterns:DEFAULT_ACTIVE_THEME:card_*`
where `DEFAULT_ACTIVE_THEME` is replaced at runtime with `system.theme:default`.

## Auto-mapping via the display form (the module's one behavior)

Enabling one of these view modes as a **custom display** on a bundle triggers the mapping.

1. `admin/structure/types/manage/<bundle>/display` → open *Custom display settings*, tick e.g.
   `hero_card`, **Save**.
2. `vmi_form_entity_view_display_edit_form_alter` appends
   `_vmi_form_entity_view_display_edit_form_submit`, which calls
   `ViewModesInventoryFactory::mapViewModeWithLayout()` for each **newly** ticked mode that
   exists in both the list and the mapping.
3. That method loads `src/assets/config_templates/CONTENT_TYPE_NAME/…<mode>.yml`, replaces
   `CONTENT_TYPE_NAME` with the bundle and `DEFAULT_ACTIVE_THEME` with the default theme,
   drops any of `field_image`, `field_video`, `field_media`, `body` the bundle lacks (from
   config `dependencies`, DS `media`/`content` regions and the `content` list), then writes
   `core.entity_view_display.node.<bundle>.<mode>`.

Result: a full DS display — a UI Patterns card component, `node_title` (linked `<h3>`), media
fields in the `media` region, and a `smart_trim` body (300-word trim) in the `content` region.
Re-ticking an already-enabled mode does nothing (only new selections map).

Prerequisites for a clean result on the target bundle: `title`, and (where the card uses them)
`body`, `field_image` / `field_video` / `field_media`. Missing fields are simply skipped.

## Doing it in code

```php
$factory = \Drupal::service('vmi.factory'); // or class_resolver->getInstanceFromDefinition(ViewModesInventoryFactory::class)
$map = $factory->getLayoutsMapping()['mapping']['hero_card'];
$factory->mapViewModeWithLayout(
  'hero_card', $map['layout'], 'node', 'article',
  $map['config_template'], $map['config_name']
);
```

`getViewModesList()` and `getLayoutsMapping()` return the parsed asset YAML;
`filterConfigsForExistingFields($bundle, $templateData)` is the field-pruning step, reusable
standalone.

## Reuse templates without the module runtime

Copy `src/assets/config_templates/CONTENT_TYPE_NAME/*` into a feature module's
`config/install/`, rename `CONTENT_TYPE_NAME` → your bundle in filenames and contents, and
import — the display ships as static config (see `src/assets/README.md`).
