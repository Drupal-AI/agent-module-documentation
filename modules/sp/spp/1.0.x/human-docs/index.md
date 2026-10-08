# Single Page Protection — manual setup guide

**Single Page Protection** (machine name `single_page_protection`, Drupal.org
project `spp`) puts an individual password in front of selected internal Drupal
paths. When a visitor requests a protected page and has not yet entered its
password in their session, they are redirected to a password form; only after
entering the correct password does the page render. It is a genuine request‑level
gate — the check happens before the page is built, not merely a display trick.

The module is carefully built for the job. Passwords are hashed with Drupal's
password API (with automatic rehashing of any legacy stored passwords) and
compared in constant time using `hash_equals()`, so the check does not leak timing
information. It adds path‑and‑IP flood protection (five failed attempts per hour),
validates internal paths strictly to avoid open redirects, and automatically
revokes existing session unlocks when a protected page's password is changed.
There is an explicit bypass permission, and configuration is administrator‑only.

One important scope caveat to understand before you rely on it: protection is
**path‑based**. It gates the page paths you configure, but it is *not* entity or
data access control. If the underlying content must be genuinely confidential,
make sure it cannot be reached another way — the node's canonical path versus its
alias, JSON:API/REST, feeds, or other Views — and back the page gate with real
entity access. For casual page‑gating (a members' notice, a pre‑launch page) it
does exactly what you want.

It depends on core **System** and **Filter**, provides its own permissions, and
runs on Drupal 10.6 and Drupal 11.3+.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Package note:** the Composer package is `drupal/spp`, but the module's machine
> name (what you pass to `drush en`) is `single_page_protection`.

## Contents

1. [Installation](installation/index.md) — install and enable the module.
2. [Configuration](configuration/index.md) — choose which paths to protect and set
   their passwords.

## Where it lives in the admin menu

The module's settings form is the route `single_page_protection.admin_settings`,
reachable as an administrator from the module's configuration page. There you
define the protected paths and their passwords.
