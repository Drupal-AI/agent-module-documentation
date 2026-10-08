# Term Condition — manual setup guide

**Term Condition** (`term_condition`) adds a reusable **"Term"** condition that
passes when the node you're currently viewing references one of a set of taxonomy
terms you choose. Its most common job is **block visibility**: show a block only
on content tagged with a particular term — a "Sale" promo that appears only on
sale-tagged articles, a department sidebar that follows a department term, a
seasonal banner tied to a "Holidays" term.

Because it's a standard Drupal condition plugin, the "Term" condition shows up
anywhere Drupal collects conditions — the **Visibility** section of the block
placement form is the primary place, but any condition consumer (such as Context)
can use it too. You pick one or more terms in an autocomplete, and the module
stores your choice by term **UUID** rather than term ID, so exported block
configuration keeps working across environments even when content is re-imported.

The module has no settings page, no permissions, and no Drush commands. It depends
only on core's **Taxonomy** module. When you upgrade from an older version, a
built-in update automatically converts old term-ID-based rules to the new
UUID-based format.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. The condition appears inside the **block
placement form** at **Structure → Block layout** (`/admin/structure/block`), under
the **Visibility** tab as **Term**.

## How to use it (block visibility)

1. Go to **Structure → Block layout** and **Place block**, or edit a block that's
   already placed.
2. Open the **Visibility** vertical tab and select **Term**.
3. In **Select taxonomy term(s)** — a tagged autocomplete — type and pick one or
   more terms. Selecting several means the block shows on *any* of them (OR
   logic).
4. Optionally tick **Negate the condition** to flip the rule (hide the block on
   matching content instead of showing it).
5. **Save block.**

A couple of things worth knowing:

- The condition needs a **node context**, so it only has something to test on
  routes that resolve a node (like a node's canonical page). On the block form
  that context is wired up for you automatically. The route also resolves on
  taxonomy term pages, node preview, and node revision routes.
- If you select **no terms** and don't negate, the condition simply passes (it
  doesn't restrict) — so an empty selection won't accidentally hide your block.
- Matching is by term **UUID**, which is why block visibility that references
  terms deploys cleanly between your dev, staging, and production sites.
