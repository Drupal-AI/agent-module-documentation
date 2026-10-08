# Content Templates — manual setup guide

**Content Templates** (`content_templates`) lets editors turn any existing node
into a reusable "template" and then create fresh content pre-filled from it. It's
a way to give your team concrete starting points instead of blank forms — a
curated landing page, a well-structured event, a boilerplate FAQ — that they can
clone on demand.

Under the hood it leans on **Quick Node Clone** to do the actual copying, so even
complex nodes (paragraphs, media, references) are duplicated faithfully. On top of
that, Content Templates adds a template entity that points at a source node,
optional categories and thumbnail images for organizing templates, a visual
"Create from template" gallery, and tracking that records which template each new
node came from.

The workflow is driven entirely by template entities and permissions — there is no
central settings form. You mark nodes as templates, group them into categories,
and grant roles the right to create templates versus create content from them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including Quick
   Node Clone) and enable it.
2. [Configuration](configuration/index.md) — permissions, categories, and how to
   create and use templates.

## Where it lives in the admin menu

Content Templates has no single settings page. Its features live on and around
your existing content:

- **From a node:** `/node/{node}/template` creates or edits the template built
  from that node.
- **The gallery:** `/node/template` lists all published templates as cards,
  grouped by category, for editors to create new content from.
- **Usage overview:** `/node/{node}/overview` lists all content created from a
  given template.
- **Content list:** a *Create from template* action link is added to
  **Content** (`/admin/content`), which also gains a "Content Template" column and
  filter.

## How to use it

1. Build and save a well-structured node you want to reuse.
2. From that node, visit `/node/{node}/template` to create the template (give it a
   category and thumbnail if you like).
3. Editors open the **Create from template** gallery (`/node/template`), pick a
   template card, and get a new draft node pre-filled from the source.

See [Configuration](configuration/index.md) for the permissions that control who
can do each of these steps.
