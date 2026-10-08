<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity change default language UI (entity_change_default_language_ui) — agent index

Back-office **UI** on top of the `entity_change_default_language` API module for changing a node's
**default (original) language** and pruning its translations — one node at a time, or in bulk with a
batch. Package `Multilingual`. Core `^9.1 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x.

- **The two forms, their routes, permission, fields and how the language change is performed** →
  [forms/change-default-language.md](forms/change-default-language.md)
- **The `Updater` service (query + delegation to the API module) and the entity-operation hook** →
  [api/updater.md](api/updater.md)

## What it actually is

- **Depends on** `entity_change_default_language` (the API module that does the actual langcode
  rewrite / translation delete). No other module deps, no libraries, no config, no permissions of
  its own, no Drush.
- **Two routes** (`entity_change_default_language_ui.routing.yml`):
  - `entity_change_default_language_ui.form` → `/node/{node}/change-default-language`
    (`_form: ChangeDefaultLanguageForm`, `_admin_route: TRUE`).
  - `entity_change_default_language_ui.batch_form` → `/admin/config/regional/change-default-language`
    (`_form: ChangeDefaultLanguageBatchForm`).
- **One service** `entity_change_default_language_ui.updater` (`src/Updater.php`) — form helper that
  lists languages/bundles, queries target nodes, resolves the current node, and delegates the write
  to `@entity_change_default_language`.
- **hook_entity_operation** (`entity_change_default_language_ui.module`) adds a *"Change default
  language"* operation link to every **node** row (weight 42) on admin content lists.
- **Menu link** (`.links.menu.yml`) puts the batch form under *Configuration → Regional and
  language* (`system.admin_config_regional`).
- Both forms are standard Form API forms (POST + CSRF token) targeting **nodes only**.
