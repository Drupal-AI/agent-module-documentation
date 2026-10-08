# Login Path Helper — manual setup guide

**Login Path Helper** (`login_path_helper`) provides a single block — a login link
whose target carries the **current page's path** as a `destination` parameter. The
point is to send visitors back to the page they were reading *after* they log in,
instead of Drupal's default of dropping them on their profile page. It was built
especially for **SSO/SAML** setups, where the actual login happens on an external
endpoint and you want a `destination=` appended so the identity‑provider round‑trip
returns the user to the right place.

The block builds its link from two configurable values — the visible **link text**
(default "Site Login") and a **URL prefix** (default `user/login?destination=`;
for SAML SSO the recommended prefix is `saml_login?destination=`) — combined with
the current host and the current request path. Because it rebuilds the link on
every request, the destination always reflects the page the visitor is actually on.

The module has no dependencies and defines no permissions of its own. You configure
the two values on a small settings form, then place the block in a theme region via
the normal Block layout UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the link text and URL prefix, then
   place and restrict the block.

## Where it lives in the admin menu

The settings form is at **`/admin/config/login_path_helper`** (gated by the core
**Administer site configuration** permission). The block itself is placed from
**Structure → Block layout** (`/admin/structure/block`).
