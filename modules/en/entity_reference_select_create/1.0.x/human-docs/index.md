# Entity Reference Select Create — manual setup guide

**Entity Reference Select Create** (`entity_reference_select_create`) provides an
entity-reference field widget rendered as a **select list** with a **modal
"Create" button** next to it, so editors can add a new referenced entity inline
without leaving the form they are filling in.

It solves an everyday authoring annoyance: when an editor needs to reference an
entity that does not exist yet, the standard workflow forces them to leave the
form, create the entity, then come back and try again — often losing work along the
way. With this widget, the editor clicks **Create**, fills out a form in a modal,
saves, and the new entity appears in the select list instantly, with no page
reload. It works with any entity type and bundle (nodes, taxonomy terms, custom
entities, and so on), lets you control exactly which fields appear in the modal by
pointing it at a dedicated form display, and offers a configurable button label.

It is purely a field widget with no access role of its own — creating an entity
still respects the user's create permission for that entity type. It has no contrib
or third‑party dependencies and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. Setup happens entirely in the widget settings on a field's *Manage form
display*, described in "How to use it" below.

## Where it lives in the admin menu

Entity Reference Select Create adds no admin settings page. You use it from
**Structure → Content types (or any fieldable entity) → *(bundle)* → Manage form
display**.

## How to use it

1. Go to the **Manage form display** page of an entity that has an
   entity-reference field (for example **Structure → Content types → Article →
   Manage form display**).
2. Change that field's widget to **Select list with create button**.
3. Open the widget settings (the gear icon) and set the **bundle to create**, the
   **form mode** used in the modal, and the **button label**.
4. Click **Update**, then **Save** the form display.

To control precisely which fields appear in the modal, first create a dedicated
**form display mode** for the referenced entity type at **Structure → *(entity
type)* → Manage form display** (add a new form mode), then enter that mode's
machine name in the widget's **Form mode** setting.
