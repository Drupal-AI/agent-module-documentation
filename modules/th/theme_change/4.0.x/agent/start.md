<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Theme Change (theme_change) — agent index

Switches the **active theme** per request based on admin-defined rules, each stored as a
`theme_change` **configuration entity**. A tagged `theme_negotiator` service
(`ThemeChangeswitcherNegotiator`, priority 10) loads every rule on each request; a rule matches
either the **current route name** (exact match) or the **current path** (with wildcard support and
path-alias matching). The first matching rule's theme becomes the active theme via
`determineActiveTheme()`. There is no runtime UI beyond CRUD: rules are created/edited/deleted at
`/admin/config/system/theme_change`. Because rules are config entities they export with
configuration, appear in diffs, and are listable.

- Depends on: `drupal:path_alias` (used to match on the current path's alias too).
- Core: `^10 || ^11`. Package: `Other`. Version **4.0.1**.
- Has a settings/collection page (`configure: entity.theme_change.collection`). Provides 3
  permissions, config schema, and one theme-negotiator service. **No drush, no plugin types, no
  hooks** beyond an `.install` upgrade path.

## What you'd do → where

- **Create / edit / delete a "render theme X on route or path Y" rule** (fields, wildcards,
  validation, path vs route) → [configure/theme-rules.md](configure/theme-rules.md)
- **Understand the negotiator service, matching precedence, the config entity type, permissions and
  the install upgrade path** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Config entity type: **`theme_change`** (`Drupal\theme_change\Entity\ThemeChange`, extends
  `ConfigEntityBase`), `config_prefix: theme_change`, `admin_permission:
  access theme change settings page`. Exported keys: `id`, `label`, `type` (`route`|`path`), `path`,
  `route`, `theme`, `uuid`. Config schema: `theme_change.theme_change.*`.
- Service: **`theme.negotiator.theme_change_themeswitcher`** →
  `Drupal\theme_change\Theme\ThemeChangeswitcherNegotiator`, tag `theme_negotiator` **priority 10**.
  Constructor args (services.yml order): `@path.current`, `@path.matcher`, `@current_route_match`,
  `@entity_type.manager`, `@path_alias.manager`.
- Routes / handlers:
  - `entity.theme_change.collection` — `/admin/config/system/theme_change` (`_entity_list`,
    list builder `Drupal\theme_change\Controller\ThemeChangeListBuilder`) — perm
    `access theme change settings page`.
  - `entity.theme_change.add_form` — `/admin/config/system/theme_change/add`
    (`_entity_form: theme_change.add`) — perm `access theme change settings page`.
  - `entity.theme_change.edit_form` — `/admin/config/system/theme_change/{theme_change}`
    (`_entity_form: theme_change.edit`) — perm `access theme change edit page`.
  - `entity.theme_change.delete_form` — `/admin/config/system/theme_change/{theme_change}/delete`
    (`_entity_form: theme_change.delete`) — perm `access theme change delete page`.
- Forms: `ThemeChangeForm` (`add`/`edit`), `ThemeChangeDeleteForm` (`delete`,
  `EntityConfirmFormBase`).
- Permissions (none marked `restrict access`): `access theme change settings page`,
  `access theme change edit page`, `access theme change delete page`.
- Menu link: `theme_change.config` (parent `system.admin_config_ui`). Action links in
  `theme_change.links.action.yml`.
- Install: `theme_change_update_8330()` migrates a legacy `theme_change` DB table into config
  entities (relevant only to very old sites; no `hook_install`/`hook_schema`).
