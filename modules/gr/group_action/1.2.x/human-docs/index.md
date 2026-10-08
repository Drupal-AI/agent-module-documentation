# Group Actions — manual setup guide

**Group Actions** (`group_action`) adds a set of configurable Drupal **Action** plugins that
work with the [Group](https://www.drupal.org/project/group) module. They let you **add**
content or users to a group, **remove** them, or **update** the group relationship — and
because they are standard actions, they show up wherever actions are used, most usefully in
**Views Bulk Operations (VBO)** views and in **ECA** automation models.

There are six actions in two families: three for **content** (add / remove / update group
content, typically nodes) and three for **membership** (add / remove / update group members,
i.e. users). Each one is configurable: you tell it which group to target (by numeric ID or
UUID, and tokens are supported so you can resolve the group dynamically), optionally which
entity to operate on, any relationship field values to set, and — when adding — how to handle
an item that's already in the group.

Group Actions works transparently across Group **v1, v2, and v3**: it detects which version's
services are present and calls the right API under the hood, so the same action configuration
keeps working as you upgrade Group. Crucially, it does **not** bypass Group's access rules —
each action's access check delegates to the group's own create/update/delete relationship
permissions, so a user can only run an action where they'd be allowed to make that change
anyway. It has no settings page and no permissions of its own; it depends on the **Group**
module.

This guide is written for a **human** building VBO views or ECA models through the admin UI.
If you want terse, token‑cheap references for an AI coding agent — including the plugin ids and
execute flow — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the six actions and every option on their
   configuration form.

## Where it lives in the admin menu

There is no dedicated settings page. The actions appear where actions are consumed — when you
add a bulk operation to a **VBO** view, or when you add an **action** step in an **ECA** model.
You configure each action right there, at the point of use.
