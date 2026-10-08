# Group Scheduled Transitions — manual setup guide

**Group Scheduled Transitions** (`group_scheduled_transitions`) bridges the
[Group](https://www.drupal.org/project/group) module and the
[Scheduled Transitions](https://www.drupal.org/project/scheduled_transitions)
module. It lets group members schedule future content‑moderation state changes —
such as auto‑publishing or auto‑unpublishing — on the content that belongs to
their group, with who's allowed to do so governed by group permissions.

On its own, Scheduled Transitions lets editors queue up moderation changes for
later. This module makes that capability available *per group*: it adds **view
scheduled transitions** and **add scheduled transitions** permissions to your
group types, so certain group roles can schedule transitions on their group's
content while others can't.

It is an editorial‑workflow integration and has no access‑control role of its own —
it simply exposes the scheduling capability to group roles. Grant the two group
permissions appropriately and the rest of the behaviour comes from Scheduled
Transitions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Group and Scheduled Transitions.

There is **no central settings page**. Configuration is a matter of granting the
two group permissions the module adds, described below.

## How to use it

1. Enable Group, Scheduled Transitions, and this module (see Installation). The
   maintainers also strongly recommend installing the
   **Group Content Moderation** module alongside it.
2. Go to the **permissions** page of each group type where you want scheduling.
3. Grant the new **view scheduled transitions** and **add scheduled transitions**
   permissions to the group roles that should be able to schedule content changes.

Group members holding those permissions can then schedule moderation state changes
(for example, publish an article next Monday) on their group's content, using
Scheduled Transitions' normal interface.
