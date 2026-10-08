# Tab Tamer — manual setup guide

**Tab Tamer** (`tabtamer`) is an administration utility for cleaning up the
local‑task **tabs** — the "View / Edit / Delete / Revisions" style tabs (and
subtabs) that Drupal shows at the top of a page. On any given route you can
**reorder** those tabs, **rename** their link titles, and **hide** the ones you do
not want shown. It is the quick way to tidy a cluttered tab bar without writing
code.

You control tabs per route using a small **Tab Tamer** configuration entity. When
you add one, you tell it which route's tabs to manage (by the route's machine name,
such as `entity.node.canonical`), and the form loads that route's tabs live so you
can set a new **link title**, a **weight** for drag‑ordering, and a **Display**
checkbox for each. At render time Tab Tamer applies your choices: it relabels and
reorders the tabs, and hides any whose Display box you unchecked.

One important boundary: Tab Tamer only ever **relabels, reorders, or hides** tabs —
it never *grants* access. Hiding a tab here is a presentation choice, not a security
control; the underlying route still enforces its own access. So you can use it to
declutter a page, but hiding "Delete" does not stop someone who has permission from
reaching the delete route another way.

To make it easy to find, Tab Tamer injects an **Add tabtamer** / **Edit tabtamer**
tab on every page for users with the right permission, deep‑linking straight to the
config for the route you are currently on. It works on Drupal 10 and 11, has no
dependencies, and is gated by a single **Administer Tab Tamer** permission. Config
is exported as `tabtamer.tab_tamer.*`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — creating a Tab Tamer entity and tuning
   a route's tabs, field by field.

## Where it lives in the admin menu

Tab Tamer's entities are managed at **Structure → Tab tamer**
(`/admin/structure/tab-tamer`). Access to every Tab Tamer screen requires the
**Administer Tab Tamer** permission.

## How to use it

The fastest way is the injected tab: while viewing a page whose tabs you want to
change, click the **Add tabtamer** tab — the add form opens with that page's route
pre‑filled. Set the link titles, weights, and Display checkboxes you want, save, and
your changes appear on that route's tabs immediately. See
[Configuration](configuration/index.md) for the details.
