# LocalGov Login Redirect — manual setup guide

**LocalGov Login Redirect** (`localgov_login_redirect`) is a small, single-purpose
module that sends users somewhere useful **after they log in**, instead of dropping
them on their own user profile page (`/user/{uid}`) — which is where Drupal sends
people by default and is almost never where anyone actually wants to be. Editors
usually want the content list, staff want a dashboard, members want the members' area.

Rather than reaching for a `?destination=` parameter, a form alter, or a bespoke event
subscriber, this module makes the post-login destination a piece of **configuration**:
you set it once on a settings form, and because it is configuration it exports with
`drush cex` and can be changed without a code deployment.

It depends only on core's User module and runs on Drupal 10.2+ and 11. It comes from
the **LocalGov Drupal** distribution, so it is maintained for UK council sites, but
nothing about it is council-specific — it works on any site.

> **Choosing between modules:** this is a well-populated niche. The
> [Login Destination](https://www.drupal.org/project/login_destination) module (a
> Varbase dependency) covers similar ground with per-role and per-condition rules.
> Pick LocalGov Login Redirect for simplicity; pick Login Destination when the
> destination must vary by role, path, or previous page. Do not install both.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — set the post-login destination on the
   settings form.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → LocalGov Login
Redirect** (`/admin/config/system/localgov_login_redirect`). Reaching it requires the
**Administer site configuration** permission (an administrator by default).
