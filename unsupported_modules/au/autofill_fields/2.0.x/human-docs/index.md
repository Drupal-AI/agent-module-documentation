# Autofill Fields — manual setup guide

**Autofill Fields** (`autofill_fields`) automatically populates one field on a
content form from the value of another field on the same form. The classic example
is deriving a URL slug from a title, but the idea applies to any pair of fields
where one value can sensibly be copied or derived from another — the goal is simply
to save editors from retyping information they've already entered.

It is a content‑editing convenience that affects how forms behave. The values it
produces go through Drupal's normal field handling, and the module plays no part in
access control — it does not add permissions and has no security role. You set up
which field fills which through the module's autofill rules on the form
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [How to use it](#how-to-use-it) — set up an autofill rule.

## Where it lives in the admin menu

The module has no global settings page of its own. Autofill rules are attached to
the fields of a content type through its form configuration
(**Structure → (your entity type) → Manage form display**), where you tell a
target field which other field it should be filled from.

## How to use it

1. Make sure the bundle you want to edit has both a **source** field (the one that
   already holds a value, such as Title) and a **target** field (the one to fill).
2. Configure the target field so that it is auto‑filled from the source field, then
   save.
3. On the entity's edit form, entering or changing the source field's value
   automatically populates the target field. The filled value is a normal field
   value that you can still edit by hand before saving.
