# Configuration

Getting Layout Paragraphs running is a four‑step setup. You'll usually already have a
Paragraphs field on a content type; the steps below teach that field the builder
experience and turn one paragraph type into a "section."

## 1. Turn a paragraph type into a layout "section"

Layouts come from core **Layout Discovery**. A paragraph type becomes a section by
enabling its **Layout Paragraphs** *behavior* plugin. Go to **Structure → Paragraphs
types**, edit (or create) a paragraph type meant to hold layouts, and in its
**Behaviors** enable **Layout Paragraphs**. The behavior's settings offer:

- **Available layouts** — checkboxes of the layout plugins (one‑column, two‑column,
  three‑column, etc.) that this section type is allowed to use. Pick at least one.

When an editor adds a section paragraph, they choose one of these layouts and then
drop other paragraphs into its regions.

## 2. Add the builder widget to your Paragraphs field

On the content type that holds your Paragraphs field, go to **Manage form display**
and set that field's widget to **Layout Paragraphs**. Open the widget's settings (the
gear icon) to adjust:

- **View mode** — the view mode used when rendering components.
- **Preview view mode** — the view mode used for previews inside the builder.
- **Form display mode** — the form mode used when editing a component.
- **Maximum nesting depth** — how many levels sections may nest (0 means no nesting).
- **Require layouts** — when on, every top‑level component must be placed inside a
  section rather than sitting loose.
- **Empty message** — placeholder text shown when the field has no components yet.

## 3. Choose how it renders on the front end

On **Manage display**, set the field's formatter to one of:

- **Layout Paragraphs** (`layout_paragraphs`) — renders the paragraphs wrapped in their
  chosen layouts. This is the normal, read‑only front‑end display. Its settings include
  the view mode and an optional link.
- **Layout Paragraphs Builder** (`layout_paragraphs_builder`) — an **experimental**
  in‑place (front‑end) editing display. It carries the same preview/form‑mode/nesting/
  require‑layouts/empty‑message settings as the widget.

## 4. Module‑wide settings (optional)

Under **Configuration → Content authoring → Layout Paragraphs** (each form needs the
**Administer site configuration** permission):

- **Label settings** (`/admin/config/content/layout_paragraphs/labels`) — whether to
  **show paragraph‑type labels** and **show layout labels** in the builder, plus the
  label and position of the "Behaviors" section on component forms, and a default empty
  message. These are off by default, giving a cleaner builder; turn them on if editors
  find the extra labeling helpful.
- **Section settings** (`/admin/config/content/layout_paragraphs/sections`) —
  section‑related labels.
- **Modal settings** (`/admin/config/content/layout_paragraphs/modal-settings`) — the
  builder's dialog **width** (default `90%`), **height** (default `auto`), and whether
  it **auto‑resizes**.

All of these are stored as configuration objects and export with `drush config:export`.

## Using the builder

With the pieces in place, edit a piece of content: the Paragraphs field now shows the
drag‑and‑drop builder. Editors click to add a component (choosing from the "Choose a
component" dialog), drag components between regions and sections, duplicate them, and
reorder them — all with live previews. The in‑progress layout is held in a private
tempstore until the content is saved.
