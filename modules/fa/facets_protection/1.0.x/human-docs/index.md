# Facets Protection — manual setup guide

**Facets Protection** (`facets_protection`) guards your faceted pages against
crawlers — largely AI bots — that hammer faceted Views by walking through cached
facet URLs. It appends a short‑lived token to facet links; when a facet request
arrives without a valid token, the module shows a lightweight blocking page instead
of running the expensive filtered query, and returns HTTP status **410 ("Gone")**.

There are two blocking‑page styles: a plain one where the working links appear
after about 2.5 seconds and can then be clicked, and a second that looks like a
modern CAPTCHA and forwards on click. Both are intentionally minimal to keep
resource use low, and both can be adapted through a theme template. The token's
validity period is configurable in the backend.

It is important to understand the scope: this protection works against bots that
**traverse previously cached URLs**. It is *not* effective against bots that crawl
the site in real time. Think of it as a stop‑gap that protects existing facets
until you can migrate to Facets version 3 and expose facets as Views exposed
filters (which addresses the underlying problem), especially when that migration is
a matter of time or budget. The maintainer also points to
[Facet Bot Blocker](https://www.drupal.org/project/facet_bot_blocker) as an
alternative approach that instead limits the number of facets that can be selected.

This module provides its own permissions and has no broad access‑control role
beyond them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.
2. [Configuration](configuration/index.md) — the token validity period, blocking
   pages, and permissions.

## Where it lives in the admin menu

Facets Protection adds a settings form where you set the token's validity period,
and it registers its own permissions on **People → Permissions**. The blocking
pages are adjusted through theme template overrides rather than in the UI. See
[Configuration](configuration/index.md) for details.
