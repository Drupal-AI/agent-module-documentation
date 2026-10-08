<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAS User Ban (cas_user_ban) — agent index

Prevents auto-creation of Drupal accounts for banned **CAS** usernames (a deny-list on top of CAS SSO).
Enforced by cancelling CAS automatic registration for banned names. It blocks account (re-)creation, **not**
login of an already-existing account. Core `^10 || ^11`; version 1.0.0.

## Dependencies
- `cas` (drupal/cas `^3.0@beta`) — required.
- Submodule `cas_user_ban_vbo` (optional) adds a Views Bulk Operations user-cancel action; requires
  `views_bulk_operations`. Documented at `modules/cas_user_ban_vbo/1.0.x/`.

## What it provides
- **Service** `Drupal\cas_user_ban\CasUserBanManagerInterface` (class `CasUserBanManager`): `add()`,
  `remove()`, `isBanned()` against the `cas_user_ban` DB table (defined in `cas_user_ban.install`).
- **Event subscriber** `CasPreRegisterSubscriber::onPreRegister` — subscribes to `cas`'s
  `CasPreRegisterEvent`; calls `cancelAutomaticRegistration()` for banned usernames.
- **Routes** (all `_permission: 'administer users'`): `cas_user_ban.banned_users_list`
  (`/admin/people/cas/banned-users-list`, controller `BannedUsersListController`),
  `cas_user_ban.ban_users` (`/admin/people/cas/ban_users`, `BanUsersForm`),
  `cas_user_ban.remove_user_ban` (`/admin/people/cas/remove-user-ban/{cas_username}`, `RemoveBanForm`).
- **Form alters** (class hooks in `Hook/`): adds a ban checkbox to core `user_cancel_form` and
  `user_multiple_cancel_confirm`; adds ban validation to CAS's `bulk_add_cas_users` form.
- **Trait** `Traits\UserCancelFormsTrait` — reusable `addBanField()` / `banSubmit()` for custom cancel forms.
- **Event** `Event\FilterUserCancelMethodEvent` (name `cas_user_ban.filter_user_cancel_method`) — alter allowed
  cancel methods that show the ban option.
- No config schema, no permissions of its own, no Drush commands.

## Solution docs
- Ban enforcement & the manager service: [agent/api/manager.md](api/manager.md)
- Routes, admin UI, and form integration: [agent/config/administration.md](config/administration.md)
- Extending via the trait & event: [agent/api/extending.md](api/extending.md)
- VBO submodule: [../modules/cas_user_ban_vbo/1.0.x/agent/start.md](../modules/cas_user_ban_vbo/1.0.x/agent/start.md)
