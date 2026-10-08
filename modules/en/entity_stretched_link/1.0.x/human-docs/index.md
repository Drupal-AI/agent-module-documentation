# Entity Stretched Link — manual setup guide

**Entity Stretched Link** (`entity_stretched_link`) is a very lightweight module
that makes a whole entity teaser or card clickable — the "stretched link" pattern
popularised by Bootstrap. Instead of the link sitting on just the title, a click
anywhere on the rendered card navigates to the entity, which is exactly what you
want on card grids, teasers and search results.

It works by adding a pseudo‑field (an "extra field") to all entities, **disabled by
default**. You turn it on and position it from the entity's **Manage display**
screen; when displayed, it renders a link that covers the whole rendering area. It
depends only on core's **Field** module and supports Drupal 10 and 11.

One thing to know up front: **no CSS is included**. The stretched‑link effect
relies on a `.stretched-link` style in your theme (the standard Bootstrap rule).
If your theme doesn't already provide one, you'll need to add it yourself — see
"How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has no settings form — you enable and place its field on the entity's
Manage display screen, described in "How to use it" below.

## Where it lives in the admin menu

The stretched‑link field is placed from each bundle's **Manage display** screen,
for example **Structure → Content types → *(your type)* → Manage display** (and its
individual view modes, such as Teaser).

## How to use it

1. Go to the bundle and view mode where you want a clickable card, for example the
   **Teaser** display of a content type under **Manage display**.
2. The module adds a stretched‑link **extra field**, disabled by default. Move it
   out of the *Disabled* section and into the visible fields to display it.
3. Save the display. The rendered teaser/card now carries a link that stretches
   over the whole area.
4. **Add the CSS if your theme lacks it.** The effect needs a `.stretched-link`
   rule. If you don't already have one, add something like this to your theme:

   ```css
   .stretched-link::after {
     position: absolute;
     top: 0;
     right: 0;
     bottom: 0;
     left: 0;
     z-index: 1;
     content: "";
   }
   ```

   The card's container usually also needs `position: relative;` for the stretched
   link to cover it correctly.
