# Entity Reference UUID — manual setup guide

**Entity Reference UUID** (`entity_reference_uuid`) provides a field type that
references an entity by its **UUID** instead of its numeric entity ID. It is a
tool for content **portability** — moving, deploying, and migrating content between
environments without references breaking.

The reasoning: numeric entity IDs are *local*. Node 42 on production and node 42 on
staging are different nodes, and the number carries no meaning between
installations. That is fine while everything stays in one database, but it becomes
a real problem the moment content moves — a migration renumbers everything, a
content deployment carries an entity whose references point at IDs that mean
something else on the target, a default‑content export references nodes that do not
exist yet, or a multisite arrangement shares content with no stable way to name
anything. UUIDs solve this because they are generated once and travel *with* the
entity: the same content has the same UUID everywhere it exists, so a reference by
UUID survives being moved.

Three things are worth knowing. **UUID lookups cost more than ID lookups** — a UUID
is a 36‑character string rather than an indexed integer, so resolving a reference
per row in a large listing is measurably slower; that is the trade you make for
portability. **The target may not exist yet**, which is the whole point during a
deployment, so rendering has to tolerate an unresolvable reference rather than
error out. And **core already uses UUIDs for exactly this** in `default_content`
and in config‑entity dependencies, so the pattern is established rather than novel —
this module simply makes it available to ordinary content fields. It is in the
Field types package, has no third‑party dependencies, and requires **Drupal 11.1
or later** (a deliberately tight requirement).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. You add its field type to a bundle through the standard Field UI, described
in "How to use it" below.

## Where it lives in the admin menu

Entity Reference UUID adds no admin settings page. You use it from **Structure →
Content types (or any fieldable entity) → *(bundle)* → Manage fields**.

## How to use it

1. Go to **Structure → Content types → *(bundle)* → Manage fields** and click
   **Add field**.
2. Choose the **Entity Reference UUID** field type and give the field a label.
3. Configure the field's target entity type/bundle as you would a normal
   entity-reference field, then save.
4. The reference is now stored by the target's UUID, so it stays valid when the
   content is migrated, deployed, or exported to another environment.
