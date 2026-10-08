# Component Fields — manual setup guide

**Component Fields** (`component_fields`) automatically calculates the value of a
"final" field from the values of two other "component" fields of the same type.
The final value can be a copy of one component, a concatenation or merge of both,
a "use A, fall back to B" choice, or anything else you can express as a compiler
plugin. The result is a single, usable field whose value is assembled from parts
you store separately — computed on save, not typed in.

The point is to let different groups of users (or automated processes like
imports) each own their own component field, while everyone else sees one clean
final value. A classic example: an import writes to `field_imported`, your
moderation team can override it in `field_override`, and `field_final` shows the
override when present and the imported value otherwise — so the next import never
wipes out a human's correction. It ships several ready-made compilers (Component
1, Component 2, either-with-fallback, Merge for multivalue fields, and an
explicit-empty option) and a plugin type so developers can add their own.

Two things to keep in mind. **The module provides no visibility or access
control** for either the final field or the component fields — that is left
entirely to your field settings and permissions, set up separately. Final fields
are calculated on a pre-save hook, so they are not meant to be written by anyone
directly. It depends only on Drupal core and provides its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the bundles, define your
   field groups and their compilers, and optionally turn on per-entity
   overrides.

## Where it lives in the admin menu

Component Fields' settings live under **Configuration**, at
`/admin/config/component-fields/settings`, with two related pages: the field
groups page (`/admin/config/component-fields/settings/fields`) and the overrides
page (`/admin/config/component-fields/settings/overrides`). See
[Configuration](configuration/index.md) for a walkthrough of all three.
