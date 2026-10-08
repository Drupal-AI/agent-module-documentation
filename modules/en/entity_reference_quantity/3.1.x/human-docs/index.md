# Entity Reference Quantity — manual setup guide

**Entity Reference Quantity** (`entity_reference_quantity`) is an entity-reference field type
that stores an integer **quantity** alongside each referenced entity. It behaves exactly like
a normal reference field — you pick the target entity type, bundles and selection handler the
same way — but each reference also carries a count. That makes it a lightweight way to model
"N of this item" without reaching for Commerce: bills of materials, parts lists, recipe
ingredient amounts, seat/headcounts against events, and so on.

The field builds directly on core's entity reference, so everything you already know still
applies. On top of that it adds a quantity input to the widget, a couple of bounds you can
set, and a display formatter that renders the quantity next to the referenced entity's title
(for example "Widget (3)"). Two widgets ship: an **autocomplete + number** widget (the
default) and a **select-list + number** widget for a fixed set of referenceable entities.

There is no admin settings page and no permissions — configuration is entirely per field and
per form/display, in the usual field UI.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

Add a field of type **Entity reference w/quantity** (`entity_reference_quantity`) to a
content type or other fieldable entity, then configure it in the three usual places:

**1. Storage / field settings.** Choose the **target type**, **target bundles** and
**selection handler** exactly as you would for a core entity-reference field — these are
inherited. Entity Reference Quantity adds three extra settings:

| Setting | Default | Meaning |
|---|---|---|
| **Quantity label** (`qty_label`) | `Quantity` | The label (and, in multi-value fields, the placeholder) for the quantity input. |
| **Minimum quantity** (`qty_min`) | `0` | The lowest value the quantity input allows. |
| **Maximum quantity** (`qty_max`) | `999` | The highest value the quantity input allows. |

**2. Manage form display — pick a widget.**

| Widget | What editors get |
|---|---|
| **Autocomplete + quantity** (`entity_reference_quantity_autocomplete`, default) | An entity autocomplete field plus a number input for the quantity. |
| **Select + quantity** (`entity_reference_quantity_select`) | An inline select list of referenceable entities plus a number input (default value 1). |

Each row (delta) of a multi-value field gets its own quantity, so you can reference several
entities and give each a different count.

**3. Manage display — the label formatter.** Use the **Rendered label with quantity**
formatter (`entity_reference_quantity_label`). It extends core's entity-reference label
formatter and has two settings:

- **Location** (`location`, default *suffix*) — where the quantity appears relative to the
  title: `pre-title`, `post-title`, `suffix`, or `attribute` (rendered into a data attribute
  for your theme/JS to pick up rather than shown as text).
- **Template** (`template`, default `` ` ({{ quantity }})` ``) — a small Twig snippet, with the
  `quantity` variable available, that produces the quantity markup. Change it to control the
  exact output, e.g. `× {{ quantity }}`.

You also keep core's inherited **link** option (whether the label links to the referenced
entity).

That's the whole setup — no separate configuration page is involved.
