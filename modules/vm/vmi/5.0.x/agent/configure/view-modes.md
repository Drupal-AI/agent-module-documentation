<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View modes + auto-generated core & Canvas displays

No settings form. `configure: null`. Two ways to use the inventory.

## What install gives you

`config/install/core.entity_view_mode.node.*.yml` creates 17 node view modes on enable:

- `impressed_card_{xsmall,small,medium,large,xlarge}`
- `featured_card_{xsmall,small,medium,large,xlarge}`
- `text_card_{small,medium,large}`
- `overlay_card_{medium,large,xlarge}`
- `hero_card`

The plain list is `src/assets/view_modes.list.vmi.yml` (`view_modes:` keyed by id → label; also
lists `full` and `card`, which are not created as new view modes). The per-mode template map is
`src/assets/layouts.mapping.vmi.yml` (`mapping:` keyed by view mode → `config_template`,
`config_name`, `canvas_config_template`, `canvas_config_name`).

## Auto-mapping via the display form (the module's one behavior)

Enabling one of these view modes as a **custom display** on a bundle triggers generation.

1. `admin/structure/types/manage/<bundle>/display` → open *Custom display settings*, tick e.g.
   `hero_card`, **Save**.
2. `VmiHooks::formEntityViewDisplayEditFormAlter` appends `VmiHooks::entityViewDisplayEditFormSubmit`.
   That handler diffs `#default_value` (already-enabled) against `#value` (selected) of
   `modes.display_modes_custom` and, for each **newly** ticked mode present in both the list and
   the mapping, calls `ViewModesInventoryFactory::mapViewModeWithLayout($mode, $entity_type,
   $bundle, $mapping_entry)`. Re-ticking an already-enabled mode does nothing.
3. `mapViewModeWithLayout()` imports up to two templates for the mode via `importConfigTemplate()`:
   - the `config_template` / `config_name` → `core.entity_view_display.node.<bundle>.<mode>`;
   - the `canvas_config_template` / `canvas_config_name` → `canvas.content_template.node.<bundle>.<mode>`
     (if the mapping omits those keys, the path is auto-derived from the mode name).
4. `importConfigTemplate()` resolves the bundle's media field (`getMediaFieldName()`) and
   description field (`getDescriptionFieldName()`), then `str_replace`s the four placeholders
   `CONTENT_TYPE_NAME`, `DEFAULT_ACTIVE_THEME` (from `system.theme:default`), `MEDIA_FIELD_NAME`,
   `DESCRIPTION_FIELD_NAME` in both the config name and the file body, parses the YAML, runs
   `filterConfigsForExistingFields()`, and saves the resulting config with the config factory.
   A template file that does not exist is silently skipped.

### Field resolution (new in 5.0)

- `getMediaFieldName($bundle)` returns the first existing `field.field.node.<bundle>.<name>` from:
  `field_featured_image`, `field_main_image`, `field_image`, `field_media`, `field_video`,
  `field_hero_image`, `field_banner_image`, `field_thumbnail`, `field_cover_image`, `field_photo`,
  `field_media_image`. Default when none exist: `field_featured_image`.
- `getDescriptionFieldName($bundle)` returns the first existing of `body`, `field_body`,
  `field_content`, `field_description`. Default: `field_description`.
- `filterConfigsForExistingFields($bundle, $data)` removes any field the bundle lacks from the
  template's `dependencies.config`, `content` and `hidden` sections. It checks the media and
  description candidates above plus `field_tags`, `field_seo_analysis`, `field_seo_description`,
  `field_seo_image`, `field_seo_title`.

Result: a full `core.entity_view_display` (media field, `smart_trim`/text description field) **and**
a `canvas.content_template` whose `component_tree` binds an SDC card component
(`sdc.<theme>.card`, `card-featured`, `card-impressed`, `card-overlay`, `card-text`, plus
`heading`, `rich-text`, `date`, `image`) to the node's title/media/body via Canvas dynamic-source
expressions (e.g. `entity:node:<bundle> title`, `… MEDIA_FIELD_NAME entity:media:image …`).

Prerequisites for a clean result: a `title`, plus (where the card uses them) one of the media
candidates and one of the description candidates. Missing fields are simply pruned. Note the
`entity_view_display` templates still declare the `smart_trim` formatter/module for the
description field, so that path assumes `smart_trim` is available even though 5.0 no longer
hard-depends on it.

## Doing it in code

```php
$factory = \Drupal::service('class_resolver')
  ->getInstanceFromDefinition(\Drupal\vmi\ViewModesInventoryFactory::class);
$mapping = $factory->getLayoutsMapping()['mapping']['hero_card'];
$factory->mapViewModeWithLayout('hero_card', 'node', 'article', $mapping);
```

`getViewModesList()` and `getLayoutsMapping()` return the parsed asset YAML.
`getMediaFieldName($bundle)` / `getDescriptionFieldName($bundle)` and
`filterConfigsForExistingFields($bundle, $data)` are public and reusable standalone.

## Reuse templates without the module runtime

Copy `src/assets/config_templates/CONTENT_TYPE_NAME/*` into a feature module's `config/install/`,
replace `CONTENT_TYPE_NAME` (and the `MEDIA_FIELD_NAME` / `DESCRIPTION_FIELD_NAME` /
`DEFAULT_ACTIVE_THEME` placeholders) with your real values in filenames and contents, and import —
both the `core.entity_view_display` and `canvas.content_template` ship as static config (see
`src/assets/README.md`).
