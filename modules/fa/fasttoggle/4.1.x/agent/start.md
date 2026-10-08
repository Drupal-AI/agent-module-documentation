<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fasttoggle (fasttoggle) — agent index

Adds one-click **AJAX toggle links** for node and comment status to entity operation links, so
editors can flip values without the edit form. Package `Administration`. License GPL-2.0-or-later.
Version 4.1.0. Core `^10.1 || ^11`.

## Dependencies

- `drupal:node` — the node entity and its published/promoted/sticky properties.
- `drupal:comment` — the comment entity and its published property.
- No Composer requirements (composer.json `require` is empty); no external libraries.

## What it provides (from source)

- **Route `fasttoggle.toggle`** — `/fasttoggle/{entity_type}/{entity_id}/{action}`, controller
  `FasttoggleController::toggle` (`src/Controller/FasttoggleController.php`), permission `use fasttoggle`.
  Flips the property and returns an AJAX `ReplaceCommand`. → [api/toggle-route.md](api/toggle-route.md)
- **Route `fasttoggle.settings`** — `/admin/config/system/fasttoggle`, form
  `FasttoggleSettingsForm` (`src/Form/FasttoggleSettingsForm.php`), permission `administer fasttoggle`.
  One radio setting: `label_style`. → [config/settings.md](config/settings.md)
- **Hook class** `Drupal\fasttoggle\Hook\FasttoggleHooks` (`src/Hook/FasttoggleHooks.php`, autowired
  service, `#[Hook]` attributes with legacy wrappers in `fasttoggle.module`): `help`,
  `node_links_alter`, `comment_links_alter`, `form_node_type_edit_form_alter`,
  `form_comment_type_edit_form_alter`, plus entity builders. → [hooks/links-and-bundle-settings.md](hooks/links-and-bundle-settings.md)
- **Config**: `config/install/fasttoggle.settings.yml` (`label_style: 1`); schema in
  `config/schema/fasttoggle.schema.yml` for `fasttoggle.settings` and the per-bundle third-party
  settings `node.type.*.third_party.fasttoggle` and `comment.type.*.third_party.fasttoggle`.
- **Permissions** (`fasttoggle.permissions.yml`): `administer fasttoggle`, `use fasttoggle`.
- **Menu link** (`fasttoggle.links.menu.yml`): `fasttoggle.settings` under System configuration.

## What it does NOT provide

No entities, no plugin types, no Drush commands, no services beyond the hook class, no fields, no
submodules. In 4.1.x it toggles only node (`status`, `promote`, `sticky`) and comment (`status`);
there is no user toggle.

## Install / operate

1. `composer require drupal/fasttoggle` then `drush en fasttoggle -y`.
2. Enable toggles per bundle: Structure > Content types > [type] > **Fasttoggle** (status/promote/sticky);
   comment types have a status checkbox on their edit form.
3. Grant `use fasttoggle` to the roles that should see the links; `administer fasttoggle` for the settings form.
4. Set the label style at Configuration > System > **Fasttoggle** (route `fasttoggle.settings`).
