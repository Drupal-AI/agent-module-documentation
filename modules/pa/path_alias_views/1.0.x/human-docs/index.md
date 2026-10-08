# Path Alias Views — manual setup guide

**Path Alias Views** (`path_alias_views`) exposes core's **Path Alias** entities to
the **Views** module, so you can build lists and reports of your site's URL
aliases the same way you'd build any other view. Once enabled, "Path alias"
becomes an available base for a new view, complete with fields, filters, sorts,
and relationships back to the entity each alias points at. It's a site‑builder and
developer tool for auditing, reviewing, or reporting on aliases — for example a
page that lists every alias alongside its target node's title and status.

It carries no content or access role of its own: the aliases are ordinary site
metadata, and each view you build is governed by **Views' own access settings**,
just like any other view.

The optional **Path Alias Views HS Filter** submodule
(`path_alias_views_cshs_filter`) adds a *hierarchical* filter for path components,
letting a view be narrowed by parent path — useful when your aliases follow a
nested structure like `/services/planning/apply`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally add the hierarchical‑filter submodule.

There is **no configuration page** for this module — it simply adds a data source
to Views. All setup happens in the Views UI when you build a view.

## Where it lives in the admin menu

Path Alias Views adds no admin page of its own. You use it entirely from the
**Views** UI at **Structure → Views** (`/admin/structure/views`), where "Path
alias" is available when you create or edit a view.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Views → Add view** and choose **Path alias** as the type
   of thing the view shows.
3. Add fields (for example the alias, the system path, and — via a relationship —
   the target entity's title), plus any filters and sorts you need.
4. If you installed the HS Filter submodule and the CSHS library/module, add its
   hierarchical filter to narrow results by parent path.
5. Set the view's access controls as you would for any other view, then save.
