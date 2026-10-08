# Entity Reference Link — manual setup guide

**Entity Reference Link** (`entity_reference_link`) is a field formatter that gives
entity-reference fields a flexible "custom link" display. Sometimes you have a
reference field but you do not want to render the referenced entity as a teaser or
even link straight to it — you want to build a *different* link that uses the
referenced entity's ID. Maybe you want to link to another page passing the entity
ID as a route parameter, link to a View using the ID as a filter query parameter,
or prepopulate a form value from the ID. All of those normally need custom code
with Drupal's `Url` and `Link` classes; this module lets you handle those
link-generating cases straight from the field's display settings.

It works the moment you enable it — there is no settings page. Once enabled, every
entity-reference field gains an **"Entity Reference Custom Link"** format option on
the entity's *Manage display* screen, where you configure the link you want. The
module depends only on core's **Field** module and runs on Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
set it up entirely on a field's *Manage display*, described in "How to use it"
below.

## Where it lives in the admin menu

Entity Reference Link adds no admin page of its own. You use it from **Structure →
Content types (or any fieldable entity) → *(bundle)* → Manage display**.

## How to use it

1. Go to the *Manage display* page for an entity bundle that has an
   entity-reference field (for example **Structure → Content types → Article →
   Manage display**).
2. Find your entity-reference field and change its **Format** to **Entity
   Reference Custom Link**.
3. Click the gear/settings icon for that format and fill in the link options —
   pointing the link at a route or a View and using the referenced entity's ID as
   the parameter or query argument you need.
4. Click **Update**, then **Save** the display.

The link respects the referenced entity's access: a link to content the current
user cannot view still leads to an access‑denied page, so the formatter does not
itself bypass access control.
