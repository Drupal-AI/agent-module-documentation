# Field Access — manual setup guide

**Field Access** (`field_access`) provides **configurable, per‑field access
control** for entity fields. It lets you decide, field by field, which roles or
permissions may **view** a field's value and which may **edit** it — and it
enforces those rules through Drupal's authoritative field‑access system.

Because it hooks into `hook_entity_field_access` (via an `AccessHandler`), the
restriction is not just cosmetic and not limited to entity forms. It applies
**consistently across the edit form, the rendered display, REST / JSON:API, and
programmatic access** — anywhere the field‑access API is consulted. The handler
returns "forbidden" when a field is denied and stays neutral otherwise, which is
the correct fail‑safe pattern.

One important thing to understand before you start: **this module has no UI.** As
its maintainers put it, "There is currently no UI for site builders or site
administrators." You define access as **PHP permission maps** — arrays, one per
entity type and bundle — rather than clicking through admin forms. A UI "might come
later," but today configuration is a developer task done in code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Access is defined in PHP, as
described in "How it works" and "How to configure access" below.

## How it works

Field Access is deliberately code‑first. Compared with the similar
[Field Permissions](https://www.drupal.org/project/field_permissions) module, it
trades a click‑through UI for an "all permissions of an entity type in a single PHP
file" overview, which is easier to review and keeps your role and field storage
configuration free of extra clutter. Its feature set reflects that developer
focus:

- **View and edit access** controlled independently per field.
- **Base fields and bundle fields** both supported.
- **Per‑bundle permissions** even for fields that share a machine name across
  bundles.
- **Default permissions for all bundles**, with the ability to override them for
  specific bundles.
- **Create vs. update** distinction — you can allow setting a value on a *new*
  entity but forbid changing it later (or vice versa). For example, allow setting a
  comment's subject when it is created but not afterward.
- **Grant by role and/or permission.**
- **Regular‑expression matching** for both roles and fields, so one rule can cover
  many.

Because it uses the authoritative field‑access API, a denied field is hidden or
locked everywhere — including API responses — not merely on the node form. That
makes it a good fit for genuinely sensitive fields, not just tidier forms.

## How to configure access

Configuration happens in code, so this is a developer task:

1. Read the module's **README** — it documents the exact structure of the
   permission‑map arrays and where to place them. (The project points to the
   README for usage instructions.)
2. Define a **permission map per entity type and bundle**: for each field, state
   which roles/permissions may view and which may edit, using the create‑vs‑update
   distinction and regex matching where useful.
3. Set **default permissions** for all bundles where that is simpler, and override
   only the bundles that differ.
4. Clear the cache (`drush cr`) and test as users with the relevant roles to
   confirm the field is hidden/locked where intended — including via any REST or
   JSON:API endpoints you expose.

> **Note:** This module is not covered by Drupal's security advisory policy
> (`security_advisory_coverage: not-covered`). Because it gates access to field
> data, test your permission maps carefully before relying on them in production.
