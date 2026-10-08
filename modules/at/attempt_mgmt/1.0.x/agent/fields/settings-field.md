<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attempt settings field (`attempt_mgmt_attempt_settings`)

The field you attach to a host content entity to turn on attempt management for it. Attach it via Field UI (Manage fields) on any bundle. Cardinality 1.

## Field type — `src/Plugin/Field/FieldType/AttemptManagementItem.php`
`@FieldType(id = "attempt_mgmt_attempt_settings", default_widget = "attempt_mgmt_settings_default", default_formatter = "attempt_mgmt_settings_default", cardinality = 1)`, `final class AttemptManagementItem extends FieldItemBase`.

Properties / columns (`propertyDefinitions()`, `schema()`):
- `attempt_type` (string 32, required) — which `attempt_mgmt_attempt_type` bundle new attempts use.
- `enabled` (boolean) — attempt management on/off.
- `limit` (integer, required) — max attempts (widget clamps 0-100; 0 = unlimited, see `AttemptFactory::allowNewAttempt`).
- `force_new_attempt` (boolean) — force a fresh attempt on each visit.
- `grading_method` (string, required) — `best_attempt` or `last_attempt`.
- `display_status` (boolean) — show attempt status to the user.
- `attempt_confirm_delay` (integer, required) — ms delay before showing the confirm form.
- `lock` (boolean) — lock the item after the final allowed attempt.

Getters: `getAttemptType()`, `getEnabled()`, `getLimit()`, `getForceNewAttempt()`, `getGradingMethod()`, `getDisplayStatus()`, `getAttemptConfirmDelay()`, `getLock()`.

### Field settings + overrides
`fieldSettingsForm()` renders a required **Attempt type** radios list (from `attempt_mgmt_attempt_type` entities; warns with an "Add attempt type" link if none exist) and a **Field overrides** table. Overrides let a field force a property to be hidden (`FieldOverride::HIDDEN`; optional/required are stubbed out in code). `getFieldOverrides()` resolves overrides from the `fields` / `field_overrides` settings; `getProperties()` then unsets hidden properties via `FieldHelper::getPropertyName()`. Field names are enumerated by `Utility\AttemptMgmtField` (an `AbstractEnum`: ENABLED, ATTEMPT_TYPE, LIMIT, FORCE_NEW_ATTEMPT, GRADING_METHOD, DISPLAY_STATUS, ATTEMPT_CONFIRM_DELAY, LOCK) and mapped by `Utility\FieldOverride` / `Utility\FieldOverrides`.

Config schema for these settings: `field.field_settings.attempt_mgmt_attempt_management` and `field.value.attempt_mgmt_attempt_settings` in `config/schema/attempt_mgmt.schema.yml`.

## Widget — `src/Plugin/Field/FieldWidget/AttemptMgmtSettingsDefaultWidget.php`
`@FieldWidget(id = "attempt_mgmt_settings_default")`. Builds a `details` element with: `enabled` checkbox; a **disabled** `attempt_type` textfield (the type is chosen in field settings, not per-entity); `force_new_attempt`; `limit` (number 0-100); `grading_method` select (Best/Last attempt); `display_status`; `attempt_confirm_delay` (number 0-60000); `lock`. Most rows are `#states`-hidden until `enabled` is checked. Hidden field-overrides remove `#access`. `massageFormValues()` flattens the nested property values (keeping only keys known to `AttemptMgmtField::exists()`).

## Formatter — `src/Plugin/Field/FieldFormatter/AttemptMgmtSettingsDefaultFormatter.php`
`@FieldFormatter(id = "attempt_mgmt_settings_default")`. `viewElements()` returns an empty array — the field renders nothing on the host entity's view; the settings are metadata consumed by `AttemptFactory` and by driving modules (e.g. scorm_field), not display output.

## How the factory reads the field
`AttemptFactory::getAttemptField($entity)` / `getAttemptFieldByProperty($entity, $property)` locate the first field of type `attempt_mgmt_attempt_settings` on the host entity and return its value (or one property, e.g. `attempt_type`, `limit`, `force_new_attempt`). This is how attempt creation and limit checks discover a host's configuration. See [AttemptFactory API](../api/factory.md).
