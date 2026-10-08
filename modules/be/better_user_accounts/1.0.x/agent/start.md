<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better User Accounts (better_user_accounts) — agent index

Small UX module (package "User interface") that improves Drupal's stock user account pages. Two
features, both config-driven:

1. Custom labels for the user account **View** (`entity.user.canonical`) and **Edit**
   (`entity.user.edit_form`) local-task tabs — set via `hook_menu_local_tasks_alter()` in
   `better_user_accounts.module`.
2. Optionally hides the account edit form's **Current password** retype field (`current_pass`)
   when it isn't needed, via a client-side `#states` condition added in
   `hook_form_user_form_alter()`.

## Dependencies
- Core `user` only. No composer requirements, no libraries, no submodules.
- Core `^10.3 || ^11`. Version 1.0.0-alpha2.

## What it provides
- Config object: `better_user_accounts.settings` (keys: `account_view_label`, `account_edit_label`,
  `hide_unused_current_pass`) with schema in `config/schema/better_user_accounts.schema.yml` and
  defaults in `config/install/better_user_accounts.settings.yml`.
- Settings form: `\Drupal\better_user_accounts\Form\BetterUserAccountsSettings` (a `ConfigFormBase`).
- Route: `better_user_accounts.settings` → `/admin/config/people/better-user-accounts`.
- Permission: `administer better user accounts configuration`.
- Menu link + local task + config-translation registration for the settings page.
- No entities, services, plugins, hooks beyond the two alters above, or Drush commands.

## Routes & access
- Only route is the admin settings form, gated by `_permission: 'administer better user accounts
  configuration'`. The module adds no routes on user entities and does not alter user access.

## Solution docs
- [Configuration & behavior](config/settings.md)
