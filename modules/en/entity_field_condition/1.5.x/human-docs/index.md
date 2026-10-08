# Entity Field Condition — manual setup guide

**Entity Field Condition** (`entity_field_condition`) adds a reusable
*condition* to Drupal that checks whether the node you're currently on has a
particular field, and whether that field's value is empty, exactly matches, or
contains a given string. Conditions like this are what Drupal uses to decide
whether to show something — most commonly, **whether a block is visible** — so
this module lets you make block placement react to the content of a node's
fields without writing any code.

Concretely it ships one condition plugin called **`node_field`**. When you place
a block, you get an extra visibility tab where you choose a content type (or "Any
bundle"), pick one of that bundle's fields, choose how to compare it (**Is NULL**,
**Specified** for an exact match, or **Contains** for a substring/pattern), and
type the value to compare against. The block then shows or hides based on the
field's value on the node being viewed. As with any condition, you can flip the
result with the block's built-in **Negate the condition** toggle.

Because it hooks into Drupal's standard condition and context system, the same
condition works anywhere conditions are evaluated, and its settings are stored
inside the host — for a block, that's the block's own configuration. There is no
central settings page for the module, no permissions, and no Drush commands: you
configure it right where you place a block. It depends only on core's **Node**
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Entity Field Condition adds no menu items and has no settings screen of its own.
You use it inside the block layout UI at **Structure → Block layout**
(`/admin/structure/block`) — when you place or configure a block, the condition
appears among the block's visibility settings.

## How to use it

1. Go to **Structure → Block layout** and either place a new block or configure
   an existing one.
2. In the block's configuration, open the **Visibility** settings. Alongside the
   core conditions (Content types, Pages, Roles) you'll find a tab for the
   **node field** condition.
3. **Pick a content type** — choose a specific bundle, or leave it on **Any
   bundle** to match across all node types.
4. **Pick a field.** After you choose the content type, the field list loads the
   fields available on that bundle. Select the one you want to test (for example
   a boolean "featured" flag, a taxonomy reference, a link field, or the body).
5. **Choose a Value Source:**
   - **Is NULL** — the condition is true when the field is empty. (The value box
     is ignored.)
   - **Specified** — true when the field's value exactly equals what you type.
   - **Contains** — true when the field's value contains what you type. Note
     that this is evaluated as a pattern match, so if you mean a literal string
     with slashes or regex characters in it, escape them.
6. **Enter the value** to compare against (for Specified and Contains).
7. Optionally tick **Negate the condition** to invert the whole test, and save
   the block.

A few practical examples:

- Show a promo block only on articles whose "featured" flag is set.
- Hide a call-to-action block on nodes whose category reference matches a
  particular term.
- Show a banner only when a link field's URL contains a specific domain, or when
  the body contains a campaign keyword.

For reference fields the condition compares the referenced ID; for link fields
it compares the URI; for everything else it compares the stored value. On
multi-value fields it checks each value and matches if any one of them matches.
