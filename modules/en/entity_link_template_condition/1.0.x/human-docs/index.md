# Entity Link Template Condition — manual setup guide

**Entity Link Template Condition** (`entity_link_template_condition`) adds a
Drupal **condition plugin** that evaluates to TRUE when the page you're on
corresponds to one of an entity's *link templates* — its canonical (view) page,
its `edit-form`, its `delete-form`, and so on. Conditions are the visibility
building blocks Drupal uses in places like a block's **Visibility** tab, so this
lets you show or hide things based purely on "what kind of entity route am I
currently on?".

It offers two ways to match. In **any entity type** mode you match a link-template
key — say `canonical` — no matter which entity type it belongs to, so a block
appears on the view page of *every* entity. In **exact entity type** mode you
match a specific pair such as `node:canonical` or `taxonomy_term:edit-form`, so a
block appears only on node view pages, or only on taxonomy term edit forms. If
you configure neither, the condition simply returns FALSE.

Under the hood it leans on the **Entity Route Context** module to map the current
route back to an entity-type / link-template pair, which is why that module is a
required dependency. The condition has no admin page, permission, or service of
its own — all of its settings live inside whatever host UI embeds it (most
commonly a block's Visibility tab), and it has no effect on access beyond where an
administrator chooses to place it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Entity
   Route Context dependency, then enable it.

There is **no configuration page** for this module. You configure the condition
in place, inside the host UI that uses it — see "How to use it" below.

## Where it lives in the admin menu

Entity Link Template Condition adds no menu item. It surfaces as a condition
option wherever Drupal shows conditions — most visibly on **Structure → Block
layout → *(place or configure a block)* → Visibility** tab.

## How to use it

1. Place or edit a block at **Structure → Block layout**.
2. Open the block's **Visibility** tab and find the **Entity link template**
   condition.
3. Choose your match: a link-template key (like `canonical` or `edit-form`) for
   **any entity type**, or an exact `entity_type:key` pair (like `node:canonical`)
   for a single entity type.
4. Optionally tick **Negate the condition** to *hide* the block on those routes
   instead of showing it.
5. Save the block. It now appears (or hides) only on the matching entity routes.
