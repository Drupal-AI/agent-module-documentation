<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config, route & permission

## Install / enable

`composer require drupal/error_squelch` then `drush en error_squelch`. No dependencies.
Does nothing until at least one pattern is configured.

## Route, permission, menu

- Route `error_squelch.settings` (`error_squelch.routing.yml`):
  path `/admin/config/development/error-squelch`, `_form: ErrorSquelchSettingsForm`,
  `_permission: 'administer error squelch'`, `_admin_route: TRUE`.
- Permission `administer error squelch` (`error_squelch.permissions.yml`):
  `restrict access: true` — grant only to trusted roles.
- Menu link `error_squelch.settings` (`error_squelch.links.menu.yml`) under
  `system.admin_config_development` (*Configuration → Development*), weight 100.
- `configure: error_squelch.settings` in `error_squelch.info.yml` (Configure link on Extend).

## Config object `error_squelch.settings`

Defaults (`config/install/error_squelch.settings.yml`), schema
(`config/schema/error_squelch.schema.yml`):

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `squelch_patterns` | sequence of string | `[]` | Patterns to match message text against. |
| `use_regex` | boolean | `false` | Treat each pattern as a full PHP regex (with delimiters) instead of a case-insensitive substring. |
| `log_suppressed` | boolean | `false` | Log each suppressed message to the `error_squelch` channel. |
| `test_mode` | boolean | `false` | Inject a known status message (see api doc) to verify the filter. |

## Form `ErrorSquelchSettingsForm`

`src/Form/ErrorSquelchSettingsForm.php`, extends `ConfigFormBase`, form id
`error_squelch_settings`, editable config `error_squelch.settings`. Fields:

- `squelch_patterns` — textarea, one pattern per line. Uses a `ConfigTarget` with
  `fromConfig` = `implode("\n", …)` and `toConfig` = trim/filter each line into an array
  (blank lines dropped). So config stores a clean array of non-empty patterns.
- `use_regex`, `log_suppressed`, `test_mode` — checkboxes, each bound with a
  `#config_target` string (`error_squelch.settings:<key>`).

The form description warns that suppression does not fix the underlying cause. All values
are set only by an operator holding the restricted permission.

## Config export example

```yaml
# error_squelch.settings.yml
squelch_patterns:
  - "Stripe API is running in test mode"
  - "Could not load metadata from 'public://menu_icons/"
use_regex: false
log_suppressed: true
test_mode: false
```
