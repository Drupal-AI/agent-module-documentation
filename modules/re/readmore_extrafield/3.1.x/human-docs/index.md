# Read More Extra Field — manual setup guide

**Read More Extra Field** (`readmore_extrafield`) takes the familiar "Read more"
link — the one Drupal shows under a node teaser — and turns it into an *extra
field*. Instead of being fixed inside the node "links" area at the bottom of the
rendered content, the link appears in **Manage display** alongside your real
fields, where you can drag it into any position, hide it per view mode, and — in
this **3.x** line — configure how it looks and behaves.

Out of the box, core only renders "Read more" in Teaser mode and always at the
bottom. If your design wants the link under the summary, above a list of tags, or
inside a card footer, you would normally need a template override that
re‑implements link logic core keeps changing. This module removes that chore: the
placement and its settings live in your display configuration, export cleanly
with `drush config:export`, and can differ from one view mode to the next.

This 3.x branch is a rewrite built on the **Extra Field** and **Extra Field
Settings Provider** contrib modules (both installed automatically as
dependencies, alongside core Field). Compared with the lightweight 1.x line, it
adds a per‑view‑mode settings form so you can change the link **label**, add
**CSS classes**, and set **`title`**, **`rel`**, and **`target`** attributes — and
if the optional **Token** module is enabled, the label, classes, and title accept
tokens resolved against the host entity. It does not touch the node itself, so
core's own "Read more" link stays available; you can use one, the other, or both.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Extra Field
   dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — enable and position the link in
   Manage display, and set its label, classes, and attributes, field by field.

## Where it lives in the admin menu

Read More Extra Field adds no admin page of its own. You use it entirely from a
bundle's **Manage display** — for example **Structure → Content types → Article →
Manage display** (`/admin/structure/types/manage/article/display`) — and the same
tab on any other fieldable entity.

## How to use it

1. Open the bundle and view mode you want — for example **Structure → Content
   types → Article → Manage display**, then the **Teaser** view mode.
2. In the **Extra fields** area (provided by Extra Field), find the **Read more**
   row and drag it to the position you want, or into **Disabled** to hide it here.
3. Click the field's gear/settings to set the link's label, extra classes, and
   `title`/`rel`/`target` attributes — see [Configuration](configuration/index.md).
4. Click **Save**.

The link always points at the node's canonical URL and carries a
`readmore-extrafield-link` CSS class. To change the surrounding markup, override
the module's `templates/readmore-extrafield.html.twig`; 3.x also offers rich theme
suggestions by view mode, entity type, bundle, and entity id.
