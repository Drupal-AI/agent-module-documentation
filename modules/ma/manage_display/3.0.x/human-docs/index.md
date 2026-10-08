# Manage Display — manual setup guide

**Manage Display** (`manage_display`) makes an entity's **base fields** — things like
the node or term **title**, the **author**, the **created date**, and a comment's
**subject** and parent — configurable on the standard **Manage display** page. Out of
the box, Drupal marks these base fields as *not* display-configurable, so they never
appear there; instead they're printed by the theme's Twig templates (via `label`,
`display_submitted`, and the page-title block). That's why moving a node title or
removing the "Submitted by …" byline normally means editing `node.html.twig` or
writing a preprocess hook.

This module flips that. Once enabled, the title, author, date, and related base fields
show up as rows on **Manage display**, where you can reorder them relative to your
real fields, hide them, choose a formatter, and set options — all as exportable
configuration, no theme deploy required. It ships three purpose-built formatters to
render these fields the way core's templates used to:

- **Title** — renders the title (or term name / comment subject) in a heading tag you
  choose (`h1`–`h5`, `div`, or `span`; default `h2`), optionally linked to the entity.
- **Submitted** — renders the "Submitted by *X* on *Y*" byline, with an option to
  include the author's user picture in a view mode you pick.
- **In reply to** — for threaded comments, renders the "In reply to *subject* by
  *author*" line.

It has no settings form of its own and no permissions — **enabling the module is the
configuration**; from there you work entirely on the Manage display screens. It
depends only on Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There's no dedicated settings page. You configure everything on each bundle's
**Manage display** screen, for example **Structure → Content types → Article → Manage
display** (`/admin/structure/types/manage/article/display`), and its per-view-mode
variants like *Teaser*.

## How to use it

After enabling the module, open a content type's **Manage display** page. You'll now
see extra rows for the base fields:

### The title

The **Title** row appears near the top. Click its cog to:

- **Tag** — choose the heading element that wraps the title (default `h2`). Set it to
  `h1` on the full view mode, `h3` on a teaser, and so on — a simple way to
  standardize heading levels for accessibility across every content type from one
  screen.
- **Link to the … entity** — toggle whether the title is a link to the content or a
  plain heading.

You can also drag the title into a different position, or drag it to the **Disabled**
region to hide it (handy for a view mode used inside a Layout Builder block).

### The "Submitted by" byline

By default the **Author** (`uid`) and **Created** date rows start in the *Disabled*
region on nodes — you opt in. To show the byline:

1. Drag the **Author** row into the content region and set its format to
   **Submitted**.
2. In its settings, optionally choose a **user picture view mode** to show the
   author's avatar.

The module then automatically weaves the author and date into a single "Submitted by
X on Y" sentence at render time — you don't place the date separately; it's absorbed
into the byline. (If you'd rather show the date on its own, use core's *Author*
formatter on the author field instead and keep Created as its own row.)

Because the Submitted formatter replaces core's byline, the module also removes two
now-redundant controls: the "Display author and date information" fieldset on the
content-type form, and the node/comment user-picture toggles in your theme settings.

### Comments and other entities

The same treatment applies to comment subject/author/date/parent (including the "In
reply to …" line), taxonomy term names, the user `name` field, and aggregator feeds —
each becomes a configurable row on its respective Manage display page.

### Theming (optional)

The byline and "in reply to" line come from overridable templates
(`submitted.html.twig`, `submitted--comment.html.twig`, `in-reply-to.html.twig`).
Copy one into your theme's `templates/` directory to reword it site-wide — for
example to change the "Submitted by … on …" phrasing.
