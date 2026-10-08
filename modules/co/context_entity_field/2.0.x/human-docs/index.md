# Context Entity Field — manual setup guide

**Context Entity Field** (`context_entity_field`) adds one new condition to the
[Context](https://www.drupal.org/project/context) module: an **Entity Field**
condition. With it, a context can switch on or off depending on the state of a
field on the entity you are currently viewing — whether that field is *filled*,
*empty*, or holds a *specific value*. That lets you drive Context reactions
(showing a block, swapping a region, changing a breadcrumb, and so on) from your
content's own field data, without writing any custom code.

The typical use is a rule like "show this call‑to‑action block only when the
node's *Sponsored* field is set" or "activate this context when a taxonomy
term's field equals a particular option." Because the condition is derived once
per entity type that has bundles, you get an Entity Field condition for nodes,
taxonomy terms, media, users, and any other bundled content entity — each one
scoped to that entity type. The module deliberately keeps this condition inside
Context only: it is hidden from the core Block UI and Layout Builder condition
lists so it does not clutter them.

There is nothing to configure globally. The module depends on the contrib
**Context** module, adds no settings page, no permissions, and no Drush
commands — it simply makes the new condition available the moment you enable it.
You then use it from inside any context you build in the Context UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Context.

## Where it lives in the admin menu

The module adds no menu items and no settings page of its own. Everything happens
inside the **Context** UI at **Structure → Context**
(`/admin/structure/context`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)); Context is
   required and will be enabled with it.
2. Go to **Structure → Context** and edit or add a context.
3. Under **Conditions**, add the **Entity Field** condition for the entity type
   you care about (for example the node condition, labelled *"Content field"*).
4. Choose the **field** to inspect from the list of that entity type's fields.
5. Pick a **field state**:
   - **Filled** — the condition is true when the field has a value.
   - **Empty** — true when the field has no value.
   - **Value is** — true when the field equals the text you type in. Matching is
     exact (case‑sensitive), and if the field has multiple values, any one item
     matching is enough.
6. Configure the context's **Reactions** as usual (which block to show, region to
   set, and so on), then save.

When you view an entity of that type, the context evaluates the field and runs
its reactions only when your chosen condition is met. If the entity is missing,
the field does not exist, or (for *Filled* / *Value is*) the field is empty, the
condition is simply false.
