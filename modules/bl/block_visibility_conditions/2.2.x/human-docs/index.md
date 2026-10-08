# Block Visibility Conditions — manual setup guide

**Block Visibility Conditions** (`block_visibility_conditions`) adds extra
visibility conditions to Drupal's block placement UI. Its headline feature is a
set of **"Not {bundle}"** conditions that let you hide a block on selected
content bundles while keeping it visible everywhere else on the site.

Why does this matter? Drupal core already lets you control where a block appears
(by content type, page, role, and so on), but core's bundle conditions only
evaluate on that entity's own pages. If you take core's "Content type" condition
and negate it, the block still disappears on views, taxonomy pages, and the front
page — because those routes have no node to test against. This module fixes that:
its "Not" conditions return "visible" on any page that is *not* one of the chosen
bundle pages, so the block is hidden **only** on the bundles you pick and shown
on all other pages.

The parent module ships only the shared machinery (an abstract base class that
other conditions build on). The actual, ready-to-use conditions come from three
optional submodules: **Node** (adds *Not Node Type*), **Taxonomy** (adds *Not
Taxonomy Vocabulary*), and **Commerce** (adds *Not Product Type*). Enable only
the ones you need. There is no admin settings page, no permissions, and no Drush
commands — you configure everything per block in the standard "Configure block"
form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.

## Where it lives in the admin menu

Block Visibility Conditions has **no settings page of its own**. Everything
happens inside the block placement UI at **Structure → Block layout**
(`/admin/structure/block`), or in the "Configure block" form when you place a
block through Layout Builder.

## How to use it

1. Enable the parent module plus the submodule(s) providing the conditions you
   need — for example the Node submodule for *Not Node Type* (see
   [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and either **Configure** an existing block
   or **Place block** into a region. (For Layout Builder, open the block's
   **Configure** form inside the layout.)
3. Open the **Visibility** section and find the new condition — for example **Not
   Node Type**. Tick the bundles the block should be *hidden* on. Note there is
   deliberately no "Negate the condition" checkbox here; the "Not" logic is built
   in.
4. Save the block.

The result: with one or more bundles checked, the block is hidden only on those
bundles' pages and shown on every other page. If you check nothing, the condition
always passes and the block simply shows everywhere. You can freely combine a
"Not" condition with core conditions (roles, request path, and so on) on the same
block, and the resulting settings export cleanly to configuration for deployment
across environments.

Developers can extend the module to any bundled entity type (for example media
types) by subclassing its `NotConditionPluginBase` — see the
[`agent/`](../agent/start.md) docs for the small amount of code involved.
