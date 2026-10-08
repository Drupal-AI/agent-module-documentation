# Domain Access Entity — manual setup guide

**Domain Access Entity** (`domain_entity`) extends the Domain module's
per-domain access model beyond nodes to **any fieldable entity type**. The Domain
project, through its `domain_access` submodule, already lets you restrict *nodes*
to particular affiliate domains on a multi-domain Drupal install. This module
generalises that idea so you can do the same for taxonomy terms, media, users,
custom entities, and more: each entity becomes visible only on the domain(s) it
is affiliated with.

It works by adding a `domain_access` reference field to the entity types you turn
on, and then filtering access and entity queries at runtime so content stays
scoped to the right domain. You enable domain-awareness per entity type from an
admin form, and for each bundle you choose how affiliation is assigned —
**automatically** to the current domain when an entity is created, or **manually**
by the editor through a widget on the edit form. An entity with no domain
assignment is treated as available on all domains.

The module also brings per-domain permissions (so a delegated editor can manage
content only on their assigned domains), a global switch to bypass the access
filtering while troubleshooting, and an optional "domain source" feature that
rewrites an entity's outbound links to its canonical domain. A bundled submodule,
**Domain Menu Access**, applies the same per-domain treatment to menu links.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it (the Domain module is required), and the optional submodule.
2. [Configuration](configuration/index.md) — enabling domain access per entity
   type, choosing the per-bundle behavior, permissions, and the bypass switch.

## Where it lives in the admin menu

The main form is at **Configuration → Domain → Domain entities**
(`/admin/config/domain/entities`), which requires the **Administer domains**
permission. Each enabled entity type gets its own per-bundle settings page at
`/admin/config/domain/entities/{entity_type_id}`.

## How to use it

Enable the module, open the Domain entities form, tick the entity types that
should become domain-aware, and save. Then, on each enabled type's settings page,
choose per bundle whether affiliation is assigned automatically or by the editor.
After that, content is filtered by domain automatically. The full walkthrough is
in [Configuration](configuration/index.md).
