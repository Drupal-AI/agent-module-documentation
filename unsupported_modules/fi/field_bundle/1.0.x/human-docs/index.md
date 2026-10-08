# Field Bundle — manual setup guide

**Field Bundle** (`field_bundle`) gives you a generic, "un‑opinionated" **content
entity type** whose bundles you define yourself. It is a neutral container for
arbitrary sets of fields — useful when you need reusable structured data that is
**not** a node, a taxonomy term, or a paragraph, but you still want the full stack:
**revisions, translations, and a proper access‑control / permission model**.

Bundles are defined as `field_bundle_config` configuration entities, and you add
fields to them with the standard Field UI, exactly as you would for a content type.
Because Field Bundle entities are first‑class, they can be referenced from other
entities, translated, revised, and permission‑gated per operation.

> **Before you adopt it:** development of this module has been **discontinued**,
> and its maintainers recommend using
> [Storage Entities](https://www.drupal.org/project/storage) instead. It also
> targets **Drupal 9.2 or 10** (not 11). For a new build, prefer the successor;
> this guide is for understanding and maintaining existing sites that already use
> it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its optional submodules.
2. [Configuration](configuration/index.md) — create bundle types, add fields, and
   set permissions.

## Where it lives in the admin menu

You manage bundle types at **`/admin/structure/field-bundle`** (config route
`entity.field_bundle_config.collection`). From there you create bundles, add fields
to each via the Field UI, and then create Field Bundle content entities from the
overview.

## How to use it

Think of Field Bundle as a lightweight way to model a custom data type without
writing a custom entity module:

- Model arbitrary structured data as its own entity type, kept cleanly separate
  from nodes.
- Create multiple bundles, each with its own set of fields.
- Get full **revision history** (with revert / delete‑revision UI) and
  **translation** support.
- Enforce **granular create / view / update / delete permissions**, including "own"
  vs "any" and access to unpublished items.
- Reference Field Bundle entities from other entities, and use tokens for their
  values.

Optional submodules extend it further — see [Installation](installation/index.md).
