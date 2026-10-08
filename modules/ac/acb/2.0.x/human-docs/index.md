# Access Control Bridge — manual setup guide

**Access Control Bridge** (`acb`) reconciles several node-access modules that are
running on the same site at once — modules like Content Access, Domain Access,
Workflow, Organic Groups, and Taxonomy Access Control — so that they stop
cancelling each other out.

The problem it fixes is a genuine and surprising one. Drupal's node-access system
is a grants table, and its combining rule is the source of endless confusion: a
node is visible if **any** participating module grants access to it. That means
adding a *second* access module to a site usually makes content **more** visible,
not less. Teams expect restrictions to *intersect* (both modules must agree), but
what actually happens is a *union* (either module can open it up). These modules
are individually excellent and, in the words of the module's own help text, "tend
to break each other's functionality if used together." Access Control Bridge sits
between them and produces a combined result that behaves the way the site owner
expected. It has no dependencies of its own — it bridges whatever access modules
are present.

This is the most consequential category of module you can add to a site, so treat
it with care. Anything that alters node-access grants needs **testing as its
deliverable**, not as an afterthought. And because it changes grants, remember
that `node_access_rebuild()` must run afterwards — see "How to use it" below.

This guide is written for a **human** setting the module up. If you want the
terse, token-cheap reference written for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Access Control Bridge does its work by bridging the access modules already present
on your site — there is no settings form to fill in. The real work is
verification, because you are changing who can see what:

- **Test as the deliverable.** Before and after enabling it, enumerate your roles
  against your content states and check each combination — including the
  **anonymous** row. Do not assume; confirm each cell of that grid.
- **Rebuild grants and watch it.** Whenever the grants change, Drupal's
  `node_access_rebuild()` has to run, and you should watch the site while it does.
  A partially rebuilt grants table is a live content-disclosure risk, not a
  cosmetic glitch — so run the rebuild during a controlled window and confirm it
  finishes.
