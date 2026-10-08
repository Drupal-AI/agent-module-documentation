<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RIFT — Responsive Image Formatter Tools (rift) — agent index

RIFT builds responsive `<picture>`/`srcset` markup from a **media entity reference** field (not a
plain image field). A site "responsive image strategy" is stored as `rift.settings` config: a set of
**screens** (breakpoints → width + media query), a global default `config` block (multipliers,
quality, formats, attributes, fallback transform) and named **view modes** (per view mode: `sizes`,
`aspect_ratios`, `attributes`). Two field formatters (`rift_media_entity_reference_picture` and
`…_with_fallback`) apply a chosen view mode to a media-reference field; a Twig filter
`|rift_picture(config)` does the same directly in templates. The heavy lifting is in the
`rift.picture` service (`RiftPicture::responsivePicture($media, $config)`), which expands each size ×
format × multiplier into a `<source>`/`srcset`, resolves each image URL through a **RiftSource**
plugin (image styles or an external placeholder service) and reads pixels through a **RiftMediaSource**
plugin (which media image field to use, and whether a manual crop exists).

Mechanism detail: rift does **not** ship image styles — it generates them on demand. `RiftSettings`
(and the `rift_starter_kit` form) stamp out `image.style.*` and `crop.type.*` config from YAML
templates under `assets/templates/`; the default `combined_image_style` source plugin chains several
styles into one derivative URL (delivered by an overridden image-style download controller, still
`?itok`-token protected). RIFT overrides core's `image_style` entity class (`hook_entity_type_build`)
to flush combined derivatives correctly.

- Depends on (info.yml): `image_widget_crop`, `image_style_quality`, `focal_point`, `crop`. `rift_ui`
  additionally depends on `rift`; `rift_starter_kit` too.
- Core: `^9.4 || ^10 || ^11`. PHP: `8.1`. Package: `Responsive Images`.
- Settings page / `configure`: **`rift.settings`** (`/admin/config/media/rift`).
- Permissions: `administer rift configuration`, `access rift endpoint` (both `restrict access: true`).
- Provides config schema (`rift.settings`, `field.formatter.settings.rift_picture`). No drush.
- Plugin types: **`rift_source`** (attribute `RiftSource`), **`rift_media_source`** (attribute
  `RiftMediaSource`), and a config-backed **`rift_picture_view_modes`** manager.
- Submodules: **`rift_ui`** (Svelte SPA config app + JSON endpoints), **`rift_starter_kit`**
  (`lifecycle: deprecated` — use RIFT UI instead).

## What you'd do → where

- **Configure the responsive strategy — screens, view modes, `rift.settings` keys, the settings
  form, the starter kit, the RIFT UI app** → [configure/settings.md](configure/settings.md)
- **Render a picture from code/Twig; call `rift.picture`; understand the services, entities, the
  route subscriber, and the `rift_ui` JSON endpoints** → [api/services.md](api/services.md)
- **Write a custom source / media-source plugin, or a view-mode plugin** →
  [plugins/plugins.md](plugins/plugins.md)
- **Apply RIFT to a media-reference field (the two formatters + their applicability rules)** →
  [fields/formatters.md](fields/formatters.md)

## Key facts (real machine names)

- Routes (core): `rift.settings` (`/admin/config/media/rift`, `_form` `RiftSettingsForm`,
  `_permission: administer rift configuration`).
- Routes (`rift_ui`): `rift_ui.config` (`/admin/config/media/rift/rift-ui`),
  `rift_ui.api.settings.get` (`GET /api/rift`), `rift_ui.api.settings.post` (`POST /api/rift/update`)
  — all `administer rift configuration`; `rift_ui.media` (`/media/{media}/rift-ui`),
  `rift_ui.media.endpoint.all` (`/media/{media}/rift`) — `access rift endpoint`.
- Route (`rift_starter_kit`): `rift_starter_kit.wizard`
  (`/admin/config/media/rift/rift-starter-kit`, `_form` `RiftStarterKit`).
- Services: `rift.picture` (`RiftPicture`), `rift.twig_extension` (`Rift`, twig.extension),
  `rift.settings` (`RiftSettings`), `rift.media` (`RiftMedia`, **deprecated**),
  `plugin.manager.rift_source`, `plugin.manager.rift_media_source`,
  `plugin.manager.rift_picture_view_modes`, `rift.route_subscriber` (`RouteSubscriber`),
  `cache.rift_image_dimensions` (cache bin).
- Twig filter: **`rift_picture`** — `{{ media|rift_picture(config) }}` (accepts a `MediaInterface`).
  Altered via `hook_rift_alter(&$filters)` / theme `rift` alter.
- Field formatters (`entity_reference` → media): `rift_media_entity_reference_picture`,
  `rift_media_entity_reference_picture_with_fallback`.
- Plugin managers/types: `rift_source` (dir `Plugin/RiftSource`, iface `RiftSourceInterface`,
  attribute `Drupal\rift\Attribute\RiftSource`, alter `hook_rift_source_alter`) — bundled ids
  `combined_image_style` (default), `dummyimage`, `placeholdco`, `placeholdit`. `rift_media_source`
  (dir `Plugin/RiftMediaSource`, iface `RiftMediaSourceInterface`, attribute `RiftMediaSource`,
  alter `hook_rift_media_source_alter`) — bundled ids `image`, `multiple_image` (default in install
  config), `placeholder`. `rift_picture_view_modes` (`RiftPictureViewModes`, YAML discovery
  `*.rift_picture_view_modes.yml` merged with `rift.settings:view_modes`).
- Entities: `Drupal\rift\Entity\ImageStyle` (replaces core `image_style` class),
  `Drupal\rift\Entity\CombinedImageStyle` (chained-style derivative + `?itok` token).
- Config keys (`rift.settings`): `media_source`, `source`, `aspect_ratios[]`,
  `config` (`screens`, `transforms`, `multipliers[]`, `quality{}`, `formats[]`, `attributes{}`,
  `fallback_transform`), `view_modes{}`. Update hooks: `rift_update_9101`, `rift_update_9102`.
- Cache bin `rift_image_dimensions`; discovery cache tag `rift_picture_view_modes`.
