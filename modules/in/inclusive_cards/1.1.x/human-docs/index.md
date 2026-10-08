# Inclusive Cards — manual setup guide

**Inclusive Cards** (`inclusive_cards`) makes "card" UI components — the
familiar image-plus-title-plus-link tiles you see in listings and teasers —
accessible and semantically valid. The usual way people build a clickable card
is to wrap the whole thing in one big `<a>` element, which breaks any other links
nested inside it (tags, "read more" buttons) and confuses screen readers.
Inclusive Cards takes a different approach: a small piece of JavaScript adds a
click behaviour to a card that has a link, turning the whole card into a clickable
surface *without* nesting everything inside one anchor, so other links inside the
card keep working.

Along the way it cleans up the accessibility of card images. Images that add no
meaning for the reader have their `alt` attribute removed and gain a
`role="presentation"` attribute, telling assistive technologies to skip them. If
such an image is itself wrapped in a link, that redundant parent link is removed
so the card's real link stays reachable.

You choose which display view modes the behaviour applies to (for nodes and
taxonomy terms) on a small settings page, then build the cards themselves as a
View rendered in a teaser or other content view mode. The module adds the
accessible click behaviour on top of whatever markup your theme produces.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — pick the view modes the accessible
   card behaviour should apply to.

## Where it lives in the admin menu

Once enabled, the settings page sits at **Configuration → System → Inclusive
Cards** (`/admin/config/system/inclusive-cards`). That is where you select which
node and taxonomy view modes get the accessible-card treatment.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On the settings page, tick the node and taxonomy display view modes you want
   the inclusive-card behaviour applied to.
3. Go to **Structure → Views** (`/admin/views`) and create a View that renders
   its rows as **Content** in the *Teaser* view mode (or another view mode you
   enabled above).
4. Visit the resulting page or block and confirm the cards behave correctly —
   the whole card is clickable, and any secondary links inside it (tags, buttons)
   still work independently.
