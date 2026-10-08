# Group Storage — manual setup guide

**Group Storage** (`group_storage`) connects two modules so that a group can own
records. On one side, the [Group](https://www.drupal.org/project/group) module
models sets of users with their own membership, roles, and permissions —
departments, teams, courses, clubs — and provides an access system where content
belongs to a group and a group role decides who may do what with it. On the other,
the [Storage Entities](https://www.drupal.org/project/storage) module provides a
lightweight fielded content entity for data that *isn't* a node: no URL, no
publishing workflow, no listing — just a place to hold structured records.

Put them together and a group can own records with access decided by group
membership rather than by site‑wide roles: a department's asset register, a team's
contact list, a course's grades, a club's equipment inventory. That's a genuinely
useful shape, and one people otherwise build by hand with a group reference field
and a custom access hook — which is exactly where mistakes creep in. Group Storage
gives you the wiring already done.

Two things are worth stating plainly. First, **group access here is real access,
not just a display filter** — it participates in Drupal's entity access system, so
it applies to Views, JSON:API, and REST, which is what makes it worth using rather
than a reference field and good intentions. Second, **the group relation is the
security boundary**, so decide up front: who may create storage items in a group,
whether a member of one group could reach another group's items by ID, and what
should happen to a group's items when the group is deleted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Group and Storage Entities.

There is **no central settings page**. You configure Group Storage per group type,
by installing its relation and granting group permissions — described below.

## How to use it

Group Storage lets a Storage entity type be added to a group as a normal group
content type, then access‑controlled with Group's permissions:

1. Make sure Group and Storage Entities are set up, with at least one group type
   and at least one Storage entity type.
2. On the group type, use its **Set available content** operation to install the
   relation for the Storage entity type you want the group to own.
3. Grant the resulting per‑group create/view/update/delete permissions to the
   appropriate group roles, according to your requirements.

From then on, members can create and manage that group's storage records, with
access governed by their group role. Group Storage can also be combined with the
**Subgroup** or **Subgroup (Graph)** modules if you use nested groups.

Match the module version to your Group version: Group Storage 1.x with Group 1,
2.x with Group 2, and this **3.x** release with Group 3.
