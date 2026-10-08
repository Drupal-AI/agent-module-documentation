# Entity Reference Modal — manual setup guide

**Entity Reference Modal** (`entity_reference_modal`) adds a widget for
entity-reference fields that lets editors **search for and reference existing
entities, or create brand‑new ones in a modal window** — all without leaving the
form they are filling in. It is a maintained, Drupal 10+ successor to the older
"Entity Reference Modal Create" project, with most of its bugs fixed.

The problem it solves is a familiar authoring frustration: the standard
autocomplete assumes the entity you want to reference already exists. When it does
not — a new author, a new organisation, a new tag — the editor has to abandon the
form, go create the target, and come back, often losing work. This module puts an
**"Add new"** button next to a quick‑search/autocomplete field; clicking it opens
the referenced entity's form in a modal, and on save the new entity is referenced
straight away. It offers full support for **form modes**, so you control exactly
which fields appear in the modal, and it **checks that the current user actually
has permission** to create the entity.

A few practical notes from the module's own documentation: the quick‑search lists
all matching entities and is not tuned for very large result sets (if your field
uses a View, show all rows rather than paginating); the modal is styled for a
**Bootstrap 5** theme, and for non‑Bootstrap admin themes there is a "Load
Bootstrap" option that pulls Bootstrap 5 from a CDN, or you can supply your own
CSS. It depends only on core's **Field** module and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. Everything is configured in the widget settings on a field's *Manage form
display*, described in "How to use it" below.

## Where it lives in the admin menu

Entity Reference Modal adds no admin settings page. You use it from **Structure →
Content types (or any fieldable entity) → *(bundle)* → Manage form display**.

## How to use it

1. Go to the **Manage form display** page of an entity that has an
   entity-reference field (for example **Structure → Content types → Article →
   Manage form display**).
2. Change that field's widget to **Autocomplete (add new with Modal)**.
3. Open the widget settings (the gear icon) and fine‑tune the behaviour: whether
   editors may add new entities, the bundle to create, the **form mode** used in
   the modal, the "Add" button label (HTML is supported), the modal width and
   title, and — if your admin theme is not Bootstrap 5 — the "Load Bootstrap"
   option.
4. Click **Update**, then **Save** the form display.

When editing content, editors can now search the field or click **Add new** to
create a referenced entity in a modal. Creation still respects the user's
permission to create that entity type.
