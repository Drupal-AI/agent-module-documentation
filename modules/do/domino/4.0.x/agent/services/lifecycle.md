<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domino services, hooks & subscribers

Domino has no routes; its work is done by services triggered from `hook_cron`,
`hook_cache_flush`, `hook_mail_alter`, `hook_entity_load` (all in `domino.module`) and by three
`event_subscriber`-tagged classes that act as a request-time fallback. All services are wired in
`domino.services.yml`.

## Trigger model

- **`domino_cache_flush()`** — setup pass: `AnonymousUser::ensureAnonymousUserExistence()`,
  `SuperAdminUser::ensureSuperAdminUserExistence()` + `ensureSuperAdminUserIsSecure()`,
  `TestUsers::ensureTestUsersExistence()` + `ensureTestUsersPassword()` +
  `ensureTestUsersActivationStatus()`.
- **`domino_cron()`** — `TestUsers::regularCheck('cron')` and `SuperAdminUser::regularCheck('cron')`;
  also logs errors if Reroute Email is enabled on production or disabled off-production.
- **Subscribers** (`KernelEvents::REQUEST`): `TestUsersSubscriber` and `SuperAdminUserSubscriber`
  call `regularCheck('fallback')`; `StatusMessageSubscriber` calls `displayStatusMessage()`.
  `regularCheck()` is throttled with `state` keys (`domino.last_test_users_check`,
  `domino.last_super_admin_user_check`) and a `*_check_frequency` config value; the `fallback`
  source uses a 3x multiplier so it only fires if cron has been failing.

## `TestUsers` (`src/TestUsers.php`, service `domino.test_users`)

- `getUsernamesWithRoles()` — one entry per non-anonymous role, username `ROLE.test`
  (`usernameSuffix = '.test'`), remapped via `test_users_usernames_map`, plus
  `test_users_additional_users`.
- `ensureTestUsersExistence()` — creates any missing test user (email
  `{prefix}{clean_name}{suffix}@{domain}`), assigns the role, sets a **random** password via
  `PasswordGeneratorInterface`, and **blocks** it initially. Aborts (logs error) if
  `test_users_email_domain` is empty.
- `ensureTestUsersPassword()` — sets each account's password to `test_users_password` (or, for
  production-active users, `test_users_password_for_production`) only if it differs
  (`PasswordInterface::check`). Aborts if `test_users_password` is empty.
- `ensureTestUsersActivationStatus()` — off-production: activate all test users. Production:
  block all except those in `test_users_active_on_production` (and even those are blocked if
  `test_users_password_for_production` is empty). Temporarily disables `user.settings`
  activation/blocked notifications so no mail is sent, then restores them.

## `SuperAdminUser` (`src/SuperAdminUser.php`, service `domino.super_admin_user`)

- `ensureSuperAdminUserExistence()` — creates a placeholder uid 1 (blocked) if it is missing.
- `ensureSuperAdminUserIsSecure()` — if uid 1 is active, or its name does not start with
  `superadmin.blocked.`, it renames it to `superadmin.blocked.<random8>`, sets a random 16-char
  password, and blocks it (again suppressing user notifications). Hardening of the all-powerful
  uid 1; administer the site through proper roles instead.
- `regularCheck()` — same throttled fallback pattern as `TestUsers`.

## `AnonymousUser` (`src/AnonymousUser.php`, service `domino.anonymous_user`)

- `ensureAnonymousUserExistence()` — creates uid 0 (empty name, blocked) if missing.
  Complements `hook_entity_load()`, which — **only in development/staging** — sets the owner of any
  `EntityOwnerInterface` entity with a missing owner to anonymous (uid 0), so truncated/obfuscated
  user tables don't fatal.

## `StatusMessage` (`src/StatusMessage.php`, service `domino.status_message`)

- `displayStatusMessage()` — off-production only; if `status_message_display` and
  `status_message_content` are set, adds `status_message_content` as a Drupal message of type
  `status_message_type` (`status`/`warning`/`error`, defaulting to `status`).

## Mail handling — `hook_mail_alter()` (`domino.module`)

Ordered last via `hook_module_implements_alter()`. Behaviour:

1. If `test_email_delivery` is on and both `mailslurp_key` and an inbox id
   (`mailslurp_inbox_id`, or the `domino_test_email_inbox` request cookie) are set, it looks up the
   inbox's address through the **MailSlurp** `InboxControllerApi` and rewrites `$message['to']`,
   disabling Reroute Email for that mail.
2. On `application_mode === production`, it returns early (no interference).
3. Off-production, if `display_emails_as_messages` is on and the recipient matches
   `{test_users_email_prefix}.+@{test_users_email_domain}`, the mail is **not sent**; its body
   (URLs linkified) is shown as a Drupal status message.
4. Finally, if `reroute_email.settings.enable` is FALSE, all mail is blocked (`$message['send'] =
   FALSE`) with a logged error — the "Reroute Email must be configured off-production" safety net.
