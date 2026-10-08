# Group Block — manual setup guide

**Group Block** (`groupblock`) plugs core's custom blocks (`block_content`
entities) into the [Group](https://www.drupal.org/project/group) module as a group
relationship. Out of the box, Group knows about memberships and per‑group content
but not about custom blocks — so this module lets a site say "these custom blocks
belong to this group", with create/view/update/delete governed by the group's
permission system.

It supplies a `group_block` relation plugin (with a deriver that produces one
plugin per custom‑block type), so you choose the specific block bundle to relate.
Once a group type installs that relation, blocks of that bundle can be added to a
group and are subject to the group's permissions. Access to the blocks is delegated
entirely to Group — the module doesn't invent its own access rules.

For convenience it also clones core's group‑relationship add/create pages to
friendly paths, adds a **Blocks** operation link to each group (backed by a shipped
view of the group's blocks), provides group‑scoped block permissions, and can
auto‑attach referenced blocks to a group when the group is created through the
group creation wizard.

This lets group editors manage their own blocks without needing site‑wide block
permissions — handy on multi‑team or affiliate sites where each department owns its
own block content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Group.

There is **no central settings page**. You configure Group Block per group type, by
installing the relation and granting group permissions — described below.

## How to use it

1. Make sure Group is set up with at least one group type, and you have the custom
   block type(s) you want to use. (Views should be enabled for the Blocks overview
   link.)
2. On the group type, use its **Set available content** operation to install the
   **Group block (<block type>)** plugin for the custom‑block bundle you want to
   relate. One plugin is derived per block type, and cardinality is fixed at one
   block per relationship.
3. Grant the group‑scoped block permissions (create / view / update / delete, plus
   the **access group_block overview** permission that lets members see a group's
   block list) to the appropriate group roles.

Once set up, you can add an existing block to a group at `group/{group}/block/add`,
or create a new one directly inside a group at `group/{group}/block/create`. Each
group also gets a **Blocks** operation link to its block overview. If a group is
created through the group creation wizard and has an entity‑reference field pointing
to blocks of an installed relation, those blocks are attached to the group
automatically.

Match the module version to your Group version: Group Block 1.0 with Group 1.6, 2.0
with Group 2.2, and this **3.x** release with Group 3.2.
