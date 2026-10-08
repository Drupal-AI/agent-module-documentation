# Entity Mesh — manual setup guide

**Entity Mesh** (`entity_mesh`) analyzes the links inside your content and turns
them into a map you can report on and explore. For each entity it renders the
content, extracts every link, iframe, and image, resolves each one to its target,
and records the source→target relationships — so you can find **broken links** and
**orphan / dead-end pages**, see how many links of each kind exist, and visualize
the whole structure as an interactive **D3 force-directed graph**.

It classifies every target — internal entity, internal view, external http, tel,
mailto, iframe, file, or broken — and stores the relationships in its own database
table. A separate menu analysis records parent-page→child-page edges for the menus
you choose. Processing can run **synchronously** on save (up to a link threshold)
or **asynchronously** on cron, so it won't slow down editing on link-heavy content.
When a node is unpublished or deleted, the pages that link to it are automatically
re-queued so the map stays fresh.

Results surface in three ways: an **Overview report** at `/admin/reports/entity-
mesh` that summarizes "cases" (broken links, orphans, …) with counts and deep
links; a set of **Views** (with custom filters and fields, plus a D3 graph style)
you can build your own reports on; and warnings on the node/media delete form that
tell an editor when the thing they're deleting is referenced elsewhere. The same
case data also feeds Drupal's status report.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it has several
   contrib dependencies), enable it, and note the external D3 CDN caveat.

## Where it lives in the admin menu

- **Reports → Entity Mesh** (`/admin/reports/entity-mesh`) — the Overview report.
- **Configuration → System → Entity Mesh** (`/admin/config/system/entity-mesh`) —
  the settings form (the module's `configure` route), with a separate **cron** form
  at `/admin/config/system/entity-mesh/cron`.

Both admin surfaces are gated by restricted permissions: **Administer entity_mesh
configuration** (the settings/cron forms) and **Access entity_mesh report** (the
Overview report, the Views reports, and the delete-form warnings).

## How to use it

After enabling, open **Configuration → System → Entity Mesh** and set up what gets
tracked, then let it process content (on save or on cron) and read the reports. The
settings you'll work with:

- **Source types** — which entity types/bundles are analyzed as link *sources*.
  Nodes are the supported source; enable the type and, optionally, specific bundles
  (none checked = all bundles).
- **Target types** — what counts as a valid link *target*: internal entity types
  (and views), external schemes (http, tel, mailto), and iframes.
- **Menus** — which menus to analyze for parent→child page edges (default: Main
  navigation).
- **Analyzer account** — the audience the analysis renders content as, which
  decides which links are "accessible": anonymous (default), an authenticated role
  set, or a specific user. This is a deliberate config choice, *not* tied to
  whoever triggered the save.
- **Processing mode** — **synchronous** (analyze light content on save, defer
  link-heavy content to cron) or **asynchronous** (everything on cron, for the
  fastest saves), with a synchronous link limit.
- **Extras** — treat absolute self-domain URLs as internal, reclassify links to
  present-but-untracked public files as valid instead of broken, and record a
  "no-links" marker so orphan pages show up.
- **Cron form** — enable cron processing and cap how many entities are processed per
  run (a timeout guard).

After changing what's tracked, use the **entity_registry** consumer actions (Queue
all / Clear / Rebuild) on the `entity_mesh` and `entity_mesh_menu` consumers to
repopulate the data. To visualize, add the **Entity Mesh D3** style to a View over
the entity_mesh data, or use one of the shipped Views. You can also export the link
inventory via Views Data Export.

> **External CDN note.** The D3 graph loads the D3 library from the external
> `https://d3js.org` CDN. If your site has a strict Content Security Policy or needs
> to work offline, mirror D3 locally and override the module's `d3` asset library.
