# Quicker Login — manual setup guide

**Quicker Login** (`quicker_login`) is a **developer‑only** convenience module. Once
enabled it lets you log in as — or view any page as — any user account, without
knowing that user's password. It is meant to speed up local development and
automated testing, where quickly switching between an editor, a low‑privilege
account, or an administrator saves a lot of time.

There are two ways to use it. Visit `/user/ql/{user_name}` to establish a full
session as that user (a real login, not a preview). Or append `?ql={user_name}` to
any URL — for example `/admin/content?ql=editor` — to load that page as the chosen
user. While the module is enabled, a persistent warning message is shown on the site
reminding you that Quick Login is on and must not be used in production.

> **Do not enable this on a public or production site.** The login path is
> deliberately open (its route is declared with unrestricted access), so anyone who
> can reach the URL can become any user, **including an administrator**. This is by
> design for a throwaway development tool. Install it only in local, sandbox, or CI
> environments, and remove or disable it before deploying anywhere shared.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (in
   a development environment only).

This module has **no configuration page** — there are no settings. You use it
entirely through the two URL patterns described above.

## How to use it

- **Log in as a user:** visit `/user/ql/{user_name}`, e.g. `/user/ql/admin`. You are
  now signed in as that account.
- **View a page as a user:** append `?ql={user_name}` to any path, e.g.
  `/admin/content?ql=jane`. The module logs you in as that user and then loads the
  page (returning you to the requested URL).

When you are finished testing, uninstall the module so the impersonation paths no
longer exist.
