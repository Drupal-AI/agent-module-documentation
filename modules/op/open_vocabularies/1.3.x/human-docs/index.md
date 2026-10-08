# Open Vocabularies — manual setup guide

**Open Vocabularies** (`open_vocabularies`) lets editors choose *how* a piece of
content is categorised without having to change the field configuration on each
content type. Instead of hard‑wiring a taxonomy reference into every bundle, it
gives you an "open vocabulary" field type and lets you build reusable
**associations** between that field and Drupal's categorisation systems — core
taxonomies, Publication Office vocabularies, or subsets of them. Once a content
type carries an open vocabulary field, users with the right permission decide
which type of entities that field can reference by creating an association.

The practical payoff is a more flexible content model: the same field can be
pointed at different reference targets over time, and associations can be reused
across bundles, so you adjust categorisation as an editorial decision rather than
a structural change. It's part of the OpenEuropa family of modules and provides
its own permissions.

A note on access: associations reference other entities, and those entities' own
access rules still apply — Open Vocabularies adds no access‑control role beyond
its own permission. It's a content‑modelling tool, not a security boundary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no single settings page** for this module — you work with it by adding
open vocabulary fields to your content types and creating associations, described
below.

## How to use it

1. Add an **open vocabulary** field to a content type (or other fieldable entity)
   at **Structure → Content types → *(type)* → Manage fields**.
2. Create an **association** that binds that field to a categorisation source (for
   example a taxonomy vocabulary, or a subset of one), choosing which entity type
   the field may reference.
3. Grant the relevant Open Vocabularies permission to the roles that should manage
   associations, at **People → Permissions**.

From then on, editors categorise content through the open vocabulary field, and
you can adjust the association without touching each bundle's field definition.
