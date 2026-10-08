# Config Role Split — manual setup guide

**Config Role Split** (`config_role_split`) is a deployment tool for teams that
manage their site with configuration export/import. It solves a specific
frustration: you granted a role an extra permission on one environment — say the
`administrator` role has `access devel information` on staging but must never have
it on production — and every config import overwrites it. Role permissions are
"all or nothing" in exported config, so environment‑specific tweaks keep getting
clobbered.

This module lets you keep chosen role permissions **out of** (or merged **into**)
your exported configuration, so those specific permissions can be managed
per‑environment instead of being flattened on every deploy. It works as a **Config
Filter** plugin, which means it has **no effect on a running site** — it only acts
during `drush config:export` / `drush config:import` (or any config sync),
rewriting the affected `user.role.*` entries as they pass through.

You configure it with **Role Split** entities. Each one lists a set of roles and,
for each role, the specific permissions the filter should manage — plus a **mode**
that decides what "manage" means:

- **Split** — strip the managed permissions from exported config (they live only in
  the split) and merge them back on import.
- **Fork** — like split, but additive: on export it won't remove permissions that
  are already in the shared config directory.
- **Exclude** — a blocklist: remove the managed permissions on import so they never
  reach active config.

The filter also keeps each role's config *dependencies* correct as permissions are
added or removed. It requires the **Config Filter** module and is a natural
companion to Config Split.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Config Filter)
   with Composer and enable it.
2. [Configuration](configuration/index.md) — creating Role Split entities, the
   fields on each, choosing a mode, and how to see the effect.

## Where it lives in the admin menu

The admin screen sits under configuration management at **Configuration →
Development → Configuration synchronization → Config Role Split**
(`/admin/config/development/configuration/config-role-split`). Reaching it requires
the restricted **Administer config role split** permission.
