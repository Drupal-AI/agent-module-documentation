# Configuration

Layout Components has no single settings page. Instead, you configure it **while you
build**, inside the Layout Builder editor: each section, each column, and each
component you add has its own set of options, all with a live preview so you can see
changes as you make them. This page walks through what you can set at each level.

## Section options

When you add or configure a section, Layout Components extends the standard section
form with a large set of controls, including:

- **Columns** — a dynamic column selector and column changer, and a Bootstrap
  column‑size selector (`sm`, `md`, `lg`).
- **Section type** and **sizing** — full width, container, or title container.
- **Background** — a background image and a background color.
- **Height** — a height type and size (dynamic or custom).
- **Padding** — top and bottom padding.
- **Title** — a title with its own description, color and opacity, type, alignment,
  size, spacing, and border (color, opacity, size, type).
- **Custom classes** and **custom attributes** for the section.

## Column options

Within a section, each column also carries its own options:

- **Column title** — type, color, size, alignment, and border.
- **Column border** — type, size, color, and radius.
- **Column background color**.
- **Column paddings**.
- **Column classes**.

You can also nest **sub‑sections inside columns**, letting you build structures
within structures.

## Component options

Each component you drop into a column has its own configuration form appropriate to
what it does — for example an accordion's panels, a card's content, a countdown's
target date, a video or iframe's source, a button's label and link, and so on. The
Slick and view‑carousel integrations add their own selectors for choosing a view or
carousel behavior. As with sections and columns, changes preview live in the
builder.

## Global and extra settings

- **Global section/column configuration** lets you set defaults that apply across
  your layouts rather than repeating the same choices on every section.
- The **LC Commands** submodule (`lc_commands`) adds the ability to **import and
  export blocks** in displays, which is useful for moving component setups between
  environments.

## Saving

All of these options are part of the layout itself. Configure them in the section,
column, or component forms, then **save the layout** in the Layout Builder editor.
Because the settings live in the layout/section storage, they travel with the
layout — including through a configuration export for default layouts.
