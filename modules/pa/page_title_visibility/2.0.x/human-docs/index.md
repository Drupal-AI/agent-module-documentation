# Page Title Visibility — manual setup guide

**Page Title Visibility** (`page_title_visibility`) lets editors hide the page title
on individual nodes — and set a per-content-type default — without deleting the title
or hand-editing block visibility. It's the tidy answer to "this landing page already
shows its heading in a hero, so I don't want the `<h1>` printed twice."

The clever part is *how* it hides the title. Rather than removing the core Page Title
block, it adds core's `visually-hidden` CSS class to that block on the affected node's
page. So the `<h1>` stays in the markup — screen readers and search engines still see
it — but it's hidden from sighted users. This keeps your accessibility and SEO intact
while cleaning up the visible layout.

It works by adding a **Display page title** checkbox (a revisionable, translatable
field, on by default) to every node, shown in a "Page display options" section of the
node edit form. A per-content-type default lives on the node type form and seeds new
nodes. Changing either control requires a dedicated permission. The module depends on
core's **Block**, **Node**, and **System** modules, and has no settings page of its
own. Note that for the effect to do anything, your content type must actually render a
page-title block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per-node checkbox, the
   per-content-type default, and the permission that gates them.

## Where it lives in the admin menu

There is no central settings page. The controls live where the content is:

- **Per node** — the **Display page title** checkbox in the "Page display options"
  section (advanced/vertical tabs) of any node's add/edit form.
- **Per content type** — a "Page display defaults" section on each content type's
  edit form at **Structure → Content types → *(type)* → Edit**.

Both are only editable by users with the **Administer page display visibility config**
permission.
