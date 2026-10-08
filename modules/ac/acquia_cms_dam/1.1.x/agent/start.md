<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia CMS DAM (acquia_cms_dam) — agent index

Configuration-only glue module for the Acquia CMS distribution. Integrates **Acquia DAM (Widen)**
asset media into an Acquia CMS / Acquia Drupal Starter Kit site. It ships default configuration and
one install hook; it adds **no** routes, permissions, services, plugin types, config schema, or PHP
classes. The real DAM API integration, media source, auth, and embed formatters live in the
`acquia_dam` module — this module only wires that into the distribution's content model and theming.

- **Version:** 1.1.1. **Core:** `^9.4 || ^10 || ^11`. **License:** GPL-2.0-or-later.
- **Dependencies (info.yml):** `acquia_cms_image`, `acquia_cms_video`, `acquia_dam`,
  `acquia_dam:acquia_dam_integration_links`. **Composer:** `drupal/acquia_cms_image ^1.5.10`,
  `drupal/acquia_cms_video ^1.5.8`, `drupal/acquia_dam ^1`. Conflicts with pre-1.5 Acquia CMS parts.
- **Configure route:** none of its own. DAM auth/domain is set via `acquia_dam` at
  `/admin/config/acquia-dam` and per-user under `/user` → Acquia DAM tab (see README).

What it provides:
- **Media view displays** (`config/optional/`) for bundles `acquia_dam_image_asset` and
  `acquia_dam_video_asset` across Acquia CMS view modes / image styles.
- **Site Studio (Cohesion) content templates + sync package** (`config/pack_acquia_cms_dam/`,
  package id `pack_acquia_cms_dam`) for rendering DAM assets in Site Studio.
- **Two hook implementations** in `acquia_cms_dam.module`: `hook_modules_installed()` rewires
  content-type image fields and the Site Studio image browser; helper
  `_acquia_cms_dam_update_content_type_image_field()`.

Solution docs:
- [config/setup.md](config/setup.md) — dependencies, shipped config objects, the install hook
  behavior, view modes/bundles, and how to operate the integration.
