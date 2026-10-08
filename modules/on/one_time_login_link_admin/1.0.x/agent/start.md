<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# One Time Login Link Admin (one_time_login_link_admin) — agent index

Adds two admin actions to the **People** list (`/admin/people`) that generate a one-time login
(password-reset) link for a chosen user — the browser equivalent of `drush user:login`. The
*generate* action displays the link to the operator via a status message; the *email* action mails
it to the target user's address. The link itself is core's standard one-time-login URL
(`user_pass_reset_url()`), with the string `/login` appended so the recipient is logged straight in
instead of landing on an intermediate confirmation screen. Both actions are exposed as user entity
operations (`hook_entity_operation`) and are only shown for **active** accounts to users holding
`administer users`.

- Depends on: nothing beyond Drupal core. No composer requirements, no libraries.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Custom`.
- No settings page / `configure` route. No config schema, no config/install.
- Defines **no permission of its own** — reuses core `administer users`. No services, no plugin
  types, no drush commands, no fields, no templates.
- Reads (never writes) two core config values: `user.settings:password_reset_timeout` (link
  lifetime) and `system.site:name` / `system.site:mail` (email subject/from).

## What you'd do → where

- **Invoke / link to the actions; understand the routes, controller methods, the People-list entry
  point and the email that gets sent** → [api/routes.md](api/routes.md)
- **Who may run it, on which users, and how the link's validity/single-use is enforced** →
  [permissions/access.md](permissions/access.md)

## Key facts (real machine names)

- Routes (both `_permission: 'administer users'` **and** `_csrf_token: 'TRUE'`, `_admin_route`):
  - `one_time_login_link_admin.generate_login_link` — `/admin/people/generate-one-time-login-link-admin/{user}`
  - `one_time_login_link_admin.email_login_link` — `/admin/people/email-one-time-login-link-admin/{user}`
- Controller: `Drupal\one_time_login_link_admin\Controller\OneTimeLoginLinkController`
  (`generateLoginLink(AccountInterface $user)`, `emailLoginLink(AccountInterface $user)`); injects
  `date.formatter` and `plugin.manager.mail`.
- Hooks: `hook_help` (`help.page.one_time_login_link_admin`), `hook_entity_operation` (adds op keys
  `one_time_login_link_admin_generate_login_link` / `…_email_login_link` to the user list),
  `hook_mail` (message key `one_time_login_link`).
- `{user}` is an `entity:user` route parameter; the mail is sent with
  `mailManager->mail('one_time_login_link_admin', 'one_time_login_link', $to, $langcode, $params)`.
