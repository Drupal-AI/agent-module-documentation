<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Credential Mask — the sensitivity list and settings form

## Install / enable

`drush en credential_mask -y`. No module dependencies. For the config-sync integration to run you need
**Drush 10+** (`composer.json` conflicts with `drush/drush <10` and `drupal/config_filter <2`). On install,
`config/install/credential_mask.sensitive_config.yml` is empty (only a `@TODO` comment) — nothing is masked
until you add entries.

## The config object

- Name: **`credential_mask.sensitive_config`** (constant `SensitiveConfigManager::SETTINGS_KEY`).
- Shape: each property key is a **config name** and its value is an **array of config keys** to mask inside
  that config. There is **no config schema** shipped (`provides_config_schema = false`).
- Encoding quirk: `.` has array-path meaning in Drupal config, so in storage a target config **name**'s dots
  are stored as `:` (see `addSensitiveConfig()` / `deleteSensitiveConfig()`), and the manager converts them
  back to `.` when it loads the list in its constructor. You normally never touch this directly — use the
  form or Drush.
- The module **excludes itself**: the constructor `unset()`s `credential_mask.sensitive_config` from the
  in-memory list, and the Drush `add` command throws if you try to mark it sensitive.

Each entry names one config value: `config-name` + `config-key`. The `config-key` may be **dotted** to reach
an array subkey (e.g. `configuration.secret_key`). The `config-name` may contain a `*` **wildcard** (matched
against config names only, not keys).

## Settings form

- Class `Form\SettingsForm extends ConfigFormBase`, form id `credential_mask_settings`.
- Route `credential_mask.settings` → path **`/admin/config/development/configuration/credential_mask`**,
  requirement **`_permission: 'import configuration'`** (a core permission; the module ships no permissions of
  its own). Menu link + local task (`*.links.menu.yml`, `*.links.task.yml`) placed under `config.sync`
  (*Configuration → Development → Configuration synchronization*).
- The single textarea holds one entry per line in the format **`config-name|config-key`**. Example lines
  (from the form's own help text):
  - `commerce_payment.commerce_payment_gateway.card_payment_trade_business|configuration.publishable_key`
  - `commerce_payment.commerce_payment_gateway.card_payment_trade_business|configuration.secret_key`
  - `webform.webform.*|handlers.email.settings`
- Validation (`isInvalid()`): a row is rejected if it contains a **space** or does not contain **exactly one**
  `|`. Invalid rows produce an error message and are skipped; valid rows are diffed against the current list
  and applied via `addSensitiveConfig()` / `deleteSensitiveConfig()`. Whitespace is trimmed; duplicates and
  blank lines are dropped.
- The form edits **only the list of which keys are sensitive** — it never displays the secret values
  themselves.

## Operating notes

- Adding a key does not change active config; it only affects what the next **export** writes and what an
  **import** restores. Run `drush config:export` to see the masking take effect.
- Use the Drush commands (see [../api/sensitive-config-manager.md](../api/sensitive-config-manager.md)) for
  scripted/CI management and to audit which listed keys are actually present, exported, and masked.
