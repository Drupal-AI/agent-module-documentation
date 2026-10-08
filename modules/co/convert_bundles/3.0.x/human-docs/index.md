<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convert Bundles — manual setup guide

**Convert Bundles** (`convert_bundles`) changes existing content from one bundle
to another — one content type to another, one vocabulary to another, one media
type or paragraph type to another — and carries the data across by mapping the
source bundle's fields onto the target bundle's fields. It is the no-migration way
to consolidate near-duplicate content types, retire a deprecated type, or move
content into a new information architecture.

It works on any entity type that has two or more bundles: nodes, taxonomy terms,
media, paragraphs, custom blocks, and more. You can convert a single item from a
**Convert Bundle** tab on the entity, convert a selection from the bulk-operations
dropdown on the content list, or convert a whole bundle at once from an admin
form. Because the conversion is exposed as a standard Drupal action, it also works
with Views Bulk Operations (VBO) and Rules.

During a conversion you pick the target bundle, then map each source field to a
compatible target field — or drop it, or append its value to the body. On
revisionable entities it creates a new revision with a "Converted from X to Y" log
message, so history is preserved. Developers can adjust each converted entity just
before it is saved with an alter hook — see the [`agent/`](../agent/start.md) docs.

> **Convert Bundles rewrites entity data directly.** Always back up your database
> before running a conversion, and try it on a copy first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the three ways to run a conversion,
   the field-mapping wizard, and the permissions.

## Where it lives in the admin menu

The whole-bundle conversion form is at **Configuration → Content authoring →
Convert Bundles** (`/admin/config/content/convert_bundles`). Individual entities
also get a **Convert Bundle** tab on their page, and the conversion appears as an
action on the content list at **Content** (`/admin/content`).

## How to use it

There is no set-up to configure — you *run* Convert Bundles rather than configure
it. See [Configuration](configuration/index.md) for the three entry points and the
field-mapping wizard.
