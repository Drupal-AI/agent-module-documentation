# Entity Usage Explorer — manual setup guide

**Entity Usage Explorer** (`entity_usage_explorer`) answers the question every
content audit stalls on: "Can I delete this?" It accurately tracks and displays
where entities are used across your site — based on the current revision of
entities — so instead of guessing, you get a direct list of what points at a given
thing. That makes safe deletion, impact assessment before changing a shared asset,
and finding orphaned content much more straightforward.

Its main feature is an **entity usage overview page** at
`/admin/usage/{entity_type}/{entity_id}`, which lists everywhere the entity is
referenced — across menu links, nodes, media, block content, users, paragraphs, and
more. It also adds a **"Usage" operations link** for all content entities (so you
can jump to the overview from a listing), and a **Views field plugin** called *Base
Entity Usage* that displays usage counts as plain text or as a clickable link to the
overview page. With the **Views Data Export** module, that usage data can be
exported as CSV, JSON, or XML.

The module works once enabled — there is no settings form. Access is governed by a
single permission, **Access Entity Usage overview page**, which appears on the
permissions page for you to assign per role. It works on Drupal 10 and 11.

Two caveats are worth knowing. First, usage tracking only sees the references it
knows how to see — entity reference fields and embeds are straightforward, but a
link typed into body text, a path hard‑coded in a template, or an id passed through
a custom module are references it cannot detect. **"No usages" therefore means "no
tracked usages,"** which is exactly the situation where a deletion surprises
someone. Second, the report aggregates across the whole site, so it can reveal that
a restricted entity is referenced from places a given viewer cannot otherwise see —
on an access‑controlled site, decide carefully who may read the usage report.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module. The only setup after enabling is
assigning the **Access Entity Usage overview page** permission on **People →
Permissions** (`/admin/people/permissions`).

## Where it lives in the admin menu

The usage overview page lives at `/admin/usage/{entity_type}/{entity_id}` — reach it
via the **"Usage"** operations link that the module adds to content entities. The
*Base Entity Usage* Views field plugin is available when building or editing a View.

## How to use it

1. Assign the **Access Entity Usage overview page** permission to the roles that
   should be able to see usage data (bear in mind the aggregation caveat above).
2. From any content entity's operations, click **"Usage"** to open its overview and
   see everywhere it is referenced.
3. To surface usage inside a View, add the **Base Entity Usage** field and choose
   whether to render it as a count or a link; add **Views Data Export** if you want
   to export the results as CSV, JSON, or XML.

Treat an empty result as "no tracked usages" rather than proof the entity is unused.
