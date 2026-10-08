# Entity Reference Preview — manual setup guide

**Entity Reference Preview** (`entity_reference_preview`) fixes a gap in Drupal's
content‑moderation preview. When you view the **latest (draft) revision** of an
entity — say a node on its `.../latest` tab — its *referenced* entities normally
still render their **published** revision. So a coordinated set of draft changes
spread across referenced content is not fully visible in preview. This module makes
embedded entity references resolve to their **latest revision** while you preview
the latest revision of the parent, so editors see the whole composition in its
draft state.

It is a slim, focused alternative to Entity Reference Revisions when all you need
is preview: Entity Reference Revisions creates many extra database rows and can slow
a site down, whereas this module only changes *which revision is shown at preview
time*. It ships four capabilities: (1) a **new entity-reference formatter** that
enables preview on a field; (2) a **toolbar item and block with a button** to
manually start and stop preview mode on pages that have no "Latest" tab; (3) an
**opt‑in for Views**, so listings can preview the latest versions of the entities
they render; and (4) an optional **"unpublished draft" indicator** (a small blue
dot) on referenced entities that have a publishable draft, shown to users with the
right permission.

Importantly, the module changes which *revision* is displayed — it does **not**
change access. Referenced entities are still shown respecting the viewer's access.
It provides its own settings form and permissions, has no third‑party
dependencies, and runs on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form and permissions,
   plus enabling the formatter, toolbar/block, and Views preview.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at **Configuration → Content
authoring → Entity Reference Preview**
(`/admin/config/content/entity-reference-preview`). The preview formatter itself is
chosen per field on each bundle's **Manage display**.
