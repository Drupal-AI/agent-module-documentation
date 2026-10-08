# Rebuild Cache Access — manual setup guide

**Rebuild Cache Access** (`rebuild_cache_access`) adds a one-click **Rebuild
Cache** button to the Drupal admin toolbar (and a matching block for the new
Navigation module) that any role can be granted. It lets non-developers flush all
of Drupal's caches without touching the command line or the performance settings
page.

Out of the box, only users who can reach `/admin/config/development/performance`
— typically an administrator or user 1 — can clear caches through the UI, and
everyone else has to fall back on `drush cr`. This module defines a single
permission, **Rebuild Cache**, and shows a toolbar tab that triggers a full cache
rebuild for any role that holds it. Clicking it runs Drupal's
`drupal_flush_all_caches()` through a CSRF-protected route and returns you to the
page you were on with a status message.

There is nothing to configure — you enable the module, grant the permission on the
People → Permissions page, and the button appears. It is a lightweight
convenience for editorial and support teams who frequently need a cache clear but
should not be handed broad administrative access. A small CSS library styles the
toolbar tab with an icon, and a bundled block plugin makes the same button work in
Drupal's Navigation module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module has no settings form. Once enabled, the **Rebuild Cache** button
appears in the admin toolbar for anyone whose role holds the permission. You grant
that permission at **People → Permissions**
(`/admin/people/permissions`) — look for the **Rebuild Cache** row.

## How to use it

1. Enable the module and grant the **Rebuild Cache** permission to the roles that
   should have it (for example your Editor or Support role).
2. Those users will see a **Rebuild Cache** tab in the admin toolbar. Clicking it
   flushes every Drupal cache and drops them back on the page they were viewing
   with a confirmation message.
3. If you use core's **Navigation** module, place the module's Rebuild Cache block
   so the same one-click action is available there too.

Because the action runs through a CSRF-protected route, the button cannot be
triggered by a forged link — only a real click by a permitted user rebuilds the
cache.
