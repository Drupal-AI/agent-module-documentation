# Entity Value Inheritance — manual setup guide

**Entity Value Inheritance** (`entity_value_inheritance`, sometimes shortened to
EVI) keeps a field value **in sync between a source entity and the entities that
reference it**. You define a "source" — an entity type, bundle, and field — and a
"destination" — another entity type, bundle, and field — linked by an entity
reference field on the destination that points back at the source. From then on,
the destination's field reflects the source's value automatically.

The classic use is shared data you would otherwise have to copy by hand: a
product's price stored once on the product and inherited by every order line that
references it, or a campaign setting defined once and pushed down to related
content. When the source changes, the destinations follow.

*How* they follow is up to you, through a pluggable **field strategy** chosen per
mapping: **update** keeps the destination continuously synced, **overwrite**
replaces the destination value unconditionally, **override** lets the destination
keep a local value, **override by role visibility** makes that override
role-aware, and **disable** shows the inherited value but locks the field on the
destination's edit form. The engine runs on entity save, load, and form build,
and fires events so other modules can react to or alter a sync.

All administration sits behind the single **`administer inheritance`**
permission, and the module depends on the core **Action** module and the contrib
**Entity API** (`entity`) module. Keep the `administer inheritance` permission
admin-only. There is also a current limitation: the linking reference field must
be a single-value reference field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — creating an Inheritance mapping
   field by field, and the strategies you can pick.

## Where it lives in the admin menu

- **Inheritance mappings** — **Structure → Inheritance**
  (`/admin/structure/inheritance`), where you add and manage mappings.
- **Global settings** — **Structure → Inheritance → Settings**
  (`/admin/structure/inheritance/settings`, the `inheritance.settings` route).

Both require the **Administer inheritance** permission.
