# Configuration

Layout Builder Usage Reports has no settings form in the usual sense — the
"configuration" is the report itself and its filters. There is nothing to save;
you just open the report and refine what it shows.

## Open the report

1. Log in as a user with the **Access node layout reports** permission.
2. Go to **Reports → Layout Builder Usage Report**, or navigate directly to
   `/admin/reports/layout/usage`.

## What the report shows

The report is a table with one row per component placed in a node's overridden
layout. Its columns are:

- **Node ID** — the node's internal id.
- **Node Title** — a link straight to the node.
- **Bundle** — the content type.
- **Language** — the node's language (useful on multilingual sites).
- **Plugin ID** — the component's plugin identifier.
- **Label** — the component's configured label.
- **Provider** — the module that supplies the component (shown as "No Provider" if
  none is recorded).

Inline blocks are recognized as **block types**, and paragraph components (using
Layout Paragraphs–style `component:<type>` plugin IDs) are recognized as
**paragraph types**.

## Filters

A filter area above the table lets you narrow the results by:

- **Bundle** (content type)
- **Provider** (the module that supplies a component)
- **Language**
- **Block type** (a specific inline block type)
- **Paragraph type** (a specific paragraph component type)

Choose the filters you want and click **Filter**. Click **Reset** to clear them.

> **Note:** the selected filters are stored **site‑wide** (in Drupal's State API),
> not per user or per session — so a filter you set persists across page loads and
> is shared with anyone else viewing the report until it's reset.

## Things to keep in mind

- The report covers **node** layouts only. Other entity types using Layout Builder
  are not included.
- Paragraph detection assumes the Layout Paragraphs `component:<type>` plugin‑ID
  style.
- When **no filter** is selected, the query is capped at **500 rows** for
  performance (and the Reset button is hidden). Apply a filter to look beyond that
  cap on large sites.
