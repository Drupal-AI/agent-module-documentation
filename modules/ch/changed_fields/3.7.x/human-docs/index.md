# Changed Fields API — manual setup guide

**Changed Fields API** (`changed_fields`) is a developer library, not a
point‑and‑click feature. It answers one question reliably: *which fields on an
entity actually changed when it was saved?* When you enable it on its own,
nothing visible happens — it exists for other code (yours or another module's) to
consume.

Under the hood it uses the classic observer pattern. Your code registers an
*observer* against an `EntitySubject`, and when the entity is updated the module
hands your observer a structured diff of exactly what changed — instead of you
poking at `$entity->original` and comparing values by hand. That matters because
naive `->value` comparison is wrong for multivalue fields, entity references, and
multi‑column field types such as dates with timezones. To handle that correctly,
comparison logic is pluggable through a **`FieldComparator`** plugin type, so the
right comparison strategy can be applied per field type. All Drupal core field
types are supported on Drupal 8/9/10/11 (note the module reports the legacy
version string `8.x-3.7`).

Typical uses include avoiding false‑positive deployment/sync requests (a node was
saved but nothing really changed), modifying an entity based on which fields
changed, or simply knowing what changed before save. The best way to learn the
API is to read the two bundled example submodules — see the *Submodules* note on
the [Installation](installation/index.md) page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   turn on the example submodules to learn the API.

There is **no configuration page** for this module — it has no settings form, no
routes, and no permissions. It is code that other code calls.

## Where it lives in the admin menu

Changed Fields API adds nothing to the admin menu. It is consumed
programmatically. For working examples, enable the demo submodules described in
Installation and read their source.

## How to use it (for developers)

At a high level: register an observer against an `EntitySubject`, and receive a
structured diff of the changed fields when the entity is saved. Comparison logic
per field type is provided by `FieldComparator` plugins, which you can extend for
custom field types. The two example submodules —
`changed_fields_basic_usage` and `changed_fields_extended_field_comparator` —
are the real documentation; enable them on a development site and read their code
to see the pattern in practice.
