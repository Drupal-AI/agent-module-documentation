# Default Paragraphs — manual setup guide

**Default Paragraphs** (`default_paragraphs`) adds a field widget for
[Paragraphs](https://www.drupal.org/project/paragraphs) fields that
**pre‑populates** one or more paragraphs when a new host entity is created. Instead
of starting from a blank field, editors open the add form and find a ready‑made
content skeleton already in place — for example a hero, a body, and a
call‑to‑action — so every page of a content type starts with a consistent
structure and fewer clicks.

The module extends the standard Paragraphs "stable" widget with a new
**Default paragraphs widget**, which you select on a paragraph field's form
display. Its settings keep all the familiar Paragraphs options (title, closed mode,
autocollapse, add mode, form display mode, features) and add a table listing every
allowed paragraph type with a **Use as Default** checkbox, an **Edit mode**
(Open/Closed) choice, and a drag **weight** for ordering. When someone creates a
new host entity and the field is empty, the widget seeds a paragraph for each
checked type, in weight order. A cardinality check stops you selecting more defaults
than the field allows.

Defaults appear only on **creation** — never when editing existing content, and not
while translating — so existing pages are left untouched. Developers can go further
by subscribing to a `default_paragraphs.added` event to set field values on each
seeded paragraph (or replace it entirely) before it is placed. The module depends
only on the **Paragraphs** module and has no admin routes, permissions, config
schema, Drush commands, or submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the add‑event API —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Paragraphs dependency) and enable the module.

## Where it lives in the admin menu

There is no dedicated settings page. You select and configure the widget on an
entity's **Manage form display** tab (for example **Structure → Content types →
[your type] → Manage form display**).

## How to use it

1. Make sure the bundle has a **Paragraphs** field (an
   `entity_reference_revisions` field targeting paragraph types).
2. Go to **Manage form display** for that bundle and set the field's **Widget** to
   **Default paragraphs widget**.
3. Click the widget's gear icon to open its settings. Alongside the standard
   Paragraphs options you'll find a **Default paragraph types** table. For each type
   you want to seed:
   - Tick **Use as Default**.
   - Choose an **Edit mode** — *Open* (expanded) or *Closed* (collapsed, the
     default) for how the seeded paragraph appears.
   - Drag the **Weight** to set the order the defaults appear in.
4. Save. You can't check more types than the field's cardinality allows — the form
   validates this.

Now, whenever an editor creates a new entity of that bundle, the field starts
pre‑filled with the chosen paragraphs. To also set default *values* inside those
paragraphs, a developer can subscribe to the add event — see the
[`agent/`](../agent/start.md) docs.
