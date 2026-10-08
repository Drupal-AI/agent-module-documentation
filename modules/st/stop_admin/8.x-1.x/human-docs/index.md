# Stop administrator login — manual setup guide

**Stop administrator login** (`stop_admin`) is a lightweight hardening module that
stops **user 1** — Drupal's all-powerful superuser account — from logging in
through the site's login form, and can optionally extend the same block to every
user who holds an administrator role. The idea is that on a well-run site nobody
needs to *be* user 1 day to day: administrators should use their own named
accounts, which is better for password hygiene and for auditing who changed what.
It pairs naturally with single sign-on setups such as OpenID Connect.

When it blocks a login it reuses Drupal core's own generic *"Unrecognized username
or password"* message, so the rejection gives nothing away — it does not reveal
that user 1 exists or that a blocking module is installed. A **disabled** setting
turns the whole thing off again, and there is always a Drush escape hatch: you can
still log in as user 1 from the command line when you genuinely need to.

**Read this before enabling it — two important limitations.** First, the block is
implemented as a validation handler on the login *form*. It only sees form
submissions, and Drupal can authenticate through other paths that never touch a
form. Testing on a clean install confirmed that with the module enabled and
blocking, the `admin`/`admin` credentials were refused at the login form but still
succeeded through core's `POST /user/login?_format=json` endpoint (present whenever
the `serialization` module is on), and the one-time login link mailed from
`/user/password` still produced a working user-1 session. Basic-auth and SSO/JWT
logins likewise never reach the form. So this module is a speed bump, not a
guarantee. If your real requirement is that the account must be unusable, **block
the account itself** (`$user->block()`) — Drupal core enforces that at every entry
point.

Second, the module's permissions file is misspelled (`stop_admin.persmissions.yml`),
so the intended *administer stop_admin configuration* permission is never actually
registered. That fails safe — the settings page stays administrator-only — but it
also means you cannot delegate the setting to a non-administrator role even if you
wanted to.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with a safety checklist first).
2. [Configuration](configuration/index.md) — the two settings and how to recover
   if you lock yourself out.

## Where it lives in the admin menu

The settings form sits at **Configuration → People → Stop administrator login**
(`/admin/config/people/stop_admin`), reachable by administrators.
