<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Text Field Formatter is a field formatter for plain `string` fields that extends core's String formatter, adding an optional HTML wrapper tag around the value plus configurable CSS classes and arbitrary HTML attributes on that wrapper.

---

The module provides one formatter, `text_field_formatter` ("Text field formatter"), for `string`-type fields. It subclasses core's `StringFormatter`, so it keeps the standard behavior (including the "Link to the referenced entity" option) and adds four settings: a **wrap tag** (`div`, `h1`–`h6`, or `span` by default — `a` is disallowed to avoid conflicts), a space/comma-separated list of **wrapper classes**, freeform **wrapper attributes** (one `attribute|value` per line), and an **override link label** (with token support, shown only when "Link to entity" is on). At render time it wraps each field value in the chosen tag with the given classes and attributes; when the value is rendered as a link and a label override is set, the label is token-replaced against the field's entity. The list of available wrap tags is alterable by other modules via `hook_default_wrap_tags_alter()`, so you can add tags like `p`. Settings are stored on the entity view display like any formatter (`core.entity_view_display.<entity>.<bundle>.<mode>` → `content.<field>.settings`). The module has no config UI of its own, no permissions, and no dependencies beyond core.

---

- Wrap a plain-text field's output in a `<div>` with a custom CSS class.
- Render a string field value inside an `<h2>` for styling headings.
- Add a `<span>` wrapper with utility classes to inline text.
- Attach arbitrary HTML attributes (e.g. `data-*`, `id`) to a field wrapper.
- Give a "subtitle" string field a semantic heading tag on display.
- Apply BEM/utility CSS classes to a field without a template override.
- Override the entity-link label of a linked string field with custom text.
- Use tokens in the overridden link label (e.g. include the node title).
- Keep core String-formatter behavior while adding a wrapper element.
- Standardize wrapper markup for a field across view modes via display config.
- Add a `class` to a field wrapper for JavaScript targeting.
- Register an extra wrap tag (like `p`) via hook_default_wrap_tags_alter().
- Present a field value as a styled callout by wrapping + classing it.
- Add microdata/ARIA attributes to a text field's wrapper.
- Configure different wrappers per bundle on the same field.
- Wrap a product code / SKU string field in a `<span class="sku">`.
- Avoid a custom formatter plugin for simple wrapper needs.
- Set multiple CSS classes at once (space or comma separated).
- Control field markup from the Manage display UI instead of Twig.
- Provide editors consistent, class-tagged output for a text field.
