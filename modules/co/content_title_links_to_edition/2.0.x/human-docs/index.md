# Content Title Links to Edition — manual setup guide

**Content Title Links to Edition** (`content_title_links_to_edition`) solves one
small but persistent editorial annoyance: in Drupal's admin **Content** listing
(and other Views‑based listings), a content title normally links to the
*published* node page, not to its edit form. Editors who spend their day changing
content then have to hover for the *Edit* operation, or open the node and click
the Edit tab. This module provides an out‑of‑the‑box option to make the **title
itself link straight to the entity edit form** instead.

That shortcut is especially welcome for editors who are unfamiliar with Drupal,
or who never need to see the public page from the admin listing — and it is a
natural fit for **headless / decoupled** Drupal, where the "front end" of a node
is somewhere else entirely and the canonical page is not where an editor wants to
land. The link respects **edit access**, so it only becomes an edit shortcut for
users who are actually allowed to edit that content.

The module depends only on core **Node** and **Views**, runs on Drupal 8.8
through 11, and is actively maintained. It is intentionally narrow in scope — the
maintainers welcome small, well‑documented contributions but are not actively
adding large features. There is no central settings screen; the behaviour is a
choice you make on a View.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no global settings
form. You turn the behaviour on where the title is rendered, described in "How to
use it" below.

## How to use it

The module adds an out‑of‑the‑box option for linking a content title to its edit
form rather than to the node's canonical page. In practice you enable that option
where the title field is configured for display in the relevant listing (for
example the admin **Content** view, or your own Views‑based content list), then
save the View. From then on, clicking a title takes an editor with edit rights
straight to that node's edit form.

Because the link is gated by edit access, users who cannot edit a given item are
not sent to an edit form they could not use — the behaviour degrades gracefully
per user and per node.
