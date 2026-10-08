# Read More Extra Field — manual setup guide

**Read More Extra Field** (`readmore_extrafield`) takes the familiar "Read more"
link — the one Drupal shows under a node teaser — and turns it into an *extra
field*. That small change has a big payoff: instead of being locked inside the
node "links" area at the bottom of the rendered content, the link now appears in
**Manage display** alongside your real fields, where you can drag it into any
position, hide it on any view mode, or leave it out entirely.

Out of the box, core only renders "Read more" in Teaser mode and always at the
bottom, next to comment and contextual links. If your design wants the link
directly under the summary text, above a list of tags, or tucked into a card's
footer, you would normally need a template override that re-implements link
logic core keeps changing between versions. This module removes that chore: the
placement lives in your display configuration, exports cleanly with
`drush config:export`, and can differ from one view mode to the next.

This is the lightweight **1.x** line. It depends only on core's **Field** module,
adds no settings form, and does not touch the node itself — core's own "Read
more" link stays available, so you can use one, the other, or both. (If you want
per-link options such as a custom label, extra CSS classes, or `target`/`rel`
attributes, look at the feature-rich **3.x** line of the same project instead.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this version — it has no settings form.
You position the link entirely from a bundle's **Manage display**, described in
"How to use it" below.

## Where it lives in the admin menu

Read More Extra Field adds no admin page of its own. You use it from **Structure
→ Content types → *(your type)* → Manage display**
(`/admin/structure/types/manage/{type}/display`), and the same "Manage display"
tab on any other fieldable entity.

## How to use it

1. Go to the bundle and view mode you want to change — for example **Structure →
   Content types → Article → Manage display**, then the **Teaser** view mode (use
   the view-mode tabs, or enable custom settings for it first).
2. In the field list, find the **Read more** row in the **Extra fields** area.
   Drag it to wherever you want the link to appear, or drag it into the
   **Disabled** section to hide it on this view mode.
3. Click **Save**.

Repeat per view mode to give each its own placement — for instance, showing the
link in Teaser but hiding it in a custom "Card" view mode. Because the setting is
part of the display configuration, it travels with your exported config.

To theme the link's markup, override the module's
`templates/readmore-extrafield.html.twig` in your theme.
