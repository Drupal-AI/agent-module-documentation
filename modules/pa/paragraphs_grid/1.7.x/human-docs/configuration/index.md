# Configuration

Setting up Paragraphs Grid has two parts: choosing the **grid system** on the global
settings form, and adding the **Paragraphs grid field** to a paragraph type so
editors can lay out their content.

## Global settings form

1. Log in as a trusted administrator with the **Use Paragraphs Grid config form**
   permission (this permission is restricted because switching grid systems can
   change stored classes).
2. Go to **Configuration → Content authoring → Paragraphs Grid**, or navigate
   directly to `/admin/config/content/paragraphs_grid`.

The settings are stored in `paragraphs_grid.settings`. The fields are:

- **Grid type** (`gridtype`) — the active grid system that defines the breakpoints
  and CSS classes. Choose one of the shipped presets: **Bootstrap 3**, **Bootstrap
  4** (the default), **Bootstrap 5**, or **Material Design Components (MDC)** — or a
  custom grid system you have defined (see below).
- **Use library** (`uselibrary`) — on by default. When on, the module attaches its
  own grid CSS for the chosen framework on the front end. Turn it **off** if your
  theme already provides Bootstrap/grid CSS and you want the module to emit only the
  classes.
- **Use library on admin pages** (`use_lib_admin_pages`) — off by default. Turn it on
  to also load the grid CSS on admin/edit pages, so the editing preview matches the
  front‑end layout.

Save the form.

## The grid systems (grid entities)

Each grid framework is a `grid_entity` configuration entity (prefixed
`paragraphs_grid.grid_entity.*`). A grid entity describes:

- **Breakpoints** — xs / sm / md / lg / xl / xxl, each with a column count, name,
  icon, and the class fragment it uses (for example `-md`).
- **Wrapper** — the container (container / container‑fluid / none) and row options.
- **Cell properties** — the class patterns for **columns** (`col%bp-%cols`, plus
  extras like auto/full/hide), **offsets** (`offset%bp-%cols`), and **order**
  (`order%bp-%cols`, plus first/last).
- **Library** — the CSS asset library to load for the system.

To add a **custom** grid framework, create a new
`paragraphs_grid.grid_entity.<id>.yml` mirroring one of the presets — adjust the
class fragments, the cell‑property formatters, and the library — then select it as
the **Grid type** on the settings form.

## Add the grid field to a paragraph type

With a grid system chosen, add the field so editors can use it:

1. Go to the paragraph type's (or its host entity's) **Manage fields** and add a
   field of type **Paragraphs grid** (`grid_field_type`). This field stores each
   paragraph's per‑breakpoint column/offset/order selection.
2. Under **Manage form display**, set that field's widget to **Grid widget** — the
   interactive per‑breakpoint column picker editors use.
3. Under **Manage display**, set the display:
   - Use the **Grid field formatter** to output the grid classes for the grid field
     itself, and/or
   - On the entity‑reference field that holds the paragraphs, use **Paragraphs Grid
     (rendered entity)** so each referenced paragraph is rendered inside the grid
     row/column markup.

## How the layout is produced

When a page renders, the module reads the stored grid values for each paragraph,
resolves them against the active grid system's cell‑property patterns, and injects
the resulting classes (for example `col-md-6 offset-md-1`) onto the field and
paragraph wrappers, adding row/container markup as needed. If **Use library** is on,
it also attaches the framework's CSS so the columns actually lay out — turn that off
to rely on your theme's own grid CSS instead.
