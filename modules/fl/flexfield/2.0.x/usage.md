<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flex Field adds a single field type, `flex`, whose every item packs several independently-typed sub-values into one entity field — you define the columns (name + max length) and pick a sub-field type (text, number, select, checkbox, UUID…) per column, avoiding a separate field or entity reference for each.

---

The `flex` field type stores an arbitrary set of `varchar` columns in one database table, one column per sub-field. Columns are declared as storage settings (`columns`: each a `name` and a `max_length`) on the field-storage form, where you add/remove/reorder them and can optionally clone the column set from another existing flexfield; column names and lengths lock once the field has data. Per-instance field settings (`field_settings`, one block per column) then assign each column a **FlexFieldType** plugin — the module ships `text`, `integer`, `decimal`, `float`, `select`, `radios`, `checkbox` and `uuid` — plus that plugin's widget settings (label, description, required, and type-specific extras like `allowed_values`, `min`/`max`, `scale`) and formatter settings, a per-column `check_empty` toggle, and a drag-and-drop `weight`. Because every column is physically a `varchar`, the FlexFieldType plugin is what gives a column its edit widget (textfield, number, select, radios, checkbox, hidden UUID value) and its display transformation (mapping a select key to its label, a checkbox to Yes/No text, etc.). The stored value has no single main property; you read each column by its name (`$item->value`, `$item->color`). Two widgets render the whole item: `flex_default` (inline, with optional CSS-flex proportions and a stack-on-breakpoint option) and `flex_stacked` (each sub-field on its own row). Five formatters ship: `flex_formatter` (the default, themeable `flexfield` template with per-column label display), `flex_inline` (values joined by separators with optional labels), `flex_table` (one HTML table, sub-fields as columns, items as rows), `flex_list` (HTML `ul`/`ol`) and `flex_template` (a custom template with `[name]` / `[name:label]` token replacement). An item is considered empty (and dropped) when every column whose `check_empty` is on is empty; the `uuid` type auto-fills a UUID the first time an item is saved and the `checkbox` type is never empty-checked. The module defines its own `FlexFieldType` plugin type (manager service `plugin.manager.flexfield_type`) so custom sub-field types can be added by other modules. It needs core `field` and `field_ui`, has no configure route, and defines no permissions, Drush commands or config schema of its own.

---

- Store a **postal address** as one field with separate street, city, postcode and country columns.
- Capture a **person plus role** ("Jane Doe" / "Director") without a paragraph or referenced entity.
- Model **product specifications** — attribute name column plus value column — as one repeatable field.
- Record **opening hours** with a weekday text column and an hours text column, shown as a table.
- Build a lightweight **FAQ field**: a question column and an answer column rendered as an HTML list.
- Hold a **link label plus URL** in two text columns and lay them out inline.
- Store a **rating verdict** constrained to Gold/Silver/Bronze via a `select` column's allowed values.
- Offer editors **radio buttons** for a constrained column by choosing the `radios` sub-field type.
- Add a **numeric score** column using the `integer` type with `min`/`max` bounds.
- Capture a **price** using the `decimal` type with a configured scale (decimal places).
- Capture a **measurement** using the `float` type for arbitrary-precision numbers.
- Add a **boolean flag** column with the `checkbox` type, displayed as custom Yes/No text.
- Attach a stable **machine identifier** to each item with the `uuid` type for use in custom code.
- Render the item **inline** with a custom separator between values using the Inline formatter.
- Render the item as a **numbered list** by setting the HTML List formatter to `ol`.
- Render repeatable items as a **single table** with sub-field labels as column headers.
- Produce **custom markup** (e.g. `[name], [city]`) with the Custom Template formatter's tokens.
- Show or hide each sub-field's **label** independently (above / inline / hidden) in the default formatter.
- Lay the sub-widgets out with **relative proportions** (1/1/2 → 25%/25%/50%) using the inline widget.
- **Stack** the inline sub-widgets on small screens by choosing a breakpoint on the widget.
- Present each sub-field on its **own row** on the edit form with the Stacked widget.
- Prevent blank rows by leaving `check_empty` on for the columns that signal a filled item.
- Keep a **UUID column filled but hidden** from editors while other columns stay editable.
- **Clone** an existing flexfield's column set into a new field when first configuring storage.
- Replace **several parallel fields** with one flexfield to cut the number of columns on an entity form.
- Theme one specific field's output with the `flexfield__<field_name>` theme hook suggestion.
- Add a **project-specific sub-field type** (e.g. a color picker) by implementing a `FlexFieldType` plugin.
