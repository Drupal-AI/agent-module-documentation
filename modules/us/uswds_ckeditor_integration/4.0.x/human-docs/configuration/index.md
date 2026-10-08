# Configuration

There are two things to set up: the USWDS buttons and filters on a **text format**,
and the site-wide **grid layout matrix**.

## 1. Enable the plugins and filters on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and **edit** a format that uses **CKEditor 5**.
2. In the toolbar configuration, drag the USWDS buttons you want into the **Active
   toolbar**:
   - **USWDS Grid** — the responsive grid builder.
   - **USWDS Accordion** — the inline accordion widget.
   - the table **USWDS** content-toolbar item — to mark a selected table sortable or
     stacked.
   - the **Embedded Content** button (from the `embedded_content` module) — this is
     how editors insert the Alerts, Process List, Summary Box, and Accordion
     components.
3. Some buttons expose extra settings below the toolbar once added (see *Per-format
   plugin settings* below).
4. If you use USWDS tables, enable the responsive-table **filters** under **Enabled
   filters**:
   - **USWDS Sortable Table Attributes CK5**
   - **USWDS Stacked Table Attributes CK5**

   Place them sensibly in the filter order — they post-process the saved markup to add
   the ARIA/scope/`data-*` attributes and wrapper markup that USWDS sortable and
   stacked tables need. They only *add* attributes; they also log an accessibility
   warning if a sortable table has no caption, or a stacked table has no header row.
5. Make sure the format's **allowed HTML** permits the elements these plugins emit —
   for example the accordion's `<div>`/`<button>` with its classes and
   `aria-multiselectable`/`data-start-collapsed` attributes, the grid's `<div>` with
   `class`/`data-*`, and the table cells' `scope`/`data-label`/`data-sortable`/`role`
   attributes. On *Limited HTML* / *Full HTML* you may need to widen the allowed tags.

### Per-format plugin settings

Some plugins add settings below the toolbar for that format:

- **USWDS Grid** — choose the **available columns** and **available breakpoints** this
  format offers. That scopes what the grid dialog presents to editors using this
  format.
- **USWDS Table Toolbar Items** — adds a `tableUswds` entry to the table content
  toolbar so editors can mark a selected table sortable or stacked (it works
  alongside core's table plugin).
- **USWDS Accordion** — adds the accordion widget and its content toolbar
  (add above/below, remove, properties).
- **USWDS Overrides** — tweaks default link/list/table editing behavior to emit
  USWDS-friendly markup; it adds no new elements.

### The embedded components

Inserted via the Embedded Content button, each opens a small configuration form:

- **Accordion** — repeatable heading + rich-text body panels, with *bordered*,
  *multiselect*, and *start collapsed* options.
- **Alerts** — a severity (informative, warning, error, success), *slim* and
  *no icon* variants, plus a heading and body.
- **Process List** — repeatable numbered steps, each with a heading and rich-text
  body.
- **Summary Box** — a key-information callout with a heading and body.

Accordion and Process List bodies are run through the chosen text format's filters
(so they can contain rich content); all components render through fixed Twig templates
that auto-escape their output.

## 2. Set up the grid layout matrix

1. Go to **Configuration → Content authoring → *(CKEditor USWDS grid)***
   (`/admin/config/content/ckeditor_uswds_ck_grid`).
2. You need the **Administer USWDS CKEditor integration grid** permission.

The module ships a large default matrix, so this form is about tuning rather than
building from scratch. It defines the **breakpoints** (`card`, `card_lg`, `mobile`,
`mobile_lg`, `tablet`, `tablet_lg`, `desktop`, `desktop_lg`, and a selectable
`widescreen`), each with column counts 1–12 and a set of **layout presets** (Equal
Width, Auto, percentage splits, Full Width). On the form you can:

- **Rename breakpoint labels** to friendlier names.
- **Add or remove layout presets**, reordering them by weight in a draggable table.
- **Set each column count's default layout** (either none, or the top preset by
  weight).

## How editors build a grid

With **USWDS Grid** in the toolbar, an editor clicks it to open a three-step modal
dialog:

1. **Select** — how many columns.
2. **Layout** — the per-breakpoint layout (plus add-container / no-gutter toggles).
3. **Advanced** — optional utility classes on the container, row, and individual
   columns.

On save, the dialog computes the USWDS grid classes (`grid-container`, `grid-row`,
`grid-col*`, and breakpoint-prefixed variants) and inserts them as `<div>` markup into
the content being authored. The dialog itself changes no server state — it just returns
the computed classes to the editor.

## Assets

The module automatically adds its editing-surface CSS to CKEditor, attaches the USWDS
accordion front-end JavaScript on all pages (so accordions work for visitors), and
registers the Twig templates for the four embedded components.
