# Cards — manual setup guide

**Cards** (`cards`) provides field types, widgets, and formatters that turn entities
— most commonly block content — into styled **card** components, without
hand-writing markup for each entity. It builds on the idea of a compound field (an
entity reference plus a view mode) and takes it further: it lets an end user apply a
range of modifier CSS classes to the rendered entity — color, height, icon, width
and so on — giving finer control over how a card looks without needing a brand-new
view mode for every variation.

The module ships two field types. A **Cards** field (`card_field_type`) marks an
entity as a card, wrapping its rendered output in a container and giving it its own
widget, formatter, and themed markup. A **Cards Children** field
(`card_children_field_type`) references other entities to render as **nested child
cards**, so you can compose cards into groups, rows, and grids. The view mode used
for those referenced children comes from the module's dependency,
**Entity Reference view mode** (`entityreference_view_mode`). Behind the scenes,
Cards adds a dedicated `card` cache context so that cached output stays correct
across different card variations, and provides templates you can override to control
the markup.

There are no routes, no permissions, and no admin settings page — Cards is purely a
field and display provider. You set it up entirely on your entity's *Manage form
display* and *Manage display* pages.

One housekeeping note: this project is **not covered by Drupal's security advisory
policy**. That does not mean it is insecure, but it does mean security issues are not
handled through the official security team process — worth weighing for a
production site, and a reason to keep the module up to date yourself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Entity Reference view mode.

There is no configuration page — the setup happens on your entity's field displays,
described in "How to use it" below.

## Where it lives in the admin menu

Cards adds no admin page. You use it from **Structure → Block types** (or any other
fieldable entity type) **→ *(bundle)* → Manage fields / Manage form display / Manage
display**.

## How to use it

1. **Make an entity a card.** On a bundle (commonly a **block content** type), add a
   field of type **Cards** (`card_field_type`). On **Manage form display**, use the
   card widget; on **Manage display**, use the card formatter. When such an entity is
   rendered, Cards wraps it in a container and adds the `card` cache context
   automatically.
2. **Add nested child cards (optional).** Add a field of type **Cards Children**
   (`card_children_field_type`) that references the entities you want to appear as
   sub-cards. Its widget and formatter render the referenced entities as nested
   cards, using the view mode chosen through the Entity Reference view mode
   integration.
3. **Place and theme.** Combine cards with Layout Builder or blocks to place them on
   pages, and override the module's templates (in its `templates/` directory) if you
   want to customize the card markup.
