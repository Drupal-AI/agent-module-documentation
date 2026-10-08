# Front Page — manual setup guide

**Front Page** (project `front`, module machine name `front_page`) lets you give
different user roles different front pages. Instead of everyone landing on the same
home page, you can send anonymous visitors to a marketing landing page, members to a
dashboard, and editors to a work queue — all from one configuration screen, without
writing custom front‑page code.

For each role you choose how its front page is produced. The classic methods are:

- **Redirect** — send the user to a local or remote URL.
- **Themed** — display some static text placed into the content area of a standard,
  fully themed Drupal page.
- **Full** — output static content exactly as entered, bypassing Drupal's theming
  system.

Roles are evaluated in an order you control (with drag‑and‑drop), so when a user has
several roles you decide which one's front page wins. A **skip** option lets a role
fall through to the next applicable role — or, ultimately, to Drupal's own core front
page — when you don't want to specify a page for it.

A reassuring note on the Redirect method: the redirect target is set by an
administrator in configuration, not derived from the incoming request, so it is not
an open‑redirect surface. As with any redirect, though, point it only at destinations
you intend.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — setting a front page per role, choosing
   a method, and ordering the roles.

## Where it lives in the admin menu

Front Page's settings live under **Administration → Configuration → System → Front
page** (`/admin/config/system/front-page`), gated by the **Administer front page**
permission. See [Configuration](configuration/index.md).
