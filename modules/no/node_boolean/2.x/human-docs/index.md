# Node Boolean — manual setup guide

**Node Boolean** (`node_boolean`) adds a **condition plugin** to Drupal that
evaluates a node's boolean (checkbox) field. Conditions are what Drupal uses to
decide, among other things, whether a block should be shown — so this module lets
you say "only display this block on a node whose *Featured* checkbox is ticked,"
without writing any code.

The problem it solves is a common one in site building: you want a block (a call
to action, a promo, a notice) to appear only on certain pieces of content, and the
natural signal for "certain content" is already a checkbox field on the node.
Drupal's built-in visibility conditions don't cover arbitrary node fields, so
Node Boolean fills that gap for boolean fields specifically. Its notable strength
over similar tools is that it can evaluate **multiple** boolean fields at once and
combine them with either "all must be checked" or "any may be checked" logic.

There is nothing to configure globally — the module works the moment you enable
it, and you use it entirely from the **Block Layout** screen when placing or
editing a block. It depends only on core's Node module. It is currently limited to
node fields.

> **Important:** this is a **display** condition, not an access control. A block
> hidden by a Node Boolean condition is simply not rendered — it is not
> access-protected. Never rely on it to keep sensitive content private.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — you use it from Block Layout,
described in "How to use it" below.

## Where it lives in the admin menu

Node Boolean adds no admin page of its own. You reach it while editing a block at
**Structure → Block layout** (`/admin/structure/block`), under the block's
**Visibility** settings.

## How to use it

1. Make sure the content type you care about has a **boolean (checkbox) field**
   (for example a *Featured* field).
2. Go to **Structure → Block layout** and place or edit the block you want to show
   conditionally.
3. In the block form, open the **Visibility** section and select **Node Boolean**.
4. Choose the boolean field (or fields) whose value should be evaluated. If you
   pick more than one, decide whether the block appears when **all** of them are
   checked or when **any** of them is checked.
5. Save the block. It will now appear only on nodes whose selected checkbox
   value(s) match your condition.
