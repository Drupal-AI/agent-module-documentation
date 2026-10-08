<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Core (drutopia_core) — agent index

**The required base *feature* of the Drutopia distribution: it declares the shared component dependency set and ships the distribution's site-wide default configuration.** No `src/`, no routes, no services, no permissions of its own — a dependency + configuration bundle. Package `Drutopia`. License GPL-2.0-or-later. Core `^10.2 || ^11 || ^12`.

- **Documented version:** 2.0.x — **this checkout is a dev checkout** (`drutopia_core.info.yml` has no `version:` line; installed from the `2.0.x` branch). data.json `version` is set to `2.0.x` for the version dir.
- **On this site it did not enable** because the full Drutopia dependency chain (e.g. the media contextual-crop adapters / other contrib) was not all present. That is **expected** for this campaign — these docs are grounded in the on-disk source, not a running instance.

## What it actually is

- A Features-style module (`drutopia_core.features.yml`, `bundle: drutopia`, `required: true`). Its payload is configuration, not code.
- **Only executable code:** `drutopia_core.install` — update hooks `_8101`, `_8102`, `_8103`, `_10201` that call `module_installer->install(...)` to add dependencies on upgrade. No `hook_install`, no schema, no runtime logic.
- **Config shipped:** ~155 files in `config/install/` + 5 config-action files in `config/actions/`. Establishes site roles, media types, paragraph types, fields, image/responsive styles, crop types, view/form modes, taxonomy, pathauto and a Search API DB server.
- **Dependencies (info.yml):** core `ckeditor5, datetime, field, file, image, link, media, media_library, node, responsive_image, taxonomy, text, user`; contrib `automated_crop, config_perms, crop, ds, exclude_node_title, faqfield, focal_point, image_widget_crop, media_contextual_crop_fp_adapter, media_contextual_crop_iwc_adapter, media_library_media_modify, media_responsive_thumbnail, metatag, paragraphs, pathauto, rdf, search_api (+search_api_db), video_embed_field`. (composer.json `require` adds a few more that info.yml does not enable — see data.json `composer_requirements`.)
- **Provides:** no `.permissions.yml`, no `.routing.yml`, no `.services.yml`, no `config/schema/` (so `provides_config_schema=false`), no Drush commands, no plugin types. `drutopia_core.breakpoints.yml` defines six breakpoints (all/mobile/tablet/desktop/widescreen/fullhd).

## Solution docs

- **Install / enable & the update hooks** → [install/upgrade.md](install/upgrade.md)
- **Site-wide roles & their exact permission sets** → [config/roles.md](config/roles.md)
- **What the ~155 config files provide (grouped)** → [config/shipped-config.md](config/shipped-config.md)

## Notes

- No settings form (`configure` is null). Each component it installs is configured through that component's own admin pages.
- No text formats (`filter.format.*`) are shipped by this module; CKEditor 5 and text formats come from core / the install profile.
