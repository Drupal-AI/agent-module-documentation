<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domino is an opinionated, developer-focused module that bundles configuration and lifecycle helpers so a Drupal project behaves consistently and safely across development, staging and production environments.

---

Domino is driven by a single `application_mode` setting (`development`, `staging` or `production`, default `production`) set in each environment's `settings.php`; it has no admin UI. From that mode it applies a set of features on every cache flush, cron run and (as a fallback) page request through event subscribers: it generates one **test user per role** (username `ROLE.test`) with a shared configured password, activating them off-production and blocking them on production; it **hardens the super-admin user (uid 1)** by blocking it and randomising its username (`superadmin.blocked.*`) and password; it **guarantees the anonymous (uid 0) and super-admin (uid 1) rows exist** and reassigns orphaned entity owners to anonymous, so a truncated/obfuscated user table doesn't break the site. It ships three **Config Split** definitions (Development, Staging, Production) and two standard **user roles** (Developer, Manager) as a naming convention. For mail it hooks `hook_mail_alter`: on non-production it can **display emails to test users as Drupal messages** instead of sending them, optionally reroute all mail to a **MailSlurp** inbox for delivery testing, and it enforces that **Reroute Email** is enabled off-production (blocking outgoing mail otherwise) while warning if Reroute Email is enabled on production. A configurable **status message** can be shown on every non-production page. The `domino_sms` submodule adds the SMS equivalent of "emails as messages" via the SMS Framework. Configuration lives in the `domino.settings` config object; there is no config schema, so all keys are expected to be set from `settings.php` per environment.

---

- Give every new project the same environment-aware baseline (roles, test users, mail safety) from day one.
- Set `application_mode` per environment in `settings.php` so mail, test users and messages behave correctly.
- Auto-create one test user per role (`administrator.test`, `editor.test`, ...) to exercise each role's permissions.
- Add extra test users beyond one-per-role via `test_users_additional_users`.
- Give test users friendlier names with `test_users_usernames_map` (e.g. `administrator` -> `admin.test`).
- Keep a chosen set of test users active on production with `test_users_active_on_production` plus a separate production password.
- Force all test-user passwords back to the configured value if someone changes them (self-healing on cron/request).
- Automatically block and rename the super-admin user (uid 1) to reduce attack surface.
- Guarantee anonymous (uid 0) and super-admin (uid 1) accounts exist after a user-table truncation.
- Reassign entities whose owner was truncated to the anonymous user, avoiding fatal errors in dev.
- Ship Development/Staging/Production Config Split definitions ready to point at split folders.
- Standardise on Developer and Manager roles across teams and projects.
- Display outgoing emails to test users as Drupal messages so automated/manual tests can read them.
- Click registration / password-reset links in those on-screen emails during QA.
- Route all outgoing mail to a MailSlurp inbox (per-cookie or default) for acceptance-test email delivery checks.
- Enforce that Reroute Email is enabled on non-production, blocking mail until it is configured.
- Get logged warnings if Reroute Email is (mis)enabled on production or missing off-production.
- Show a persistent status/warning banner on every non-production page (e.g. "This is a development environment").
- Enable the `domino_sms` submodule to display outgoing SMS as Drupal messages instead of sending them.
- Drive all behaviour from `settings.php`, keeping environment specifics out of exported configuration.
- Use cron as the primary trigger with a request-time fallback so test-user/super-admin state stays correct even if cron stalls.
