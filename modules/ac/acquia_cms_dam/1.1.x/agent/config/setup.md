<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia CMS DAM — setup & shipped configuration

Pure config/glue module. Enabling it applies default DAM display config and, via one install hook,
mutates existing Acquia CMS content-type image fields and Site Studio settings. It performs no API
calls, defines no routes/permissions/services, and has no `config/schema/` or `config/install/`
(only `config/optional/` and `config/pack_acquia_cms_dam/`).

## Install / enable

`composer require drupal/acquia_cms_dam` then enable. Dependencies (`acquia_cms_dam.info.yml`):
`acquia_cms_image`, `acquia_cms_video`, `acquia_dam`, `acquia_dam:acquia_dam_integration_links`.
DAM connectivity itself is configured through `acquia_dam` (README): set the Acquia DAM domain at
`/admin/config/acquia-dam`, then authenticate per-user via the "Acquia DAM" tab on `/user`.

## Shipped configuration

`config/optional/` — `core.entity_view_display.media.*` for two media bundles that come from
`acquia_dam`:
- `acquia_dam_image_asset`: view modes `default`, `teaser`, `embedded`, `full`, plus Acquia CMS
  image styles `small`, `small_landscape`, `medium`, `medium_landscape`, `large`,
  `large_landscape`, `large_super_landscape`, `x_small_square`. Each renders the
  `acquia_dam_asset_id` field with the `acquia_dam_embed_code` formatter (embed_style `original`,
  label hidden) and hides created/langcode/name/thumbnail/uid/search_api_excerpt.
- `acquia_dam_video_asset`: view modes `embedded`, `full`, `video_component`.

These are `config/optional`, so they import only when their dependencies (e.g.
`media.type.acquia_dam_image_asset`, the relevant `core.entity_view_mode.*`, and `acquia_dam`)
already exist.

`config/pack_acquia_cms_dam/` — Site Studio (Cohesion) artifacts:
- `cohesion_sync.cohesion_sync_package.pack_acquia_cms_dam` — sync package "Acquia CMS DAM"
  bundling the DAM templates (enforced module deps: `acquia_cms_dam`, `acquia_cms_site_studio`).
- 15 `cohesion_templates.cohesion_content_templates.media_acquia_dam_*` content templates for
  embedding DAM image/video assets in Site Studio (each enforces `acquia_cms_dam` +
  `acquia_cms_site_studio`, referencing image styles like `image.style.coh_medium`).

## Install hook behavior — `acquia_cms_dam.module`

`hook_modules_installed($modules, $is_syncing)` (skips when `$is_syncing`):
1. For content model modules `acquia_cms_article`, `acquia_cms_event`, `acquia_cms_page`,
   `acquia_cms_person`, `acquia_cms_place` that exist, calls the helper below to make their image
   field accept DAM image assets, then `drupal_flush_all_caches()`. (Runs when `acquia_cms_dam`
   itself or any of those content modules is in the just-installed set.)
2. If `acquia_cms_site_studio` exists, sets `cohesion.settings` `image_browser` (both `config` and
   `content` contexts) to a `medialib_imagebrowser` using entity browser `media_browser` with
   `cohesion_media_lib_types` = `['image', 'acquia_dam_image_asset']`, so Site Studio's image
   picker also offers DAM images.

`_acquia_cms_dam_update_content_type_image_field(string $node_type)` edits
`field.field.node.<type>.field_<type>_image`: adds `media.type.acquia_dam_image_asset` to
`dependencies.config`, sets `settings.handler_settings.target_bundles.acquia_dam_image_asset`, and
defaults `settings.handler_settings.sort.direction` to `ASC` — i.e. the content type's existing
image field can now reference DAM image assets alongside local images.

## Operating notes

- Because the field/config changes fire on install of the content modules or this module, install
  order is handled by the hook re-checking on each `modules_installed` event.
- To render DAM assets, ensure the `acquia_dam` media types and view modes exist first (they gate
  the optional config import).
- Uninstalling does not revert the content-type image-field edits; they persist in exported config.
