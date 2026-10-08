<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: Entity Usage Integrity settings

One settings form, no per-bundle configuration. Everything is site-wide.

## Route / access
- Route: `entity_usage_integrity.settings`
- Path: `/admin/config/entity-usage/integrity` (shown as an **Integrity** tab under Entity Usage's
  settings page; local task base_route `entity_usage.settings.form`, weight 11)
- Permission: `administer entity usage` (defined by the `entity_usage` module, not this one)
- Form class: `Drupal\entity_usage_integrity\Form\IntegritySettingsForm` (getFormId
  `entity_update_integrity_form`)

## Config object: `entity_usage_integrity.settings`
Install defaults are in `config/install/entity_usage_integrity.settings.yml`; schema in
`config/schema/entity_usage_integrity.schema.yml`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `mode` | string | `warning` | `warning` = never blocks, only shows messages. `block` = prevents the offending save and disables the delete button. |
| `ignore_unpublished_entities` | bool | `true` | When true, relationships whose *referenced target* is a draft/unpublished entity are skipped (status `ignore`) rather than judged. |

Form UI: `mode` is a radios element (`Block` / `Warning`); `ignore_unpublished_entities` is a checkbox
labelled "Ignore unpublished entities." `IntegritySettingsForm::BLOCK_MODE = 'block'`,
`WARNING_MODE = 'warning'`.

## Effect of `mode` per situation
- **Open edit form** (`ViewedEditForm`): warning only, *in both modes* (informational — lists invalid
  inbound/outbound refs so the editor can fix them).
- **Submit edit form** (`SubmittedEditForm`): active **only in block mode**; sets form errors to stop
  the save. In warning mode the submit-time check does not run (warnings come from form open instead).
- **Delete form** (`ViewedDeleteForm`): block mode → adds an error and sets
  `$form['actions']['submit']['#disabled'] = TRUE`; warning mode → adds a warning, delete still allowed.
- **Moderation state change** (`ModerationStateChangeConfirmDialog`): AJAX confirm dialog runs **only in
  warning mode**; `SubmittedModerationStateForm` enforces on submit in block mode.

## Reading the settings from code
Config-backed helpers on `IntegrityValidationTrait`:
`getIntegrityValidationMode()` → `mode`; `getIntegrityValidationSkipUnpublishedEntities()` →
`ignore_unpublished_entities`.

## drush
Read/set like any config object:
- `drush cget entity_usage_integrity.settings`
- `drush cset entity_usage_integrity.settings mode block -y`
- `drush cset entity_usage_integrity.settings ignore_unpublished_entities 0 -y`

NOTE: on a site where the install-time config was never imported, `drush cget` reports "does not exist";
the form then reads null and behaves as if no mode is set. Re-import config or save the form once to
create it.
