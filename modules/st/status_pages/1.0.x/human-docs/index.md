# Status Pages — manual setup guide

**Status Pages** (`status_pages`) gives you ready-made **403 (access denied)** and
**404 (not found)** pages that live at fixed paths — `/page-403` and `/page-404` —
with configurable text and matching templates. Instead of pointing Drupal's error
pages at a specific node ID (which you then have to create and keep in sync across
dev, staging, and production), you point them at these stable paths that exist on
every environment automatically.

The problem it solves is the awkwardness of core's approach. Core lets you set a
node as the 403/404 page, but node IDs differ between environments, so keeping the
same error page everywhere means creating content and syncing IDs by hand. Status
Pages removes that: the pages are provided by the module itself, so the same
`/page-403` and `/page-404` paths work on all your environments with no content to
create or migrate.

The module provides the routes/paths for the two status pages, a settings form to
edit their text, and templates so they share a consistent style. It has no
dependencies beyond Drupal core and works on Drupal 9, 10, and 11 (this is version
1.0.0-beta1).

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Composer command and enabling the
   module.
2. [Configuration](configuration/index.md) — editing the page texts and pointing
   core's error pages at the provided paths.

## Where it lives in the admin menu

The text settings are at **Configuration → System → Status pages settings**
(`/admin/config/system/status-pages-settings`). You also finish setup on the core
**Basic site settings** page (`/admin/config/system/site-information`), where you
tell Drupal to use `/page-403` and `/page-404` as the error pages.
