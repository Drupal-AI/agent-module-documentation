<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Diba integration extra (diba_integration_extra) — agent index

Dependency-only legacy bundle submodule of DiBa Integration. Ships no code — only `diba_integration_extra.info.yml` + `composer.json`.

## What it is
- Declares dependencies on `diba_carousel` and `responsivewrappers` so the legacy DiBa add-on stack enables together.
- Package `diba`. **Core requirement `^10.3` only** (`core_semver_maximum` = D11.0.0 exclusive) — cannot be enabled on Drupal 11/12; it is deliberately held back until its dependencies support D11.
- No routes, permissions, services, hooks or config objects.

## Operating notes
- Enable with `ddev drush en diba_integration_extra -y` on a Drupal 10 site; this pulls in `diba_carousel` (carousel/slider) and `responsivewrappers` (responsive wrapper utilities).
- During a Drupal 11 upgrade this submodule (and its two dependencies) must be removed/replaced; it exists to flag the D10-only surface of the platform.
