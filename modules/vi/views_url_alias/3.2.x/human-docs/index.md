# Views URL alias — manual setup guide

**Views URL alias** (`views_url_alias`) lets you filter and sort a View by the URL
(path) alias of the content it lists. Normally a View knows a node's ID, title, and
fields, but not the pretty URL you gave it — so you cannot easily say "show me every
page whose address starts with `/products/`." This module fills that gap.

It works by keeping a small, dedicated database table (`views_url_alias`) that maps
each content entity to its path alias. The table stays in sync automatically:
whenever an editor adds, edits, or deletes an alias, the module updates the matching
row behind the scenes. It then exposes that table to Views as a **relationship**, a
**filter**, and a **sort** — so you can join it into any content View and slice your
listings by alias.

This is handy for section landing pages ("everything under `/support/`"),
alphabetical‑by‑URL listings, sitemap‑style views that mirror your navigation, and —
paired with Views Bulk Operations — running an operation on every piece of content
beneath a path branch. Because the module joins a precomputed table instead of
resolving each row's alias at runtime, these Views stay fast.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no traditional settings form. You "configure" this module inside the Views
UI, plus an occasional one‑off rebuild — both covered below.

## Where it lives in the admin menu

The module adds one admin page: a **Rebuild views alias table** form at
**Configuration → Search and metadata → Rebuild views alias table**
(`/admin/config/search/views-url-alias`), gated by core's **Administer views**
permission. You only need it in the situations described below — day to day the table
maintains itself.

## How to use it

### Filter or sort a View by URL alias

1. Open or create a View of a content entity (a View of Content/nodes, for example).
2. Under **Advanced → Relationships**, click **Add** and choose the
   **"{Entity label} URL Alias"** relationship — for a node View that is
   *Content URL Alias*. This joins the content to its alias. (You can tick
   *Require this relationship* if you only want rows that have an alias.)
3. Under **Filter criteria**, click **Add** and choose **URL Alias** (in the *Alias*
   group). Configure it like any text filter — *contains*, *starts with*, *is equal
   to*, and so on. A "starts with `products/`" filter, for instance, scopes the
   listing to that section of your site.
4. Optionally add **URL Alias** under **Sort criteria** to order rows by their alias,
   or add it as a field to show the alias as a sortable column.

That is the whole workflow — there is nothing to switch on beforehand. A common
pattern is a "starts‑with" filter combined with Views Bulk Operations to act on
everything under one path branch at once.

### Rebuild the alias index

The mapping table normally keeps itself accurate as editors change aliases. But it
can drift out of sync in two situations: right after you first install the module on
a site that *already* has aliases, or when aliases are changed without going through
Drupal's normal forms — for example a bulk database import or a migration.

When that happens, the module notices and shows a warning to anyone with the
*Administer views* permission, along with a link to fix it. To rebuild:

1. Go to **Configuration → Search and metadata → Rebuild views alias table**
   (`/admin/config/search/views-url-alias`).
2. Confirm **Rebuild table**. The module empties the mapping table and repopulates it
   from scratch, in a batch, from all of your site's path aliases. When it finishes,
   the warning clears.

After the rebuild, your alias filters and sorts reflect reality again.

> **Note:** only content entities with numeric IDs are indexed (nodes, taxonomy
> terms, media, and the like) — which covers virtually all everyday content.
