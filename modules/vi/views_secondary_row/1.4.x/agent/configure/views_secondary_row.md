<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — selecting and tuning the secondary-row table

There is **no admin settings page** (`configure` is `null`). All configuration happens inside the
Views UI on a single display, and is stored in that view's `style_options`.

## Turn a display into a two-row table

1. Edit a view (`/admin/structure/views/view/{id}`).
2. In the display, click the **Format** value (usually "Unformatted list" or "Table") and choose
   **"Table with fields in secondary row"**. Apply.
3. Add the fields you want as normal (they still appear as columns at first).
4. Click **Settings** next to the Format. You get core's Table settings grid **plus four extra
   columns** this module inserts: **1st row Rowspan**, **Secondary row**, **2nd row Separator**,
   **2nd row Colspan**.

Reverting is one step: set the Format back to **"Table"**.

## The four per-field options

Set on each field row of the settings grid. Stored at `style_options[info][FIELD][KEY]`.

| Grid column | Key (`info[FIELD]`) | Type / values | Effect |
|---|---|---|---|
| **Secondary row** | `break2` | select: `None` or another field's label | Moves this field **off the primary row** onto the secondary row, placed under the **column you pick here**. When empty the field stays a normal column. Fields with `break2` set are **omitted from the table header**. |
| **2nd row Separator** | `separator2` | textfield | Markup prepended before this field's output on the secondary row (only applies when `break2` is set). |
| **2nd row Colspan** | `colspan2` | textfield (number) | Adds a `colspan` to this field's `<td>` on the secondary row, so it can stretch across several primary columns. |
| **1st row Rowspan** | `rowspan1` | select: `1` or `2` | When `2`, this primary-row cell spans both the primary and secondary rows (i.e. it is **not** duplicated on the secondary row). Only meaningful for fields that stay on the primary row and while their own `break2` is empty. |

Core's own per-field options (Column, Align, Separator, Sortable, Default order, Hide empty column,
Responsive) work exactly as in the stock Table style and are inherited unchanged.

## Worked example (from the module README)

Fields: `Name | Description | Edit link | Delete link`.

- Set **Secondary row** of **Edit link** = `Name`.
- Set **Secondary row** of **Delete link** = `Description`.

Result — two rows per record, and the header shows only Name / Description:

```
NAME        | DESCRIPTION
MyNode      | Sample description
node/1/edit | node/1/delete
```

## Behaviour notes

- **Empty secondary rows are hidden.** If every secondary-row field for a record is empty, that
  `<tr>` gets classes `views-secondary-row--no-content hidden` (so records without secondary content
  don't leave a blank row).
- **Header collapses if empty.** As in core, if no primary column has a label the `<thead>` is
  dropped entirely.
- **No config schema ships.** The `break2` / `separator2` / `colspan2` / `rowspan1` keys are not
  declared in a `config/schema/*.yml` (the module provides none), so `drush config:*` /
  config-inspector may report these style-option keys as having no schema. This is cosmetic and does
  not stop the view working.
- **Multiple fields can target the same column** on the secondary row; they render in the fields'
  order (the preprocess re-orders secondary-row columns to match the configured column order).

## Where it lives in exported config

In the view's YAML: `display.*.display_options.style.type: views_secondary_row_table`, with the
grid values under `display.*.display_options.style.options.info.{field}.break2` (etc.).
