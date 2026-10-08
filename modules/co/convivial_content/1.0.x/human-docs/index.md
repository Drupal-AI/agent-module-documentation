# Convivial Content — manual setup guide

**Convivial Content** (`convivial_content`) ships **default content** for the
Convivial Drupal distribution/profile. It provides the starter and demo content —
example pages and structure — that a new Convivial‑based site uses so it does not
start out empty. It is part of the Convivial ecosystem maintained by Morpht, and it
depends on the **Convivial Core** module.

Rather than bundling the content statically, this module **imports** it: you point
it at a source URL, then choose a dataset and run the import from the Convivial CXP
content‑import screens. That makes it easy to seed a fresh site with a known set of
example content.

Two things are worth remembering. First, this is a distribution/site‑building tool;
it seeds content and has no role in access control. Second, default and demo content
is only a **starting point** — review it and replace it before going to production.
Also note (per the module's own FAQ) that importing requires high‑level
permissions, so always run imports as the site administrator, not as an ordinary
authenticated user.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with Convivial Core).
2. [Configuration](configuration/index.md) — set the source URL and run the content
   import.

## Where it lives in the admin menu

Once enabled, its settings and import live under **Configuration → Convivial CXP →
Content Import** — with this module's own source configuration at **Configuration →
Convivial CXP → Content Import → Convivial Content**.
