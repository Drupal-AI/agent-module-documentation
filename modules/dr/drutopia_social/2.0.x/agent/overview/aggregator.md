<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Social — aggregator / base-feature overview

Drutopia Social (`drutopia_social`) is a **metapackage-style base feature** in the
[Drutopia](https://www.drupal.org/project/drutopia) distribution. It contributes no code
and no config; its value is a curated dependency set. Read this alongside `../start.md`.

## The whole source

Four files, nothing more:

| File | Content |
| --- | --- |
| `drutopia_social.info.yml` | `dependencies: [block, social_media_links]`; `package: Drutopia`; `core_version_requirement: ^10.2 || ^11 || ^12`; description "Provides a social media block." |
| `composer.json` | `"drupal/social_media_links": "^2"` in `require`; `minimum-stability: dev`; license `GPL-2.0+`. |
| `drutopia_social.features.yml` | `required: true` — a Features/config-packaging marker flagging this as a required Drutopia feature. No config is bundled in this checkout. |
| `README.md` | Prose restating name, project URL, requirement, license. |

No `src/`, no `.module`/`.install`, no `config/install` or `config/schema`, no
routing/services/permissions/menu-link YAML. So there are **no** entities, plugins, routes,
controllers, forms, services, permissions, Drush commands, hooks or config objects to document.

## Dependency set

- **Drupal modules** (`info.yml` `dependencies`): `block` (core), `social_media_links` (contrib).
- **Composer** (`composer.json` `require`, minus php/core): `drupal/social_media_links: ^2`.

Enabling `drutopia_social` enables `block` and `social_media_links`. The
"Social media links" block that becomes placeable is defined by `social_media_links`, not by
this module.

## How to operate it

1. Install: `composer require drupal/drutopia_social -W` (the `-W` lets Composer add
   `social_media_links`). This checkout is a **dev checkout** — `info.yml` has no `version:` and
   `composer.json` sets `minimum-stability: dev`.
2. Enable: `drush en drutopia_social -y` (enables `block` + `social_media_links` too).
3. Configure: there is **no settings form** for this module. Place the Social Media Links block
   at `/admin/structure/block` and set networks, icons, sizing and order on the block itself.
4. Remove: disable the module or delete the block placement.

## How it fits the Drutopia stack

Drutopia is a distribution assembled from small "feature" modules (drutopia_core,
drutopia_site, drutopia_article, etc.), each packaging one opinionated capability. Drutopia
Social is the feature that guarantees a site can present social-network links: rather than each
site re-selecting `social_media_links`, the distribution ships this thin wrapper so the
social-links building block is present and consistent everywhere. Its `features.yml`
`required: true` marks it as a required part of that feature bundle. Because it adds no logic,
its functional and security posture is entirely inherited from `social_media_links` and core
`block`.
