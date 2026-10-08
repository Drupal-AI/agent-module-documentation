# Protected Pages Extra — manual setup guide

**Protected Pages Extra** (`protected_pages_extra`) lets site administrators
password‑protect any page on the site by its URL path. A visitor who doesn't know the
password sees a password‑entry screen instead of the page content. It is a modern
reimplementation of the popular Protected Pages module, rebuilt on current Drupal APIs
(config entities, HTTP middleware, Symfony session management).

You manage protected pages from a simple admin interface: add an entry, list one or
more paths to protect, and set a password. Paths can be exact or use **wildcards**, and
a standout feature is that a single entry can cover **multiple paths under one
password** — no need to create separate entries for related pages that share a
password. Authentication is **session‑aware**: once a visitor enters the correct
password for one page, they aren't prompted again during the same session for any other
page protected by the same password. Other options include a global password, a
configurable session‑expiry time, customizable text on the "Enter Password" screen,
password protection for private files, and emailing users to tell them about a
protected page.

Protection here is an **admin‑configured gate that works independently of Drupal's
role/permission access** — it is best thought of as soft‑gating specific pages behind a
password. Access is governed by a set of granular permissions, of which
`bypass protected page access check` is the most sensitive: grant it, and the bypass
and administration permissions, only to trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add protected pages, set passwords, and
   assign the permissions.

## Where it lives in the admin menu

The admin interface is at **Configuration → Content authoring → Protected Pages Extra**
(`/admin/config/content/protected-pages-extra`), where you add and manage protected
page entries. Permissions are assigned on **People → Permissions**. See
[Configuration](configuration/index.md).
