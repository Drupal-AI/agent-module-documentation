<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webpage (webpage) — agent index

Recipe-driven **config-bundle** module (Webship `web*` suite). Version **12.0.1**, dir `12.0.x`.
Core `^11.4 || ^12`. Provides a general-purpose **`webpage` node type** built with the **Display Builder**.

## What it is

Almost no PHP. `webpage.info.yml` declares no module `dependencies`; `webpage.install`
(`webpage_install($is_syncing)`) applies `recipes/default` on install (guarded by
`\Drupal::isConfigSyncing()` / `$is_syncing` so a config import does not double-apply it).
There is **no** settings route, no permissions, no Drush commands, no `config/schema`, no `src/`.

## Composer dependencies (`composer.json` require, minus core)

`drupal/pathauto ~1.0`, `drupal/field_group ~4.0`, `drupal/smart_trim ~2.0`,
`drupal/display_builder ^1.0@beta`, `drupal/webform ^6.3`.

## What the recipe provisions

- **`webpage` content type** — revisions + preview on, submitted-info hidden, linked into the `main` menu.
- **`body`** field (`text_with_summary`) + shared `field.storage.node.body`.
- **`promote`** base-field override (default off).
- **View modes** `teaser` (enabled) and `full` (status false); the `teaser`/`full` **view displays
  render via Display Builder** (`third_party_settings.display_builder`, profile `default`).
- **`editorial`** content-moderation workflow bound to `node:webpage`; default state **Draft**.
- **Pathauto** pattern `[node:menu-link:parent:url]/[node:title]` for the `webpage` bundle.
- Core content plumbing (image/datetime/options/menu_link_content/views), core content views,
  image styles, and **Webform** + Webform UI with a contact form at `/form/contact`.

The recipe enables its module stack in this order (see `recipes/default/recipe.yml`) and imports
display_builder / image / node / user / webform config, then runs a `simpleConfigUpdate` on the
contact webform. Full stack listing in [recipe/default.md](recipe/default.md).

## Solution docs

- [recipe/default.md](recipe/default.md) — the default recipe: modules enabled, config imported, contact form.
- [config/content-type.md](config/content-type.md) — the `webpage` type, fields, view modes/displays, workflow, pathauto, and how an editor uses it (with screenshots).
