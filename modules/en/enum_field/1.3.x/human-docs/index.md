# Enum Field — manual setup guide

**Enum Field** (`enum_field`) lets you create List fields whose allowed values
come from a **PHP enum** in code, instead of from a list typed into the field
settings form. The option set then lives where the rest of your domain logic
lives — in version‑controlled code — and cannot drift from it.

With core's Options module, a site builder types `draft|Draft`, `review|In
review` into a textarea, and any code that later branches on those values has to
hard‑code the same strings, with nothing enforcing the match. Enum Field replaces
the source of truth: point the field at a backed PHP enum, and the enum's cases
*become* the allowed values. Adding a case adds an option; renaming one is a
refactor your IDE can perform safely. The real payoff is on the reading side —
the field exposes the **enum instance**, not the raw scalar, so application code
receives a typed enum case it can `match` on with static analysis behind it:

```php
$entity->get('field_some_enum')->enum      // the enum case for a single value
$entity->get('field_some_enum')->enums()   // the enum cases for a multi-value field
```

This is deliberately a **developer's field type**: because the options come from
code, they are *not* editable through the field settings UI. If a site builder
needs to add options without a deploy, this is the wrong field type. The module
also provides a migration helper and Drush commands to convert an existing
`list_string` / `list_integer` field onto an enum. It requires **PHP 8.1** (enums
do not exist earlier) and core's Options module; it has no routes, permissions,
or config forms of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — there is no settings form.
The setup happens when you add a field, described in "How to use it" below.

## Where it lives in the admin menu

Enum Field adds no admin page. You use it from **Structure → *(entity type)* →
*(bundle)* → Manage fields**, where its two field types appear in the *Add field*
list.

## How to use it

1. Define a **backed** PHP enum in your own module, for example
   `enum Status: string { case Draft = 'draft'; case Review = 'review'; }`. The
   enum must be backed (`: string` or `: int`) for the stored value to round‑trip.
2. On a bundle, go to **Manage fields → Add field** and choose **Enum (text)** or
   **Enum (integer)** to match your enum's backing type.
3. In the field settings, set the **enum class** the field should reference. The
   enum's cases become the field's allowed values.
4. Use the field like any other list field — placing its widget on Manage form
   display and its formatter on Manage display. In custom code, read the typed
   case with `->enum` (or `->enums()` for multi‑value fields).

> **Migrating an existing list field?** Enum Field ships a migration helper and
> Drush commands specifically for converting an existing `list_string` /
> `list_integer` field onto an enum — use those rather than hand‑writing a
> migration.
