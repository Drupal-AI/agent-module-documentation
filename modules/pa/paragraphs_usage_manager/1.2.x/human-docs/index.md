# Paragraphs Usage Manager — manual setup guide

**Paragraphs Usage Manager** (`paragraphs_usage_manager`) gives site builders a
centralized way to control **where each paragraph type is allowed** across your
site. Out of the box, Drupal and Paragraphs let you choose the allowed paragraph
types on each field one field at a time — which becomes tedious and error‑prone on
large sites with many content types, custom entities, or nested paragraphs. This
module replaces that field‑by‑field editing with a single place to manage the
relationships.

It adds two ways to work. A dedicated **Manage usage** tab on each paragraph type
lets you decide, for that one type, which parent fields it may be used in. A
**global overview matrix** lets you manage every paragraph type across every
detected parent field from one screen. Behind the scenes it automatically
discovers all the `entity_reference_revisions` fields that target paragraphs,
works with any supported fieldable content entity (including custom entities), and
supports nested paragraphs where a paragraph is itself a parent.

Importantly, it keeps Drupal's **native field configuration as the single source
of truth**: it applies differential updates (only the relevant paragraph bundle is
added or removed, other allowed bundles are preserved), supports both the include
and exclude selection‑handler modes, keeps `target_bundles_drag_drop` in sync, and
safely reports fields using custom or unsupported handlers as read‑only rather
than overwriting them. It does **not** create any new content type, field type, or
text format. It depends on the Paragraphs module and defines its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant its permission.
2. [Configuration](configuration/index.md) — choose the entity types to scan and
   manage paragraph usage per type or across the global matrix.

## Where it lives in the admin menu

The main settings screen sits at **Configuration → Content authoring →
Paragraphs Usage Manager**. From there (and from each paragraph type's **Manage
usage** tab) you control where paragraph types are allowed. Access requires the
**administer paragraphs usage manager** permission.
