<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permissions and Drush

## Routes (`drd.routing.yml`)

All DRD routes live under `/drd` and set `_admin_route: TRUE`. There is **no anonymous or
token-authenticated endpoint** in this module.

- `drd.main` → `/drd`, controller `Dashboard::status`, permission **`drd.access`** (the module's
  configure route).
- `drd.settings` → `/drd/settings`, form `Form\Settings`, permission **`drd.administer`**.
- Per entity type (`drd_host`, `drd_core`, `drd_domain`, `drd_project`, `drd_major`, `drd_release`,
  `drd_requirement`, `drd_script`, `drd_script_type`): `canonical` (requires `_entity_access
  {type}.view`), `collection` (`view {type} entities`), `add`/`edit`/`delete` (`drd.add|edit|delete
  {type} entities`), and a `{type}.settings` admin form (`drd.administer {type} entities`).
- Domain-specific: `entity.drd_domain.activity` (dblog view), `entity.drd_domain.return_remote`
  (`Controller\Domain::returnFromRemote`, **`_csrf_token: TRUE`**), `entity.drd_domain.session`
  (`Controller\Domain::session`, returns a `TrustedRedirectResponse` to the remote login), and
  `entity.drd_domain.reset_form`. All require `drd.edit domain entities`.
- `entity.drd_core.updatelog` → core update log form (`drd.administer core entities`).

## Permissions

Two sources:

1. **Static** (`drd.permissions.yml`): `drd.access`, `drd.administer`, and per entity type the
   `add / administer / delete / edit / view published / view unpublished {type} entities` set. The
   `administer …` permissions carry `restrict access: true`.
2. **Dynamic per-action** (`ActionPermissions::permissions`, registered as a
   `permission_callbacks`): for every `action` config entity of type `drd`/`drd_host`/`drd_core`/
   `drd_domain`, a permission whose **machine name equals the action plugin id** (e.g.
   `drd_action_php`, `drd_action_database`) titled "Execute action …". Its `restrict access` comes
   from the plugin's `restrictAccess()` (TRUE by default). `Plugin\Action\Base::access()` checks
   exactly this permission — except it returns *allowed* unconditionally under CLI or cron
   (`PHP_SAPI === 'cli' || @ignore_user_abort()`).

Because a granted per-action permission lets a role execute high-impact operations (run PHP, run
update.php, download the database, open a remote session) against every managed site, these should
be treated as administrative and granted only to trusted roles.

## Menu / links / Drush

- `drd.links.menu.yml`, `drd.links.task.yml`, `drd.links.action.yml` build the dashboard menu,
  local tasks and add-links; `Plugin/Menu/LocalAction/AddCoreAction.php` adds a contextual add link.
- Drush: `src/Drush/Commands/DrdCommands.php` (+ `DrdCommandsTrait`) exposes DRD actions on the CLI;
  `src/Drush/Generators/ActionPlugin.php` scaffolds new action plugins (with `V6`/`V7`/`V8` remote
  templates). Submodule `drd_migrate` adds `drd:migratefromd7`.
- Libraries: `drd.libraries.yml` (`drd/general` attached to every page for users with `drd.access`,
  via `hook_page_attachments`).
