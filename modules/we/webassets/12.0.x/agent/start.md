<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Assets (webassets) — agent index

A **recipe / config-bundle module** (Webship `web*` suite). Version **12.0.1**, doc dir `12.0.x`.
Core `^11.4 || ^12`. License GPL-2.0-or-later. Almost no PHP: it is config under `recipes/**` plus
one breakpoints YAML and one install hook.

## What it does

Enabling the module runs `webassets_install($is_syncing)` (`webassets.install`), which — unless config
is syncing — applies `recipes/default` via `RecipeRunner::processRecipe(...)`. That recipe chains
`recipes/foundation`, together turning a fresh site into a ready-to-use media library: seven media
types, their fields/form/view displays, five view modes, 35 image styles, five responsive image styles
and eight breakpoints. No settings form (`configure: null`).

## Dependencies

- `composer.json` require (minus php/core): `drupal/crop ~2.0`, `drupal/focal_point ~2.0`,
  `drupal/media_remote_audio ~1.0`, `drupal/media_remote_image ~1.0`, `drupal/media_directories ~2.2.0`,
  `drupal/display_builder ^1.0@beta`. (Media Directories is pulled in but the recipe does NOT enable it.)
- `webassets.info.yml` declares **no** `dependencies:` — modules are turned on by the foundation recipe's
  `install:` list (file, path, image, media, media_library, responsive_image, crop, focal_point,
  media_remote_audio, media_remote_image, display_builder, display_builder_entity_view).
- Change vs 11.0.x: core now supports D12 (`^11.4 || ^12`); `display_builder` added to require;
  Display Builder replaces the Layout Builder wording in older READMEs.

## What it provisions (all via recipe config, not PHP)

- **7 media types**: image, document, audio, video, remote_video (from `recipes/foundation/config`),
  plus remote_audio and remote_image (from the media_remote_* modules, re-imported by the recipe).
- **5 media view modes**: `origenal`, `square`, `standard`, `traditional`, `ultrawide`
  (`core.entity_view_mode.media.*`; note `origenal` is the module's verbatim machine name).
- **35 image styles**: families `origenal_/square_/standard_/traditional_/ultrawide_` × sizes
  `tiny/small/medium/larg/xlarg/xxlarg/xxxlarg`, all using the `focal_point_scale_and_crop` effect.
- **5 responsive image styles** (`responsive_image.styles.*`) mapping derivatives onto the breakpoints,
  `breakpoint_group: webassets`, each with a fallback style.
- **8 breakpoints** in `webassets.breakpoints.yml` under group `webassets`.
- One Display Builder view display on the Image bundle's `standard` mode (`recipes/default/config`).

## Provides

- No routes, no services, no permissions of its own, no plugin types, no Drush commands, no config schema.
- Only the install hook + recipe config + a breakpoints YAML.

## Solution docs

- [Media stack it provisions](config/media-stack.md) — media types, fields (incl. allowed extensions),
  view modes, image styles, responsive image styles, breakpoints.
- [The two-recipe chain](config/recipes.md) — default → foundation, install flow, permission grants,
  standalone application.
