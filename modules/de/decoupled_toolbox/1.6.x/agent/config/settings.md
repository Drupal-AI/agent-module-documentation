<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox — settings, config object, API version

## Config object `decoupled_toolbox.settings`

Form: `DecoupledToolboxSettingsForm` at
`/admin/admin/config/services/decoupled-toolbox` (route `decoupled_toolbox.settings`,
`administer site configuration`; also linked under Config → Services). Shipped default
(`config/install/decoupled_toolbox.settings.yml`): `ignore_missing_entity_reference: true`.

Keys (schema `config/schema/decoupled_toolbox.schema.yml`):

- `ignore_missing_entity_reference` (bool) — when TRUE, entity-reference formatters drop
  deleted/dangling references instead of throwing.
- `version` (float) — the API version number (seeded to `1.00` at install).
- `include_version` (bool) — when TRUE, each rendered record gets a `decoupled_toolbox` key set
  to `version` (read in `RequestEntity::getCollection`).
- `limit` (mapping) — default paging behaviour used when a request omits `limit`:
  - `unlimited` (bool) — no limit (takes precedence over `value`).
  - `required` (bool) — reject requests that omit `limit` (HTTP 400).
  - `value` (int) — default limit when neither of the above applies.

The form's `submitForm()` casts and saves all of the above via
`configFactory->getEditable('decoupled_toolbox.settings')`.

> Schema note: the schema also declares
> `field.formatter.settings.decoupled_generic` (`decoupled_field_key`), the per-formatter
> settings key used across the decoupled formatters.

## API version mechanism

`hook_form_entity_view_display_edit_form_alter()` adds a *Decoupled toolbox* details element to
every entity-view-display edit form with a **Version API** select (`nothing` / `minor +0.1` /
`major +1.0`) and a *Save and update version* button. `_decoupled_toolbox_form_entity_view_display_edit_form_submit()`
increments `decoupled_toolbox.settings:version` by `0.1` (minor) or `1` (major) on save. The
version can also be set directly in the settings form. `decoupled_toolbox_update_9001()` (re)sets
`version` to `1.00`.

## Runtime `settings.php` flag (not config)

`decoupled_toolbox.state.debug_enabled` is read with `Settings::get(...)`, i.e. from
`settings.php`/`settings.local.php`, **not** from configuration. When TRUE, error responses
include the exception message and stack trace. Leave it unset/FALSE in production.
(`RequestEntity::exceptionToResponseMessage()` also carries a temporary upstream `@todo` branch
that returns the message + trace when the setting is entirely absent — set it explicitly to
FALSE to suppress error bodies.)

## Cache flag

`DecoupledRenderer::SETTINGS__CACHE__ENABLED` (also a `Settings::get` value) toggles whether the
renderer reuses/stores per-entity render caches; the collection controller calls
`disableCache()` per request before rendering.
