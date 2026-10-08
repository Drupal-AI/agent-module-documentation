# Group Clone — manual setup guide

**Group Clone** (`group_clone`) lets you duplicate a
[Group](https://www.drupal.org/project/group) — copying the group entity along
with its content and any referenced entities — so you can spin up a new group from
an existing one used as a template. It builds on the Group module and, like the
other Group 3.x add‑ons, works with Group 3.x.

Once cloning is enabled for a group type, every group of that type gains a
**Clone** tab. Cloning a group creates a fresh copy of it and, according to the
per‑content‑type behaviour you configure, its content and relationships. The
operation can also be **reverted** from the Clone tab afterwards, which deletes
the entities that were created by the clone without touching the source group.

> **Cloning is a privileged action.** It creates group content and can copy
> membership and relationships, and the cloned content inherits the source's
> data. Grant the cloning permission only to trusted roles, and review what gets
> copied — especially any sensitive group content — before relying on it. Group
> Clone layers on top of Group's own access model; it does not replace it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group.
2. [Configuration](configuration/index.md) — enable cloning per group type and set
   the default cloning behaviour for each group content type.

## Where it lives in the admin menu

Group Clone's settings live under Group's own administration at **Groups →
Settings → Cloning settings**. Once you enable cloning for a group type there, a
**Clone** tab appears on every group of that type. This module's permission is
managed at **People → Permissions** alongside Group's other permissions.
