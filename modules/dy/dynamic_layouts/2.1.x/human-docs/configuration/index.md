# Configuration

Configuring Dynamic Layouts means two things: choosing the **frontend library** the
grid is built on, and then **building your layouts** — rows, columns, widths, classes,
and names. Everything happens under **Configuration → Dynamic Layouts**
(`/admin/config/dynamic-layouts`), which requires the **Administer dynamic layouts**
permission.

## Choose the frontend library

When you first enable the module you choose which frontend library your layouts use:

- **Bootstrap (v4)** — generates Bootstrap‑style grid markup. If you pick this,
  install the **Bootstrap Library** module (selecting the v4 version) and make sure
  your theme implements Bootstrap v4, so the grid classes actually render. See
  [Installation](../installation/index.md).
- **Custom** — a plain 6‑, 8‑, or 12‑column grid with no framework dependency, for
  sites that don't use Bootstrap.

## Add and manage a layout

After choosing the library, create a new layout and shape it:

- **Rows and columns** — add, remove, and edit rows, and add columns within each row.
- **Column width** — set the width of each column (within your chosen grid).
- **Custom classes** — add custom CSS classes to any row or column. You can also
  define a **list of predefined classes** that become selectable per column, which
  keeps class usage consistent across editors.
- **Column names** — give each column a custom name; that name is shown when the
  layout is used in **Display Suite** and **Panels**, making regions easy to identify.

## Save and use the layout

When you **save** the layout, it immediately becomes available in **Display Suite**,
**Panels**, and the **core Layout Builder** — wherever Drupal offers layouts. Select
it there as you would any built‑in layout.

## Deploying layouts between environments

Because each layout is a **configuration entity**, it exports and imports with normal
Drupal config management. Run `drush cex` to export your layouts along with the rest
of your configuration and `drush cim` on another environment to bring them in — the
same deployment story as a code‑declared layout, without writing code.

## Verify it worked

Build a small test layout, save it, then open a Layout Builder section (or a Display
Suite / Panels display) and confirm your layout appears and renders with the expected
rows, columns, and classes.
