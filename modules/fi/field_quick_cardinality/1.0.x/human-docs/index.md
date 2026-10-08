# Field Quick Cardinality — manual setup guide

**Field Quick Cardinality** (`field_quick_cardinality`) adds a small but genuinely
handy piece of information to the **Manage fields** overview page: each field's
**cardinality** — how many values it is allowed to store (one, a fixed number, or
unlimited). Normally you'd have to open a field's settings screen to see this;
Field Quick Cardinality surfaces it right on the field list, so you can review a
bundle's whole content model at a glance.

It's especially useful when a bundle has many fields and you need to know which ones
accept a single value and which accept several — for example when building an
importer, or when documenting a data model. The module simply reads and displays the
existing cardinality setting; it doesn't change any field configuration or data, and
it has no effect on how content is rendered on the front end.

It integrates with core's **Field UI** and supports Drupal 9, 10, and 11. This is a
rewrite of the earlier "Field Quick Required" module, applying the same idea to
cardinality.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. Once
enabled, the cardinality simply appears on the field overview page.

## Where it lives in the admin menu

Field Quick Cardinality adds no admin page of its own. The extra information shows up
directly on each bundle's **Structure → Content types (or any entity bundle) →
*(bundle)* → Manage fields** overview.

## How to use it

There's nothing to set up beyond enabling the module. Visit any bundle's **Manage
fields** page and you'll see each field's allowed number of values listed alongside
the field — 1 for single-value fields, the specific number for fixed-cardinality
fields, and "unlimited" for those that accept any number of values.
