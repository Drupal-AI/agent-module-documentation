# Entity Reference Filtering Link — manual setup guide

**Entity Reference Filtering Link** (`entity_ref_filtering_link`) is a **field
formatter** for entity reference fields that renders each referenced entity as a
**link to a filtered listing** — a search page or any View pre‑filtered by that
entity — instead of a link to the entity's own page. It turns tags and other
references into "show me everything tagged X" links.

For example, on a node you might have a "Tags" reference field. With this
formatter, clicking a tag doesn't take you to the term page — it takes you to a
search/View page filtered to that tag, such as `/search?tag=7`. You configure,
per field instance, the **path** of the target page, the **argument name**, and
the **mode** that decides how the value is put into the URL. Supported modes
cover plain query arguments, multi‑value array arguments, autocomplete‑style
`label (id)` values, and **Facets**‑style URLs (`f[0]=tag:7`), by either the
entity ID or its label.

The module provides **two formatters**: the standard one, and a second identical
one that adds the ability to **exclude certain referenced entities from the link
by label** (handy for suppressing a catch‑all term). Both are configured entirely
on a field's *Manage display* / form display — there is no central settings page.
It works on Drupal 9, 10, and 11 with no dependencies beyond core, though **Field
UI** is strongly recommended so you can configure the formatter in the admin.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. Each
formatter is configured per field on *Manage display*, described in "How to use
it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from an entity's **Manage display**, for
example **Structure → Content types → *(type)* → Manage display**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** of the bundle whose entity reference field you
   want to turn into filtered links.
3. In the **Format** column, choose the filtering‑link formatter (pick the second
   variant if you need to exclude some entities from linking by label).
4. Open its settings and set:
   - **Path** — the base URL of the target listing/search page (for example
     `/search`).
   - **Argument name** — the query key the target page filters on (for example
     `tag`).
   - **Mode** — how the reference value is written into the URL (standard,
     multiple, double‑bracketed multiple, autocomplete, Facet by ID, Facet by
     label, or label).
5. Save. Each referenced value now links to the pre‑filtered listing. For
   instance, with path `/search`, argument `tag`, and a term of ID 7, a standard
   link becomes `https://example.com/search?tag=7`.
