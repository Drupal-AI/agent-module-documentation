# Navigation Blocks — manual setup guide

**Navigation Blocks** (`navigation_blocks`) supplies small, practical navigation
helpers as placeable blocks — the kind of wayfinding aids that Drupal core does
not offer out of the box. Its headline feature is a **generic "back" button**
that, given an entity type, a bundle, or a URL, sends the user back to a preferred
location. These are convenience blocks you drop into a layout to improve how
visitors move around your site.

It is a UI/navigation module with no security surface of its own — it does not
change content or access. One behavioral note worth confirming for your use case:
a "back" behavior that relies on browser history or the HTTP referrer can be
influenced by the visitor's own navigation, which is fine for UX but means you
should verify the block returns people where you actually intend. It depends on
core **Block** and **Link**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page** for this module — you configure each
block where you place it, described in "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Place block** in the region where you want the navigation aid, and
   choose one of the module's blocks (for example the generic **back** button).
4. In the block's settings, configure its target — for the back button, specify
   the entity type, bundle, or URL that determines where "back" should lead — and
   set the usual block visibility conditions.
5. Save the block. Test it on the front end and confirm it takes visitors to the
   location you intended.
