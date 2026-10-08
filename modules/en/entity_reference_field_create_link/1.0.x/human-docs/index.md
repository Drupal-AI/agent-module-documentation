# Entity Reference Field Create Link — manual setup guide

**Entity Reference Field Create Link** (`entity_reference_field_create_link`)
adds a widget for entity-reference fields that extends the standard autocomplete
widget with a link to the *creation* page for the kind of entity the field
references. When the item an editor wants doesn't exist yet, they can jump
straight to creating it instead of abandoning the form to make it first.

The problem it solves is the ordering trap of reference fields: you can only
reference something that already exists, so an editor who needs a new term,
page, or media item has to break off, create it elsewhere, and come back. A
"create new" link beside the field turns that into one step and keeps authoring
moving.

It currently supports **node**, **taxonomy term**, and **media** reference
fields, and it depends on Drupal core's Field module. Creating the referenced
entity still goes through that entity type's own create access, so the link only
appears as a convenience — it grants nothing and has no access-control role of
its own. There is no global configuration; you enable it per field on *Manage
form display*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
Setup happens on your reference field's form display, described in "How to use
it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types (or
other bundles) → *(bundle)* → Manage form display**, by choosing the module's
create-link widget for a node, taxonomy term, or media reference field.

## How to use it

1. Go to the host bundle's **Manage form display** and find your node, term, or
   media reference field.
2. Change its **Widget** to the create-link autocomplete widget this module
   provides and **Save**.
3. On the entity edit form, the field now shows a link to the creation page for
   the referenced entity type — follow it to create a new entity you can then
   reference, subject to that entity type's own create permission.
