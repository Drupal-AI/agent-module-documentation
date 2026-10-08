# Chaos Tools (CTools) — manual setup guide

**Chaos Tools** (`ctools`) is a developer toolkit rather than an end-user feature.
It ships a collection of reusable building blocks — multi-step form wizards, plugin
context and relationships, a serializable tempstore, and improved display and
block handling — that *other* modules build on top of. If you have ever installed
Panels or Page Manager, you have installed CTools, because they depend on it.

The problem it solves is repetition: rather than every module reinventing things
like a multi-step configuration wizard or a way to derive one context from another
(say, a node's author), CTools provides those APIs once, in a stable, shared form.
Its headline feature is the **Form Wizard**, which stitches a series of forms into
a single flow with automatic tempstore-backed state and step navigation. It also
defines a **Relationship** plugin type, typed-data context helpers, a serializable
tempstore factory, and block-based page display variants.

Because CTools is infrastructure, most site builders never interact with it
directly and it has **no admin configuration screen** and no permissions of its
own. You typically install it only because another module requires it — and once
enabled, it simply works. It depends only on Drupal core.

CTools ships three optional submodules you can enable if a task calls for them:
**CTools Block** (`ctools_block`) adds an "entity field" block that renders any
single field of an entity; **CTools Entity Mask** (`ctools_entity_mask`) lets a
custom entity type borrow another type's fields and display; and **CTools Views**
(`ctools_views`) exposes a Views display as a configurable block with row and
offset overrides.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.

## How to use it

There is nothing to configure and no settings page to visit — CTools is a set of
APIs and plugins consumed programmatically by other modules. What you get from it
depends on which submodules you enable and which modules require it:

- **As a dependency.** Modules such as Panels, Page Manager, and various Views
  bulk-operation tools list CTools as a requirement. Enabling those pulls CTools in
  automatically, and you never touch it directly.

- **CTools Block** (`ctools_block`) — once enabled, adds an **Entity Field** block
  in the block library (for example on the Block Layout page or in Layout Builder)
  that renders a single field of a chosen entity.

- **CTools Views** (`ctools_views`) — once enabled, when you add a **Block** display
  to a View you gain extra block settings, such as overriding the number of items,
  the offset, and the pager per placed block.

- **CTools Entity Mask** (`ctools_entity_mask`) — a developer tool that lets a
  custom entity type reuse another type's field configuration and display; it has
  no click-through UI of its own.

Everything else CTools offers — the Form Wizard, relationship plugins, the
serializable tempstore, display variants — is for developers writing code. Those
APIs are documented in the sibling [`agent/`](../agent/start.md) docs.
