# Paragraph Lineage — manual setup guide

**Paragraph Lineage** (`paragraph_lineage`) helps administrators trace the
**lineage of a paragraph** — that is, which host entity and parent a given
paragraph belongs to. Because paragraphs are nested and embedded rather than
standalone pages, it is otherwise hard to see where a particular paragraph actually
lives; this module renders a paragraph together with its ancestors so you can follow
the chain back up.

The practical motivation was **media management**. A common need is to build a View
that shows a file or media entity's connection to the paragraphs that use it, and
from there follow the paragraph's lineage up to the node, term, user or other entity
that ultimately contains it (an entity with an administrator‑only `entity.*.canonical`
route). That lets a site admin evaluate media usage, consolidate files, and make
sure media with sensitive content is managed correctly.

After installation you get a ready‑made View at **Content → Paragraph Lineage**
(`/admin/content/paragraph-lineage`). Each paragraph entity in it links to a view of
itself in a chosen view mode — *teaser*, *preview* or *default*. The module can
render a paragraph in its default view mode, display a paragraph's lineage, list the
available view modes for a paragraph bundle, and add a field that shows a file's
paragraph parent in file‑usage listings.

It is strictly **read‑only**: it does not alter paragraphs or any other entities, it
only provides read access to entities that already exist, and it respects the host
entities' access — so it carries no known security risk and has no access‑control
role. It depends on the **Paragraphs** and **Views** modules and is covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and its
   Paragraphs / Views dependencies, and enable it.

There is **no settings form** for this module. Everything is delivered through the
Paragraph Lineage View, which you can customise like any other View.

## Where it lives in the admin menu

Paragraph Lineage adds a View at **Content → Paragraph Lineage**
(`/admin/content/paragraph-lineage`). It does not add a settings page.

## How to use it

1. Install and enable the module along with Paragraphs and Views (see
   [Installation](installation/index.md)).
2. Go to **Content → Paragraph Lineage** (`/admin/content/paragraph-lineage`) to
   browse paragraphs, each with links to view it as a *teaser*, *preview* or
   *default*.
3. To trace media, build or extend a View that relates your file/media entities to
   the paragraphs that reference them, then follow the lineage up to the host node,
   term or user — useful for auditing media usage and consolidating files.
