# Block Visibility Groups — manual setup guide

**Block Visibility Groups** (`block_visibility_groups`) removes a lot of repetitive
clicking from Drupal's block layout. Normally, every block carries its own
visibility conditions — show on this route, only for that role, on this content
type — and if a dozen blocks should all appear on the same set of pages, you end up
entering the same conditions a dozen times. This module lets you define a named
group of conditions **once** and then attach many blocks to it, so they all share
one reusable rule set.

A group is a small configuration entity holding an ordered list of **Condition**
plugins (route, node type, user role, and — with CTools or other contrib condition
modules installed — many more), a **logic** operator (*and* = every condition must
pass, *or* = any one is enough), and a flag for whether individual blocks may add
extra conditions on top. You manage groups at **Structure → Block Layout → Block
Visibility Groups**, and every block gains a **Condition Group** option in its
Visibility settings — pick a group there and the block inherits that group's
conditions. Change a shared condition once and every block in the group updates.

At render time the module's evaluator loads the chosen group, resolves all its
conditions with the group's AND/OR logic, and decides whether each member block
shows — while correctly propagating the group's cache tags, contexts, and max‑age
to every block that uses it. If you turn off "allow other conditions," the member
blocks lose their own per‑block visibility options, making the group the single
source of truth. It is a lightweight, context‑driven alternative to Panels for
"show this cluster of blocks on section X." It depends only on core's **Block**
module; **CTools** is recommended (not required) because it ships extra condition
plugins that groups can use, and Menu Condition, Term Condition, and Token
Conditions add still more.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add optional condition modules.

## Where it lives in the admin menu

Groups are managed at **Structure → Block Layout → Block Visibility Groups**
(`/admin/structure/block/block-visibility-group`), which also appears as a tab on
the Block Layout page. Assigning a block to a group happens on the standard block
form's **Visibility** tab. Both are gated by core's **Administer blocks**
permission.

## How to use it

### 1. Create a group

1. Go to **Structure → Block Layout → Block Visibility Groups** and click **Add
   Block Visibility Group**.
2. Set a **Label** and machine **id**.
3. Choose the **Logic**: *All conditions must pass* (AND) or *Only one condition
   must pass* (OR).
4. Decide **Allow other conditions on blocks** — leave it unchecked to make the
   group the sole source of visibility rules (member blocks lose their own
   visibility options), or check it to let blocks add extra conditions on top.
5. **Save.** The **Conditions** section only appears after this first save, so
   re‑edit the group to continue.

### 2. Add conditions

In the group's **Conditions** section, click **Add new condition** (an AJAX modal
opens), pick a condition plugin — route, node type, user role, and whatever your
installed contrib modules provide — configure it, and save. Where the plugin
supports it you can **negate** a condition (for example, show everywhere *except*
one route). Repeat to build up the shared rule set.

### 3. Assign blocks to the group

Edit any block and open its **Visibility** settings. The module adds a **Condition
Group** section with a **Block Visibility Groups** select — choose your group (or
"No Block Visibility Group"). The block now inherits that group's conditions and
logic. If the group's *allow other conditions* is off, the block's other
visibility tabs are hidden.

Groups are configuration, so they export with `drush config:export` and deploy
between environments like any other config. For developers, the
`block_visibility_groups.group_evaluator` service can test whether a group's
conditions currently pass in custom code.
