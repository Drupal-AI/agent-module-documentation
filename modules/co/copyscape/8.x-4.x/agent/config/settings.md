<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Copyscape — configuration, routes, permissions, entities

## Install / enable
Core-only module. `composer require drupal/copyscape` then enable `copyscape`. `info.yml` sets
`configure: copyscape.settings`. `hook_uninstall()` (`copyscape.install`) deletes both config
objects. A working Copyscape Premium account is required for any check to run.

## Config objects (schema: `config/schema/copyscape.schema.yml`)

### `copyscape.settings` — form `CopyscapeApiUserForm` at `/admin/config/copyscape/api`
Keys and shipped defaults (`config/install/copyscape.settings.yml`):
- `api_url` (string) — Copyscape API endpoint. Shipped default `http://www.copyscape.com/api`.
- `api_user` (string) — Copyscape account username (query param `u`).
- `api_key` (string) — Copyscape account key (query param `k`).
- `user_bypass` (string) — comma-separated user IDs that skip checking.
- `roles_bypass` (sequence) — roles that skip checking.
- `failures` (string) — max fails before the editor is blocked+logged out; `0`/empty disables.
- `logs` (boolean) — when true, successful responses are stored as `copyscape_result` entities.
- `show_plag_check_as_warning` (checkbox in the form; used by `copyscape_form_validate`) — when set,
  a match produces a warning message instead of a blocking validation error.

Note two real quirks in `CopyscapeApiUserForm`: the form reads `users_bypass` but **saves**
`user_bypass` (and `Utility::userCanBypass()` reads `users_bypass`), so the UID bypass list does not
round-trip; and the `roles_bypass` write is commented out in `submitForm()`, so role bypass is not
persisted through this form. `show_plag_check_as_warning` is not declared in schema.

### `copyscape.content` — form `CopyscapeContentForm` at `/admin/config/copyscape/content`
Keys (`config/install/copyscape.content.yml`): `reject_content` (bool, enable threshold),
`reject_value` (string %, matches strictly greater than this are rejected — see
`Utility::wasSuccessful()`), `site_ignore` (string, comma-separated domains passed as query `i`),
`copyscape_ct` (sequence: per-bundle → field-machine-name map of checked fields), and dynamic keys
`copyscape_ct_para_field<bundle>` (Paragraph field path such as `parent:para_field:i`; `:i` checks
each value individually, otherwise values are combined). The form only lists `text_long`,
`string_long`, `text_with_summary` fields and iterates bundles via `node_type_get_names()`.

## Routes & permissions (`copyscape.routing.yml`, `copyscape.permissions.yml`)
- `copyscape.settings` `/admin/config/copyscape` — admin menu block, `_permission: administer copyscape`.
- `copyscape.settings_api`, `copyscape.settings_content` — the two config forms, `administer copyscape`.
- `copyscape.results` `/copyscape/results` — `ResultsController::results()`, `_permission:
  administer copyscape entities`.
- `entity.copyscape_result.delete_form` `/copyscape/{copyscape_result}/delete` —
  `_entity_access: copyscape_result.delete`.
- Permissions `administer copyscape` and `administer copyscape entities` are both
  `restrict access: true`.

## Entities (`src/Entity/`, access `src/Access/CopyscapeAccessControlHandler.php`)
- `copyscape_result` (base table `copyscape_result`): fields `uid`, `nid`, `created`, `name`
  (node title), `response` (`string_long`, holds `serialize()`d parsed API result). Written by
  `Utility::saveResults()` only when `copyscape.settings.logs` is true, from
  `copyscape_node_insert/update`.
- `copyscape_fail` (base table `copyscape_fail`): fields `uid`, `fails`, `created`. Incremented by
  `Utility::updateUserFails()`, cleared by `resetUserFails()`.
- Both entities' `checkAccess()` allows `view`/`update`/`delete` only with `administer copyscape
  entities`; `admin_permission` is the same. `ResultsController::results()` runs its entity query
  with `accessCheck(FALSE)` but the route itself is gated by that admin permission and renders
  matched URLs/percentages through `Xss::filter()`; the delete link targets the entity delete form.

## Menu (`copyscape.links.menu.yml`)
Adds `Copyscape Settings` under `system.admin_config`, with `API and User Settings` and
`Content Settings` child links.
