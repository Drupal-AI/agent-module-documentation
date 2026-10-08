# Computed relationships — manual setup guide

**Computed relationships** (`computed_relationships`) lets you define
relationships between content entities using **computed reference fields** —
fields whose target entities are a **fixed, hand-picked set you choose once
centrally** (by selecting specific entities), resolved at runtime rather than
stored as reference values you maintain per entity. Imagine you need a set of
related entities attached whenever any node of a content type is requested:
normally you would add an entity_reference field with default values and hope they
stay in sync. With Computed relationships you declare the relationship once —
choosing the source entity/bundle, the target entity/bundle, and the specific
target entities — and the field is created and populated automatically. **JSON:API is
supported**, and if `jsonapi_extras` is present its configuration for these
computed fields is set up automatically when the relevant configuration already
exists.

Each relationship is defined by selecting a **source** entity/bundle, a **target**
entity/bundle, and the **specific target entities** to attach. The computed field
is then added to the source entity type automatically. Once the module is active,
you simply start defining the relationships you want represented alongside each
entity. It depends on core's **Field** module, provides its own permission, and
supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no traditional settings form** to fill in first — after enabling, you
define computed relationships directly and then choose the bundles they apply to,
as described under "How to use it" below.

## Where it lives in the admin menu

Computed relationships adds no standalone settings page of its own. After
enabling it, you define the relationships between entities (source entity/bundle,
target entity/bundle, and the specific target entities); the computed field is then
created automatically on the source entity type. Manage relationships at
**Content → Computed relationships** (`/admin/content/computed-relationship`).
Grant the module's permission at **People → Permissions** to the roles that should
manage relationships.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. **Define a relationship** at **Content → Computed relationships → Add**: pick
   the **source** entity/bundle, the **target** entity/bundle, and the **specific
   target entities** to attach (optionally set a label and field machine name).
3. Save. The computed reference field is added to the **source entity type**.
4. The reference field is populated automatically at runtime; if you
   use JSON:API (optionally with `jsonapi_extras`), the relationship is exposed
   there as well.
