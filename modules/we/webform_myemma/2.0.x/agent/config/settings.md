<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MyEmma account settings

Configuration page for the site-wide MyEmma credentials the `myemma` handler uses.

## Install / enable

1. `composer require drupal/webform_myemma` — pulls in `judicialcouncil/emma:^4.0` and
   `drupal/webform:^6.2 || ^6.3`.
2. `drush en webform_myemma -y`.
3. `hook_requirements()` (`webform_myemma.install`, install phase only) errors if the Emma
   library class is missing. Note: the check tests `class_exists('MarkRoland\Emma\Client')`
   and its message says `markroland/emma:^3.0`, but composer.json actually requires
   `judicialcouncil/emma:^4.0` (which provides `JudicialCouncil\Emma\JccClient`, the class the
   handler instantiates). The check therefore refers to a different library than the one
   shipped — verify the Emma client is present rather than trusting the message text.

## Route & permission

- Route `webform_myemma.settings` → `/admin/config/services/webform_myemma`
  (`_form: \Drupal\webform_myemma\Form\SettingsForm`, title "MyEmma for webform settings").
- Requirement: `_permission: 'administer webform myemma'`.
- Menu link `webform_myemma.admin` under `system.admin_config_services`, weight 100.

## Config object: `webform_myemma.settings`

Written by `SettingsForm::submitForm()` via `configFactory->getEditable(...)`. Keys:

- `account_id` (string) — default account MyEmma Account ID (required on the form).
- `public_key` (string) — default account public key (required).
- `private_key` (string) — default account private key (required).
- `accounts` (mapping keyed by machine name) — additional named accounts, each a mapping of
  `account_name`, `account_id`, `public_key`, `private_key`.

Schema: `src/config/schema/webform_myemma.schema.yml` defines
`webform_myemma.settings.accounts` (a sequence of `webform_myemma.settings.accounts.*`
mappings with `account_name`/`account_id`/`public_key`/`private_key` strings). The default
account's flat `account_id`/`public_key`/`private_key` keys are stored but not covered by an
explicit top-level schema entry.

## Form behaviour (`SettingsForm.php`)

- `getEditableConfigNames()` = `['webform_myemma.settings']`; `getFormId()` =
  `webform_myemma_settings`.
- "Default Account" fieldset: three required textfields (`account_id`, `public_key`,
  `private_key`).
- Existing additional accounts render as rows of textfields (`account_name_<key>` disabled;
  `account_id_<key>`, `public_key_<key>`, `private_key_<key>` editable).
- An "add" row lets you define one more account: `account_name_add` is a `machine_name`
  element whose `exists` callback is `accountNameExists()` (checks the `accounts` config).
- `preRenderForm()` (registered via `#pre_render`, whitelisted through
  `TrustedCallbackInterface::trustedCallbacks()`) moves each account's four fields into the
  `additional_accounts` table for display.
- `submitForm()` saves the default account keys, then rebuilds the `accounts` list, storing
  only rows where name, id, public key and private key are all present and the name is unique.
- Values are entered and re-displayed as plain textfields (this is an admin-only page gated by
  `administer webform myemma`).

## Operate

- Account and API keys are taken from your MyEmma account profile.
- Add additional accounts here so they can be selected per handler instance on a webform.
- To fully remove an additional account, clear its row values (empty rows are dropped on save).
