<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Pollination (seeds_pollination) — agent index

A grab-bag helper for the **Seeds distribution**: several small, individually-toggled
site-building/admin conveniences, one Layout Builder layout, and Drush safety hooks. Package
`Seeds`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.3. **No declared module or
composer dependencies**; features soft-detect optional modules and no-op when they are absent.
Nothing here contacts external services or other sites — the name is metaphorical.

## What it provides

- **Settings form** `SeedsPollinationSettingsForm` at route **`seeds_pollination.settings`**
  (`admin/config/user-interface/seeds-pollination`, menu link under *Configuration → UI*),
  writing config object **`seeds_pollination.settings`**. Route requires permission
  `administer seeds pollination settings` (note: the module ships **no `*.permissions.yml`**, so
  that permission is undefined and only user 1 reaches the form until it is defined elsewhere).
- **Config-entity descriptions**: `hook_form_alter` + `hook_entity_type_alter` add a required
  "(Administrative) Description" to selected config entities, stored as the
  `seeds_pollination`/`description` third-party setting; four list builders
  (`SeedsFieldConfigListBuilder`, `SeedsEntityQueueListBuilder`, `SeedsRoleListBuilder`,
  `SeedsFormModeListBuilder`) render it as a column.
- **Container settings**: bundle forms get a *Fluid Container* checkbox saved into
  `seeds.container_settings` (key `{bundle_of}_{id}`), read by themes.
- **Seeds Lighthouse layout**: plugin `SeedsLighthouse` (`seeds_pollination.layouts.yml`,
  `templates/seeds-lighthouse.html.twig`) — 20+ regions, per-row container selectors, wrapper
  id/classes.
- **Un-masquerade button**, **user-1 edit lock**, **lowercase file extensions**,
  **node-title-as-placeholder**, **translations.yml importer** — all via hooks in
  `seeds_pollination.module`.
- **Drush policy hooks**: `Drush/Commands/PolicyCommands.php` guards `sql:sync`, `core:rsync`,
  `sql:drop`.

## Solution docs

- Settings object, every toggle, and config keys → [config/settings.md](config/settings.md)
- The `seeds_pollination` hooks and how each feature is wired → [hooks/features.md](hooks/features.md)
- The `Seeds Lighthouse` Layout Builder layout → [layouts/seeds-lighthouse.md](layouts/seeds-lighthouse.md)
- The Drush safety command hooks → [drush/policy.md](drush/policy.md)
