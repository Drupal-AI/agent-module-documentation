# Configure a CSS Grid section (in Layout Builder)

There is **no module settings page** (`configure` route is null). All configuration is done on an
individual Layout Builder section using the `css_grid` layout plugin's configuration form. Access is
controlled entirely by core Layout Builder permissions (e.g. *Configure any layout* /
*Create and edit custom layouts*, plus the per-display "Allow each entity to have its layout
customized" toggle). This module adds no permissions of its own.

## Steps

1. Enable **Layout Builder** for an entity view display: *Structure → Content types → (type) →
   Manage display*, tick **Use Layout Builder** (and, if you want per-entity overrides, **Allow each
   entity to have its layout customized**), save.
2. **Manage layout** → **Add section**. In the layout chooser, the category **CSS Grid** offers the
   **CSS Grid** layout. Choose it.
3. In the section's configuration form set:
   - **grid-template-columns** — add one "column" row per grid column; each row is a value + unit
     (`fr`, `auto`, `max-content`, `min-content`, `minmax`, `%`, `rem`, `px`). "Add column" /
     "Remove item" adjust the count (AJAX). Selecting `minmax` turns the value field into text and
     prefills `200px,400px`; `auto`/`min-content`/`max-content` blank/lock the value.
   - **grid-template-rows** — same, one row per grid row.
   - **gap** — a **row-gap** and a **column-gap** number + unit (`%`, `rem`, `px`), 0–20.
4. Save the section. The number of block-drop regions created equals **columns × rows**
   (`content_1 … content_N`). Place blocks into the cells, save the layout.

Validation requires **at least one column and one row**, or the form errors with
"A grid requires at least one column and one row."

## What gets stored

The layout plugin's configuration (persisted in the section, either in the display's default layout
or in an entity's overridden layout):

```php
[
  'grid_columns' => [ ['value' => '1', 'unit' => 'fr', 'type' => 'grid_columns'], … ],
  'grid_rows'    => [ ['value' => '1', 'unit' => 'fr', 'type' => 'grid_rows'], … ],
  'grid_gap'     => [
    0 => ['value' => 0, 'unit' => 'px', 'type' => 'row_gap'],
    1 => ['value' => 0, 'unit' => 'px', 'type' => 'column_gap'],
  ],
  'grid_cells'   => 4,   // = count(grid_columns) * count(grid_rows)
]
```

On render this becomes an inline `style` on `<section class="css-grid-layout">`, e.g.
`grid-template-columns: 1fr 2fr; grid-template-rows: 1fr 1fr; gap: 0px 0px;`. For how those strings
are computed (including `minmax(...)` and the keyword units) see
[../plugins/css-grid-layout.md](../plugins/css-grid-layout.md).

Note: the module's grid CSS library (which provides `display: grid` on `.css-grid-layout`) is
attached only inside this configuration form, not on the rendered page — confirm the grid displays as
intended on the front end for your theme.
