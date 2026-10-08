# Configuration

Bootstrap Layout Builder has three layers of configuration: **turning it on for
an entity**, the **per‑section UI** editors use while building a page, a small
**global settings form**, and the **configuration entities** (breakpoints,
layouts, layout options) that define what column choices exist. This page walks
through all of them.

## 1. Enable BLB layouts on an entity

BLB layouts are ordinary core Layout Builder layouts, so they appear
automatically wherever Layout Builder is enabled — there's no per‑bundle toggle
to switch BLB on specifically.

1. Enable Layout Builder for a view mode at **Structure → Content types →
   *(type)* → Manage display**, under **Layout options**, then **Manage layout**.
2. In the Layout Builder canvas, click **Add section** and pick a **Bootstrap**
   category layout (Bootstrap 1 Cols through 12 Cols).

## 2. The per‑section configuration UI

Selecting or editing a Bootstrap section opens a tabbed form.

### Layout tab

- **Container type** — a radio choice: `container` (boxed, the default),
  `container-fluid` (full width), or edge‑to‑edge (`w-100`).
- **Gutters** — a radio to keep Bootstrap's default gutters or remove them.
- **Breakpoints** — one column‑structure chooser per breakpoint (Mobile, Tablet,
  Desktop by default). This is what makes the row responsive: each breakpoint
  picks a split such as `6 6` (two equal columns) or `3 9` (25/75). The choices
  offered come from the layout options defined for that layout and breakpoint.

### Style tab

Embeds the **Bootstrap Styles** style groups — background color, background
image/video, spacing, and so on — applied to the section's **container wrapper**.
Which style groups appear here can itself be limited (see the styles config
below).

### Settings tab (advanced)

Holds free‑text **CSS classes** and **YAML attributes** for the container
wrapper, the row, and each column region — for adding utility classes like
`py-5 bg-warning` or arbitrary HTML attributes. This tab is hidden if you turn on
**Hide section settings** in the global settings.

## 3. Global settings form

Go to **Configuration → Content → Bootstrap Layout Builder** and open the
**Settings** form (`/admin/config/bootstrap-layout-builder/settings`). The
editable options are:

- **Live preview** *(on by default)* — AJAX‑refresh the Layout Builder canvas as
  you change a section's options, so you see the result immediately.
- **Hide section settings** *(off by default)* — hides the advanced Settings tab
  (classes/attributes) from editors to keep the UI simple.
- **One column layout class** *(default `col-12`)* — the CSS class applied to a
  single‑column section's region.

A companion **Styles** config page (`/admin/config/bootstrap-layout-builder/styles`)
lets you enable or disable which Bootstrap Styles plugins show on the Style tab.
(Background color/image/video option lists are stored in config and can be set
there or via `drush`.)

## 4. Breakpoints, layouts, and layout options

Under **Configuration → Content → Bootstrap Layout Builder** you manage three
kinds of configuration entity. All are gated by the **Configure bootstrap layout
builder** permission and export with `drush config:export`.

- **Breakpoints** (`/admin/config/bootstrap-layout-builder/breakpoints`) — the
  responsive tiers. Each has a **base class** (`col`, `col-md`, `col-lg`) and a
  weight that controls its order in the column chooser. Defaults are Mobile
  (`col`), Tablet (`col-md`), and Desktop (`col-lg`). Add your own, e.g. an XL
  tier.
- **Layouts** (`.../layouts`) — each layout is a **column count** (1–12) and
  becomes one Bootstrap section layout. Add one to offer, say, a six‑column row.
- **Layout options** (`.../layouts/{layout}/options`) — the **column splits**
  offered for a given layout, such as "Two equal columns" (`6 6`) or "25/75"
  (`3 9`). You control which breakpoints each option is allowed and defaulted on,
  and you can add custom splits like `4 4 4` or `2 8 2`.

## Permission

A single permission, **Configure bootstrap layout builder** (a restricted
permission), gates the settings form, the styles form, and all the config‑entity
management pages above.
