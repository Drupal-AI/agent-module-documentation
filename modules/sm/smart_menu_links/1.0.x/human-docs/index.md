# Smart Menu Links — manual setup guide

**Smart Menu Links** (`smart_menu_links`) lets you create menu links that resolve
relative to the entity the current path is about, rather than pointing at one fixed
target. It is the navigational complement to a View with a contextual filter
(argument) taken from the path: you build one menu item for the View, and Smart
Menu Links preserves the contextual argument as the visitor moves between related
listings.

The motivating example is an events site. Say each event has several Views hung off
it — the sessions for that event, its sponsors, and so on, each driven by a
contextual filter on the event ID in the path. Without this module you would need a
separate menu link per event. With it, you create a single "smart" menu link per
View, and it carries the current event's argument through, so the same menu works
for every event.

When you define a link you specify **which part of the path** to draw the argument
from, the **entity type and bundle** to validate the resolved target against, and
optionally **one or more workflow states** the referenced entity must be in for the
link to appear — so you can surface different links across an entity's life cycle.
The resolved links respect the target entity's own access: a link to content the
visitor cannot see behaves accordingly. The module provides its own permissions and
has no access-control role of its own.

It works on Drupal 10 and 11. In addition to Drupal core it **requires the Pathauto
module**; it was built to support the Drupal Event Platform.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Pathauto) with
   Composer and enable it.
2. [Configuration](configuration/index.md) — define your smart menu links and their
   resolution and validation rules.

## Where it lives in the admin menu

Once enabled, you define and manage Smart Menu Links under the **Structure** menu.
Note that after adding a new link a **cache clear** is sometimes needed before it
appears — the maintainers note this is a known rough edge they hope to resolve in a
future release.
