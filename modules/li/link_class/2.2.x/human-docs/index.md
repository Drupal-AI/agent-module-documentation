# Link Class — manual setup guide

**Link Class** (`link_class`) adds a field widget called **Link with class** for core **Link**
fields, letting editors attach one or more CSS classes to each link they enter. Core's Link
field stores a URL and link text but gives editors no way to add a class — so styling a link
as a button, for instance, normally means custom theming. Link Class solves that by dropping a
class control right beneath each link on the edit form, and writing the chosen class onto the
link's attributes so it appears on the rendered `<a>` tag with no special formatter needed.

The widget offers three modes, which you pick per field on **Manage form display**:

- **Manual** — editors type free‑form classes into a text box (best for power users).
- **Select** — editors choose from a curated dropdown of styles you define as a `key|label`
  list (best for keeping editors on an approved set, e.g. "Primary button", "Secondary
  button").
- **Force** — a fixed class is applied automatically to every link, with no editor input (best
  for making, say, all links in a call‑to‑action field render as `btn btn-cta`).

Everything is configured in the field's widget settings — there is **no global settings page,
no permissions, and no Drush commands**. It depends only on core's **Link** module. It's a
small, focused tool for giving editors controlled styling of individual links.

This guide is written for a **human** setting the widget up in the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

Link Class adds **no page of its own**. You switch a Link field to the **Link with class**
widget and configure its mode on the entity's form display — for a content type, that's
**Structure → Content types → *your type* → Manage form display**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Add a core **Link** field to an entity bundle (content type, paragraph type, etc.), or use
   an existing one. This module works only on `link` fields.
3. Go to that bundle's **Manage form display** and, for the Link field, change the **Widget**
   to **Link with class**.
4. Click the gear/cog to open the widget settings and pick the **Method for adding class**:
   - **Manual** *(default)* — editors get a free‑text **Link classes** box and type any
     classes, separated by spaces.
   - **Select a style** — editors get a dropdown (with a "None" option). Fill in the **class
     options** as one `key|label` per line, for example:

     ```
     btn btn-default|Default button
     btn btn-primary|Primary button
     ```

     The part before the `|` is the class(es) applied to the link (multiple classes separated
     by a space); the part after is the label editors see. Omit `|label` and the key doubles
     as the label.
   - **Force** — enter a single class string (e.g. `btn btn-cta`) that is applied to **every**
     link in the field automatically; editors see no class control.
5. Save.

Whichever mode you use, the chosen class is written into the link's attributes, so core's Link
formatter renders it straight onto the `<a>` tag — no change to your **Manage display**
formatter is required. You can configure a different mode and class list on each Link field,
and reuse the same list across several fields by configuring each one.
