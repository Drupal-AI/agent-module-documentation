# Commerce License OG Role — manual setup guide

**Commerce License OG Role** (`commerce_license_og_role`) adds a Commerce License
type that, while the license is active, **grants the purchaser a role inside an
Organic Groups (OG) group**. In other words, it turns a product purchase into
timed group membership with a specific role — a clean way to model "join this group
(or upgrade your role in it) by buying a product," with access that automatically
ends when the license expires.

Each license product is configured to grant **one OG role in one specific group**,
both chosen on the product variation. When a license of this type becomes active,
the module creates or updates the buyer's OG membership and assigns the configured
role; when the license expires or is revoked, that membership/role is removed. It
implements OG's existing‑rights checking (so you don't sell someone access they
already have) and locks the referenced group/role while a license is active (so it
can't be pulled out from under a live subscription). It depends on **Organic
Groups** (`og`), **Commerce License** (`commerce_license`), and **Dynamic Entity
Reference** (`dynamic_entity_reference`).

Two **restricted permissions** govern who may set up these grants — because letting
a license hand out group roles is a sensitive capability. There's a global
**`grant group roles with licenses in any group`** permission (which bypasses
per‑group control and should be granted very sparingly, to trusted store admins
only), and a per‑group OG permission, **`grant group roles with licenses`**
(registered via an OG permissions event subscriber, defaulting to group
administrators), that lets group admins allow this only within their own group.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its OG / Commerce License dependencies.
2. [Configuration](configuration/index.md) — set up a license product that grants a
   group role, and assign the two permissions correctly.

## Where it lives in the admin menu

The module adds no standalone settings page. You configure it in two familiar
places: on a Commerce **product variation** that has a license field (under
**Commerce → Products**), where you pick the group and role a license grants; and on
**People → Permissions** (plus each group's own OG permissions), where you control
who may create license‑driven role grants.
