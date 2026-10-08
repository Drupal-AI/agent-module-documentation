# Views field formatter — manual setup guide

**Views field formatter** (`views_field_formatter`) adds a field formatter called
**View** that, instead of printing a field's own value, renders a View you choose
in that field's place — passing the field's value (and the host entity's id) into
the View as contextual arguments. It is the no‑code way to say "when you display
this field, show the results of this View, filtered by this field."

That opens up a lot of common patterns without writing any code: a "more like
this" list keyed off the current node's field, a taxonomy‑term reference that
displays the content in that term, a user's authored content driven by the user
id, "products in this category" from a category field, upcoming events filtered by
a date field, and so on. Because the field's value is handed to the View as a
contextual argument, the embedded View reacts to whatever entity is being viewed.

The formatter is available on almost every field type — strings, entity
references, list fields, numbers, dates, links, images, and more. All of its
options live in the field's formatter settings on the display, so the whole setup
exports and imports as display config, and the formatter records a config
dependency on the View you pick. There is no settings page, permission, or Drush
command; it depends only on core's Views module.

This guide is written for a **human** using the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated admin page. You use the formatter on each entity's **Manage
display** page (for example **Structure → Content types → Article → Manage
display**), where you set a field's format to **View**.

## How to use it

1. Go to the bundle's **Manage display** page and pick the view mode you want.
2. Change the field's **Format** to **View** and click the gear/cog to open its
   settings.
3. Configure the formatter:
   - **View** — choose the View and display to embed, in the form
     `view_id::display_id` (for example `frontpage::page_1`).
   - **Arguments** — tick which contextual arguments to send to the View and set
     their order (for example the field's delta, the field value, the entity id).
   - **Hide empty** — render nothing when the embedded View returns no results.
   - **Multiple** — for multi‑value fields, render the View once per value
     instead of once overall.
   - **Implode character** — when *Multiple* is on, the character used to join the
     per‑value outputs.
4. Click **Update**, then **Save**.

You can set a different View per view mode by configuring the formatter
separately on each display, so, for example, a teaser and a full page can embed
different Views for the same field.
