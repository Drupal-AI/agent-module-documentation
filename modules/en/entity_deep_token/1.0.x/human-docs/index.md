# Entity Deep Token — manual setup guide

**Entity Deep Token** (`entity_deep_token`) lets tokens reach **deep into an
entity's chain of references**, not just its own fields. Drupal's built‑in token
system only follows one‑level relationships; this module defines a new token type,
`entity_deep_token`, that can hop across multiple entity‑reference fields to pull a
value from a related entity several levels away.

The syntax traverses reference fields using `:entity:` steps and ends with the
property you want. For example, if a *degree* node references a *department*, which
references a *school*:

```
[entity-deep-token:field_department:entity:field_school:entity:id]     → the school node's ID
[entity-deep-token:field_department:entity:field_school:entity:label]  → the school node's title
[entity-deep-token:field_department:entity:field_school:entity:bundle] → the school node's bundle
```

You can also read raw field values, such as a related node's creation timestamp:
`[entity-deep-token:field_related_node:entity:created:value]`. This is handy for
hierarchical breadcrumbs, metadata built from related entities, and custom URL or
conditional logic.

It depends on the **Token** module and works wherever tokens are processed, as long
as there's an entity context (node, user, taxonomy term, and so on). A couple of
current limitations: it reads only the **first value** of a multi‑value reference
field, and it does **not** format raw values (timestamps come through unformatted).

Tokens are resolved wherever they are placed, so choose token placement to match the
output's intended audience, the same as you would for any other token.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the Token
   dependency, and enable the module.

There is **no configuration page** — the module simply makes the
`entity_deep_token` token type available for you to use.

## How to use it

Once enabled, use the token type `entity_deep_token` in any token‑aware place that
has an entity context. Build the token by chaining reference field names with
`:entity:` steps and finishing with the property you want (`id`, `label`, `bundle`,
`value`, `target_id`, and so on), as in the examples above.
