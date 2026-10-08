<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & behavior

## Install / enable
`drush en better_user_accounts -y`. Requires only core `user`. Installs the config object
`better_user_accounts.settings` from `config/install/` with defaults:

```
account_view_label: 'User account'
account_edit_label: 'Account settings'
hide_unused_current_pass: FALSE
```

## Settings form
- Route `better_user_accounts.settings` → path `/admin/config/people/better-user-accounts`.
- Form class `\Drupal\better_user_accounts\Form\BetterUserAccountsSettings` (extends
  `ConfigFormBase`, form id `better_user_accounts_settings`).
- Access requirement: permission `administer better user accounts configuration` (defined in
  `better_user_accounts.permissions.yml`).
- Menu link under People (`better_user_accounts.links.menu.yml`, parent `user.admin_index`); a
  local task tab (`*.links.task.yml`); config-translation registered
  (`better_user_accounts.config_translation.yml`) so labels are translatable.

Form fields (in `buildForm()`), all writing to `better_user_accounts.settings` in `submitForm()`:
- `account_view_label` (textfield) → config `account_view_label`. Custom title for the account
  View tab. Empty = keep Drupal's default.
- `account_edit_label` (textfield) → config `account_edit_label`. Custom title for the account
  Edit tab.
- `hide_unused_current_pass` (checkbox) → config `hide_unused_current_pass`.

`getEditableConfigNames()` returns `['better_user_accounts.settings']`. Schema
(`config/schema/better_user_accounts.schema.yml`): the two labels are `type: label`, the flag is
`type: boolean`.

## Behavior 1 — tab labels (`hook_menu_local_tasks_alter`)
In `better_user_accounts.module`, `better_user_accounts_menu_local_tasks_alter()` reads the config
and, when present, overwrites:
- `$data['tabs'][0]['entity.user.canonical']['#link']['title']` ← `account_view_label`
- `$data['tabs'][0]['entity.user.edit_form']['#link']['title']` ← `account_edit_label`

This only changes the displayed tab title on user pages; it does not add, remove, or re-gate any
tab or route.

## Behavior 2 — hide current-password field (`hook_form_user_form_alter`)
`better_user_accounts_form_user_form_alter()` runs on the user account form (`user_form`). When
`hide_unused_current_pass` is TRUE and `$form['account']['current_pass']` exists with a non-empty
default email, it adds a client-side `#states` `invisible` condition so the current-password retype
field is hidden unless the email (`edit-mail`) has changed or a new password (`edit-pass-pass1`)
was typed. This is a purely visual/`#states` change — it does not remove core's server-side
current-password validation in `\Drupal\user\AccountForm`.

## Operating notes
- All features are off/neutral by default (`hide_unused_current_pass` is FALSE; default labels
  mirror stock wording). Change them only via the settings form or config override.
- No cache clear normally needed for label changes beyond the standard render/menu caches Drupal
  invalidates on config save.
