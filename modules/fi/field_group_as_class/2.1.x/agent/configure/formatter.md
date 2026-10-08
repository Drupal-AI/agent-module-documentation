# Using the "As Class" field group formatter

There is no admin settings page — everything is per field group on *Manage display*.

## Steps
1. Ensure the bundle has a **Text (plain)** (`string`) or **List (text)** (`list_string`) field whose
   value(s) are valid CSS class strings (e.g. a select with options `dark`, `featured`). Base fields are
   not eligible.
2. On the entity's *Manage display* tab, add a **Field group** (needs the `field_group` module) and set
   its **Format** to **As Class**.
3. Open the group's formatter settings and set **Select the Field Class** (`field_class`) to the field
   from step 1. This is required. (If the select is empty, no eligible string/list_string field exists.)
4. Place the fields you want wrapped inside the group.

## What it renders
- The group becomes a `container` wrapper (`AsClassElement`) with classes = the standard field_group
  "Extra CSS classes" (static) **plus** the first value of the `field_class` field for the entity being
  displayed. An optional `id` from the base field_group settings is added as the wrapper's `id`.
- Resolution happens in `AsClass::preRender()`, which finds the entity via the render context
  (`#node` / `#paragraph` / `#term` / `#account` / `#entity`) and reads
  `getFieldClassValue($entity)` = `$entity->get($field_class)->getValue()[0]['value']`.

## Config
- Stored on the entity view display's field_group third-party settings; the formatter settings schema is
  `field_group.field_group_formatter_plugin.asclass` (`mapping.field_class: string`).
- Supported only in the **view** context and only for entity types node, paragraph, taxonomy_term,
  block_content.

Note: the class value comes from editor-entered content. Use a constrained List (text) field (fixed
option machine names) rather than a free-text field if you want to keep the emitted classes predictable.
