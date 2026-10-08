# Group Features — manual setup guide

**Group Features** (`group_features`) lets administrators enable and disable
optional **feature sets on a per‑group basis** for a group type. A group feature is
a bundle of permissions that are granted only when the feature is switched on for a
given group, so you can package a use‑case — "news", "let users join" — as a
feature and toggle it per group rather than modelling every combination as a
separate group type. It builds on the
[Group](https://www.drupal.org/project/group) module and the
[Flexible Permissions](https://www.drupal.org/project/flexible_permissions) system.

Without this module, offering different capabilities to different groups usually
means creating additional group types with different configuration. Group Features
lets you instead bundle the needed permissions into a *group feature* and flip it
on or off per individual group, based on a flag on the single group entity.

Administration is gated by the module's own **Administer group_feature**
permission, and the granted feature permissions layer onto Group's normal access
model.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group and Flexible Permissions.

There is **no single global settings form** for this module (`configure` is null).
Features are managed per group type from the group type's own Features screen,
described under "How to use it" below.

## Where it lives in the admin menu

Feature management for a group type lives at its **Features** tab —
`/admin/group/types/manage/{group_type}/features` (under **Groups → Group types →
*(group type)* → Features**). Grant the **Administer group_feature** permission at
**People → Permissions**.

## How to use it

1. Enable the module alongside Group and Flexible Permissions.
2. Define the **features** for a group type — each feature bundles the set of
   permissions it should grant.
3. Open a group type's **Features** screen at
   `/admin/group/types/manage/{group_type}/features` to manage its available
   features.
4. On a per‑group basis, enable or disable the features you want for that group.
   The feature's permissions are granted to that group only while the feature is
   switched on.
