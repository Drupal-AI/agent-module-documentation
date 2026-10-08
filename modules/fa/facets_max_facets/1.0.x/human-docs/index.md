# Facets Max Facets — manual setup guide

**Facets Max Facets** (`facets_max_facets`) enforces a **global maximum on the
number of active facets** a visitor can apply at once in Search API faceted search.
Its main purpose is to blunt bots that select an enormous number of facets at once
— a pattern that generates expensive, deeply filtered queries and bloated URLs and
can degrade performance.

What sets it apart from the heavier‑handed approach of returning a 410 or 403 error
(as, for example, Facet Bot Blocker does) is that it lets the page render normally.
Once the visitor has reached the configured maximum, no new facet options are
offered and a message tells them they have hit the limit — so a click‑happy human
never gets an unexpected error page, they simply cannot add more filters.

You set the maximum count and the message on a small settings form, then opt each
facet in individually by ticking **"Respect global max facets"** on the facets you
want the cap to affect. The maintainer also suggests pairing it with
[Facet Bot Blocker](https://www.drupal.org/project/facet_bot_blocker), configured to
trigger at your maximum + 1, so that bots trying to push extra facets through URL
parameters still get the expected "not allowed" response while humans keep a smooth
experience.

This module affects facet behaviour only; results continue to follow the search
index's access rules and it has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.
2. [Configuration](configuration/index.md) — the settings form and how to opt each
   facet into the cap.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Search and metadata → Facets →
Max facets** (`/admin/config/search/facets/max-facets`). The per‑facet opt‑in
(the **"Respect global max facets"** checkbox) lives on each individual facet's
edit form.
