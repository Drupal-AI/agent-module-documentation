# Taxonomy View Counter — manual setup guide

**Taxonomy View Counter** (`taxonomy_view_counter`) counts how many times each
taxonomy term page has been viewed and makes that number available in **Views**.
Every time a visitor lands on a term's page, the module increments that term's
running total; you can then add the count as a field in a view, display it, and
sort by it — so you can surface your most‑visited categories, tags or topics and
rank listings by popularity.

It is a lightweight engagement/analytics helper built on core. It depends on core's
**Views** and **Taxonomy** modules and supports Drupal 10 and 11. The module also
provides its own permission, so you can control who is allowed to see or work with
the view counts.

There is no global settings form — once enabled, counting happens automatically
and you expose the count wherever you build a view of terms.

This guide is written for a **human** working through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling the module, view counts start accumulating on their own as people
visit term pages. To display or sort by them, build or edit a view of taxonomy
terms (**Structure → Views**), add the module's **view count** field to show the
number, and add it as a **sort criterion** if you want the most‑viewed terms at the
top. Check **People → Permissions** to grant the module's permission to the roles
that should have access to the counter.
