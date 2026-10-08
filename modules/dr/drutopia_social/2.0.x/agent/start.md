<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Social (drutopia_social) — agent index

**A Drutopia base feature / aggregator module. Its whole substance is its dependency list — it has no code or config of its own.**

- **Version:** 2.0.x — documented from a **dev checkout** (info.yml has no `version:`; no tagged release in this checkout).
- **Part of:** the [Drutopia](https://www.drupal.org/project/drutopia) distribution. `package: Drutopia`.
- **Core:** `^10.2 || ^11 || ^12`. License GPL-2.0-or-later.
- **Purpose:** depend on core `block` + contrib `social_media_links` so a Drutopia site gets a ready-to-place social media links block.

## What it actually is (from source)

The entire on-disk source is four files:

- `drutopia_social.info.yml` — `dependencies: [block, social_media_links]`, `package: Drutopia`, description "Provides a social media block."
- `composer.json` — `require: {"drupal/social_media_links": "^2"}`, `minimum-stability: dev`.
- `drutopia_social.features.yml` — a single line `required: true` marking it as a required Drutopia feature (features/config-packaging marker; no config bundle is exported here).
- `README.md` — restates the above.

There is **no** `src/`, **no** `config/install` or `config/schema`, **no** `.module` / `.install`, and **no** routing/services/permissions/links YAML. It provides **no** entities, plugins, routes, services, permissions, Drush commands or config schema. All actual behaviour lives in the `social_media_links` dependency.

## Provides

- Dependency wiring only: enabling it enables core `block` and contrib `social_media_links`.
- The "Social media links" block (contributed by `social_media_links`, not by this module) becomes placeable at `/admin/structure/block`.

## Setup

Enable the module (`drush en drutopia_social -y`), then place and configure the Social Media Links block via Block Layout (`/admin/structure/block`). Networks, icons, sizing and order are all set on that block.

## Solution doc

- **What it is, its dependency set, and how it fits the Drutopia stack** → [overview/aggregator.md](overview/aggregator.md)
