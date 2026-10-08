# Boolean Advanced Formatter — manual setup guide

**Boolean Advanced Formatter** (`boolean_advanced_formatter`) is a field
formatter for Boolean fields that can render **only one** of the two states. For
example, it can output a label or piece of markup when the value is *true* and
show nothing when it is *false* (or the other way around). That makes it handy
for badges, flags, and conditional labels driven by a Boolean field, where you
only want something to appear in one case.

It is a focused display enhancement: it provides a field‑formatter plugin, adds
no routes, permissions, or front‑end libraries, and depends only on core's
**Field** module. You configure it entirely within the Field UI's *Manage
display* screen — there is no separate settings page. It targets Drupal 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings form of its own. You select and configure the formatter at
**Structure → Content types → (a type) → Manage display**
(`/admin/structure/types`), on any Boolean field.

## How to use it

1. On an entity that has a Boolean field, go to its **Manage display** tab.
2. For that Boolean field, choose the **Boolean Advanced** formatter.
3. Use the formatter's settings (the gear icon) to pick **which state to
   display** (true or false) and the **label/markup** to show for it. The
   opposite state is suppressed entirely — nothing is output for it.
4. Save. The field now renders your label/markup only in the chosen state,
   perfect for a badge or conditional flag.
