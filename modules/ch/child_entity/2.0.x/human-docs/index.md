# Child Entity — manual setup guide

**Child Entity** (`child_entity`) is a **developer module**. It provides the trait,
route providers, list builder, form, and access-control scaffolding you need when
you're building a custom content entity type that can only exist as the child of a
parent entity. The classic example is a *Room* that belongs to a *House*: a room
is always in exactly one house, and it never makes sense on its own. Child Entity
gives your child entity type a parent reference, parent-aware routes and URLs, and
access checks that follow the parent — the same pattern core uses for its
`EntityOwnerTrait`, but for a parent/child relationship.

Because it's a toolkit for code, there is **nothing to click** and **no settings
page**. You use it by implementing `ChildEntityInterface`, using `ChildEntityTrait`,
declaring a `parent` key in your entity's `entity_keys`, wiring up the module's
handlers (route provider, access control, list builder, form) in your entity
annotation, and adding `childBaseFieldDefinitions()` to your base fields. Version 2
switched from base classes you extend to a trait you use, so your child entity can
extend an existing class (for example `Node`) while still gaining the parent
behavior. The module does define permissions, which your entity's access handler
uses. Its one dependency is the contrib **Entity API** (`entity`) module.

If you are not writing a custom entity type in PHP, this module is not something
you install on its own — it's a building block for other modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — the agent docs include the code
snippets (trait usage, handler wiring, revision handling) you'll actually need.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module so its classes and permissions are available to your code.

There is **no configuration page** for this module. It is used from code, not from
the admin UI.

## How to use it

At a high level, to make a content entity a child of another entity you:

1. Implement `ChildEntityInterface` (or extend a class that does) and `use
   ChildEntityTrait` on your entity class.
2. In the entity annotation, declare the parent in `entity_keys` (for example
   `"parent" = "house"`) and point the entity's `handlers` at the module's route
   provider, access control handler, list builder, and form.
3. Add `static::childBaseFieldDefinitions($entity_type)` to your entity's
   `baseFieldDefinitions()` so the parent reference field exists.
4. If your entity is also revisionable, alias the trait's `urlRouteParameters()`
   as shown in the agent docs so revision routes resolve correctly.

The [`agent/`](../agent/start.md) docs and the project page carry the exact code.
