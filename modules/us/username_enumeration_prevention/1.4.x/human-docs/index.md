# Username Enumeration Prevention — manual setup guide

**Username Enumeration Prevention** (`username_enumeration_prevention`) is a small
security‑hardening module that stops attackers from probing your site to discover
which usernames and email addresses exist. Out of the box, Drupal leaks account
existence in two ways, and this module closes both — with **no configuration at
all**. Enable it and it works.

The two vectors it fixes:

- **The forgot‑password form** (`/user/password`) normally shows a distinct error
  when a name or email isn't registered. This module makes the response generic, so
  submitting a valid or invalid identifier looks identical. It also logs a "Blocked
  user attempting to reset password" notice for auditing.
- **User profile pages** like `/user/123` normally return **403 (Access denied)**
  when an account exists but the visitor lacks permission — versus **404 (Not
  found)** for a non‑existent id — which tells an attacker the difference. This
  module turns those 403s into 404s across the whole set of user routes (view,
  edit, cancel, and related), so the responses are uniform.

There is nothing to configure and no admin UI. The module depends only on core
**User** and supports Drupal 9.5, 10, and 11. One thing to watch: Drupal's core
**access user profiles** permission. Any role granted it — especially the
anonymous role — can view user pages directly, which re‑exposes usernames and
defeats the 403→404 protection. The module adds a warning on the site status report
when anonymous users hold that permission.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no configuration UI — there is nothing to set up beyond enabling
it. See *How to use it* below.

## Where it lives in the admin menu

Username Enumeration Prevention adds **no admin menu item and no settings form**.
Once enabled, its two protections apply automatically site‑wide. Its only visible
touchpoint is a **status‑report warning** (at *Reports → Status report*) if
anonymous users have the *access user profiles* permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The protections
   are active immediately — nothing else to do.
2. Confirm the **anonymous** role does **not** have the core **access user
   profiles** permission (at *People → Permissions*). If it does, `/user/123` stays
   viewable to anyone and usernames leak, defeating the module. The status report
   will warn you when this is the case.
3. For defense in depth, pair it with rate limiting or CAPTCHA on login and a
   strong password policy.
