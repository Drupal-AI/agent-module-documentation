<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes, and bulk user check

## Install / enable

`drush en email_validate`. No dependencies, no install config. All five constraints start disabled;
nothing changes on the `user` mail field until you enable at least one on the settings form.

## Settings form — `EmailValidateForm`

`src/Form/EmailValidateForm.php` (`extends ConfigFormBase`, form id `email_validate_settings`),
route `email_validate.settings` at `/admin/config/people/email_validate`, permission
`administer site configuration`. Menu link under *Configuration → People → User email validation*;
local task "Settings".

- `buildForm()` discovers constraints with the private `getConstraintsAll()`, which scans
  `src/Plugin/Validation/Constraint/*Constraint.php` via `file_system->scanDirectory()` (non-recursive,
  mask `/.*Constraint.php$/`) — note this also matches the base `EmailConstraintBase.php`. For each it
  builds a `details` element with an `enable` checkbox plus the constraint's own `getSettingsForm()`
  fields (block-list textarea; API key + API URL).
- `submitForm()` saves each constraint's subtree into `email_validate.settings` under the constraint
  key, then `resetCache()` calls `kernel->invalidateContainer()` + `rebuildContainer()` and
  `plugin.cache_clearer->clearCachedDefinitions()` so the base-field-info alter re-runs with the new
  enabled set. Editable config: `email_validate.settings`.

## Config object + schema — `email_validate.settings`

Schema `config/schema/email_validate.settings.yml`. One config object keyed by constraint class
short-name; documented default values:

- `GoogleEmailConstraint.enable` (0)
- `YandexEmailConstraint.enable` (0)
- `BlockEmailDomainConstraint.enable` (0), `BlockEmailDomainConstraint.block_domains` ('') —
  newline-separated (`\r\n`) list of domains.
- `TemporaryEmailConstraint.enable` (0), `.api_key` (''), `.api_url`
  (`https://block-temporary-email.com/check/email/{email}`). The remote lookup only fires when both
  api_key and api_url are non-empty.
- `DomainMxRecordConstraint.enable` (0)

There is no `config/install/`; these defaults come from the schema / first form save.

## Bulk existing-user check — `UserValidationForm`

`src/Form/UserValidationForm.php` (`extends FormBase`, form id `email_validate_users_form`), route
`email_validate.users_validation` at `/admin/config/people/email_validate/users_validation`,
permission `administer site configuration`; local task "Checking the site users".

- `buildForm()` shows the total user count (`getAggregateQuery()`, `uid > 1`, `accessCheck(FALSE)`)
  and a submit button.
- `submitForm()` loads all uids `> 1` and runs a `BatchBuilder` job; `processItems()` chunks 50 per
  pass, `processItem()` loads each user and calls `$account->get('mail')->validate()`, collecting
  violation messages keyed by email.
- `finishBatch()` reports total checked and, for failures, adds a warning per address
  (`email | messages`). Read-only audit — it does not modify or block any account, only reports which
  stored emails fail the currently enabled constraints.
