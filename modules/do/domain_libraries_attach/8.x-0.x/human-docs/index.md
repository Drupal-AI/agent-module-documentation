# Domain Libraries Attach — manual setup guide

**Domain Libraries Attach** (`domain_libraries_attach`) lets a
[Domain](https://www.drupal.org/project/domain)-module multi-site attach different
asset libraries — CSS and JavaScript — to different domains. On a site where one
Drupal installation serves several branded hostnames, this means each domain can
load its own front-end styles and scripts without needing a separate theme per
domain.

The libraries it offers come from your **active (default) theme**. You define a
library the normal Drupal way — as an entry in your theme's `*.libraries.yml` file
— and then, on this module's settings page, assign that library to the domains that
should load it. From then on, pages served on a given domain include the libraries
you assigned to it.

This is purely a content-display / asset-management feature. It changes which CSS
and JS load per domain; it does not change your content and it has no role in
access control. It is the lightweight way to give each domain a distinct look while
sharing one theme and one codebase.

The module has a real settings form, so setup is: define the library in your theme,
then map libraries to domains on the settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (the Domain module is expected to be present).
2. [Configuration](configuration/index.md) — defining a theme library and
   assigning it to domains.

## Where it lives in the admin menu

The settings form is at **Configuration → Domain → Domain libraries settings**
(`/admin/config/domain/domain_libraries_attach`) — it appears as a tab within the
Domain records area. Your domains themselves are managed by the Domain module.
