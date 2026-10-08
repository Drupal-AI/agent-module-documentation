<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & configuration

## Install / enable
`ddev drush en attempt_mgmt -y`. No dependencies outside core (`info.yml`: `core_version_requirement: ^10 || ^11`, `package: Other`). The module is installed here from a git dev checkout, so `info.yml` has no `version:` line — hence version dir `1.0.x`.

## Site-wide config object: `attempt_mgmt.settings`
Form: `src/Form/SettingsForm.php` (`SettingsForm extends ConfigFormBase`, form id `attempt_mgmt_settings`) at route `attempt_mgmt.settings` → `/admin/config/system/attempt-management/settings`, requirement `_permission: 'administer site configuration'`, `_admin_route: TRUE`. Editable config: `attempt_mgmt.settings`.

Keys (defaults from `config/install/attempt_mgmt.settings.yml`; all four are `#required` on the form):
- `attempt_question` (textarea, maxlength 255) — "An attempt already exists. Do you want to proceed…"
- `proceed_attempt_label` (textfield) — "Proceed with attempt"
- `start_new_attempt_label` (textfield) — "Start new attempt"
- `attempt_limit_exceeded` (textarea, maxlength 255) — "You have reached the maximum of allowed attempts!"

The install file also ships `status: true`. These strings are read by `AttemptFactory::getAttemptConfig()` and are meant for a driving module's confirm UI. The form's `validateForm()` is a no-op (only `parent::validateForm`).

Config schema: `config/schema/attempt_mgmt.schema.yml` → `attempt_mgmt.settings` (type `config_object`, each string typed `label`). Translatable via `attempt_mgmt.config_translation.yml`. `provides_config_schema: true`.

Schema also defines the field settings/value types for the [attempt settings field](../fields/settings-field.md): `attempt_mgmt_attempt_settings`, `field.value.attempt_mgmt_attempt_settings`, `field.field_settings.attempt_mgmt_attempt_management`, `field.widget.settings.attempt_mgmt_settings_default`; and `config/schema/attempt_mgmt.entity_type.schema.yml` defines `attempt_mgmt.attempt_mgmt_attempt_type.*` (id/label/uuid) for attempt-type config entities.

## Attempt types (bundles)
Config entities `attempt_mgmt_attempt_type`, managed at `/admin/structure/attempt_mgmt_attempt_types` (menu link under Structure). Create at least one before attaching the field. See [entities doc](../entities/attempt.md).

## Menu / task / action links
- `attempt_mgmt.links.menu.yml`: Structure → "Attempt types"; Content → "Attempts"; Config › System → "Attempt Management Settings".
- `attempt_mgmt.links.task.yml`: tabs on the content and attempt-type pages plus the settings route.
- `attempt_mgmt.links.action.yml`: "Add attempt type" and "Add attempt" action buttons.

## Libraries & assets
`attempt_mgmt.libraries.yml` declares `confirm-form-design` (CSS `assets/css/style.css`) — a small theme library for the confirm form; no external/JS dependencies.

## Install schema table (`attempt_mgmt.install`)
`attempt_mgmt_schema()` creates `attempt_mgmt_settings` (columns: `id` serial, `entity_type` varchar32, `entity_id` int, `plugin_id` varchar255, `settings` big blob; indexed on entity_type/entity_id/plugin_id) and `attempt_mgmt_uninstall()` drops it. `AttemptFactory`'s `settingExists()/loadSettings()/insertSettings()/updateSettings()` target this table, but the current attempt flow stores its configuration in the entity's `attempt_mgmt_attempt_settings` field instead, so this table is unused by the shipped code paths. Update hooks: `attempt_mgmt_update_10001()` adds a `force_new_attempt` field column via the address.install-derived helper; `attempt_mgmt_update_10002()` deletes an obsolete config object.
