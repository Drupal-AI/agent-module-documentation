# Domain Access Logo — manual setup guide

**Domain Access Logo** (`domain_access_logo`) gives each domain in a
[Domain](https://www.drupal.org/project/domain) (Domain Access) installation its
own logo. It builds on the Domain module, which lets a single Drupal site serve
several hostnames from shared content. The catch is that the site logo is a
*theme* setting, and themes are not domain-aware — so out of the box every domain
shows the same mark, even when they are meant to be separately branded.

This module solves that by attaching a logo upload to each domain record. Because
the logo hangs off Domain's own records rather than the theme, it follows the
domain regardless of which theme is active — so you can keep one shared theme
across many branded domains and still show the right logo on each. And because the
logos are ordinary uploaded files (it depends on core's **File** module), they
live in the file system and are managed like any other managed file, which means
you can change a domain's logo without a code deployment.

Access to the logo settings is controlled by the module's own permission,
**Administer domains access logos** — separate from the general "administer site
configuration" permission — so you can delegate per-domain logo management to
someone without handing them the keys to the rest of the site's configuration.

One practical note carried over from the module's own documentation: logo storage
changed between the 1.x and 2.x releases, so if you are upgrading an existing site
check the module's install/update path rather than assuming a straight swap. Also
be aware that, because the logos are uploaded files rather than configuration,
they are **not** part of a configuration export — treat them as content/files when
you move a site between environments.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (alongside the
   Domain module), enable it, and grant the permission.
2. [Configuration](configuration/index.md) — the per-domain logo settings form,
   field by field.

## Where it lives in the admin menu

The whole interface is a single settings form at **Configuration → Domain →
Domain Access Logo** (`/admin/config/domain/domain_access_logo`). It also appears
as a task/menu link within the Domain admin area, so you can manage logos
alongside the rest of your Domain configuration.
