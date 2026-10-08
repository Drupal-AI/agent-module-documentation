# Features Permissions — manual setup guide

**Features Permissions** (`features_permissions`) turns role permissions into
separate, exportable **configuration entities**, so a Feature can carry the
permissions it needs without carrying whole roles.

The problem it solves is subtle but real. In Drupal, permissions are stored on the
role. A Feature that bundles a piece of functionality — a content type, its fields,
its views — also needs the permissions that make it usable, but the only way to
export those is to export the **entire role**, which then overwrites every other
permission that role holds on the target site. So installing a Feature can silently
strip permissions that other Features granted, and two Features that both touch (say)
the editor role cannot coexist. By splitting each permission into its own config
entity, this module makes them **composable**: a Feature carries just the permissions
it is responsible for and leaves the rest alone. The permission entities stay in sync
with roles — update a role and the associated permission entities update; import or
revert a permission entity and the associated roles update.

> **This is security‑relevant configuration.** A permission grant arriving through a
> Feature is a privilege change that can look like a routine deployment. Read the diff
> of one of these entities with the attention you would give a role change, and apply
> the same care to who may commit them — a permission entity that grants something the
> target site's role should not have **will** grant it on import, and config import
> does not ask.

Two things to keep in perspective: the **Features** module is a Drupal 7‑era workflow
that core's configuration management has largely replaced, so this is most relevant to
sites already committed to Features rather than to new builds; and an export is a
snapshot of an intention at one point in time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Features).

There is **no dedicated configuration page** — the module works through the Features
export/import workflow, as described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)); it immediately
   begins keeping permission config entities in sync with your roles.
2. Build your Feature as usual with the **Features** module (**Configuration →
   Development → Features**, `/admin/config/development/features`). The permission
   entities for the roles you care about become available to include in the Feature,
   so you can export only the permissions that Feature is responsible for — without
   dragging along the whole role.
3. Deploy and import the Feature on the target site. The imported permission entities
   update the associated roles, granting exactly those permissions and leaving other
   permissions on those roles untouched.

Review each permission entity's diff as a privilege change before it ships.
