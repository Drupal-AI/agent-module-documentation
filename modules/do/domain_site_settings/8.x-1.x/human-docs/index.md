# Domain Site Settings — manual setup guide

**Domain Site Settings** (`domain_site_settings`) lets you configure a handful of
**basic site settings per domain** — site name, slogan, email, front page, and the
404 and 403 error pages — so each domain of a Domain-module multisite can present
its own identity from a single Drupal install. It is part of the **Domain**
ecosystem and depends on the `domain` module and its `domain_config` submodule.

Ordinarily these basics live in Drupal's *Basic site settings* and apply to the
whole install. On a multi-brand or multi-country site that is the wrong granularity:
each domain wants its own name, its own contact email, its own front and error
pages. This module adds an administrator interface where you set those values
against each domain, so visitors on each domain see the right identity while you
keep one codebase.

> **Important — this module is deprecated.** Its own maintainers mark it
> *unsupported* and *obsolete*, and recommend using **Domain Config** and **Domain
> Config UI** (both submodules of the Domain project) instead. In the near future
> Domain Site Settings will no longer be supported and will be replaced by Domain
> Config. For a new project, use Domain Config UI; consult the project's referenced
> upgrade-path issue if you are already on this module. This guide documents it for
> existing sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Domain and Domain Config.
2. [Configuration](configuration/index.md) — set per-domain site name, slogan,
   email, and front/error pages.

## Where it lives in the admin menu

The per-domain settings form is at **Configuration → Domain → Domain Site
Settings** (`/admin/config/domain/domain_site_settings`), reachable by users with
the **`domain site settings`** permission.
