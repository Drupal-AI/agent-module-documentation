# Field Usage Display — manual setup guide

**Field Usage Display** (`field_usage_display`) adds an **"Also used in" column** to
the Field UI's **Manage fields** table, right where administrators are already
working. Drupal fields are reusable — the same field storage (say, `body`) can be
attached to several bundles — and before you edit or delete a field you need to
know where else it lives. Core's global field report at `/admin/reports/fields`
tells you, but only as a separate site‑wide table you have to scan. This module
brings that context onto the Manage fields page itself.

The new column is blank for fields used only in the current bundle (no noise) and
lists the human‑readable labels of the other bundles that share a field. It works
across all fieldable entity types — content types, media types, taxonomy
vocabularies, block types, user accounts, and any other type that uses Field UI —
and, when the `ctools_entity_mask` submodule is present, it also surfaces
cross‑entity‑type borrowed fields (with the entity type shown in parentheses).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **nothing to configure**. The module adds no pages, routes, or
permissions — the "Also used in" column simply appears automatically once the
module is enabled.

## How to use it

Enable the module, then go to any **Manage fields** screen (**Structure → Content
types → *(type)* → Manage fields**, or the equivalent for media types,
vocabularies, and so on). The **"Also used in"** column shows, for each shared
field, the other bundles that use it — so you can see the impact before editing or
deleting a field.
