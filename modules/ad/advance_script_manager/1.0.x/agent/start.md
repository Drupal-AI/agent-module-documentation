<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advance Script Manager (advance_script_manager) — agent index

Admin UI to register named **JavaScript/CSS/tracking snippets** and inject them into a site's
**Header, Body, or Footer** with per-path / role / content-type visibility, ordered by weight —
similar to how the core Block module places blocks. Package `Custom`. **No dependencies** beyond
Drupal core. Core requirement `^10.1 || ^11`. License GPL-2.0-or-later. Version 1.0.5 (dir `1.0.x`).

- **Routes, the single permission, the storage table, config, the three render hooks, and how to
  operate it** → [config/settings.md](config/settings.md)

## What it actually is

- **Not a config entity and not a plugin type.** Snippets live in a plain database table
  `advance_script_manager` defined by `hook_schema()` in `advance_script_manager.install`
  (columns: `id`, `script_name`, `script_code`, `css_code`, `visibility_section`,
  `pages_settings`, `visibility_pages`, `content_type`, `user_roles`, `created`, `updated`,
  `status`, `weight`).
- **One permission:** `advance_script_manager_settings` (`advance_script_manager.permissions.yml`,
  `restrict access: TRUE`) — gates **every** route.
- **Admin section** at `/admin/config/development/advance-script-manager` (menu link under
  *Configuration → Development*; `configure:` route is `advance_script_manager.advance_script_controller_build`).

## Routes (all `_permission: advance_script_manager_settings`, `_admin_route: TRUE`)

- `…/advance-script-manager` — `AdvanceScriptController::build` (search form + list table).
- `…/scripts` (`?num={id}` to edit) — `Form\ScriptsForm` (add/edit a snippet).
- `…/manage-scripts` — `Form\ListscriptsForm` (tableselect + bulk actions).
- `…/search-form` — `Form\SearchscriptsForm` (filter by visibility/status).
- `…/scripts-order-form` — `Form\ScriptsOrderForm` (draggable weight ordering).
- `…/advance_script_manager/delete/{id}` — `Form\ScriptsFormDelete` (confirm).
- `…/advance_script_manager/delete_multiple` (`?ids=a|b|c`) — `Form\ListScriptsFormDeleteMultiple` (confirm).

## Render sinks (in `advance_script_manager.module`)

- **Header** — `hook_page_attachments_alter()`: parses `script_code`/`css_code`, emits
  `#type => html_tag` (`script`/`noscript`/`meta`/`style`/`link`) into `#attached['html_head']`.
- **Body** — `hook_page_top()`: raw `script_code` via `FormattableMarkup`.
- **Footer** — `hook_page_bottom()`: raw `script_code` via `FormattableMarkup`.
- Visibility resolved by `advance_script_manager_check_visibility()` /
  `advance_script_manager_is_valid_path()` against the current path (allow/deny list, `<front>`).

## Config objects

- `advance_script_manager.scripts`, `.listscripts`, `.track` (install defaults + `config/schema`,
  all `type: ignore`) — legacy/placeholder; the live snippet data is the DB table, not config.
