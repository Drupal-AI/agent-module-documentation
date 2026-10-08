<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Group Definition List adds a "Definition list" formatter to the Field Group module so a group of fields renders as a semantic HTML `<dl>` (label as `<dt>`, value as `<dd>`).

The module solves the need for semantic, label/value markup when displaying grouped fields. It registers a `field_group_dl` FieldGroupFormatter plugin (view context only) that wraps the group in a `field_group_dl` theme hook; the accompanying `template_preprocess_field_group_dl()` walks the group's child elements, keeps only those whose `#theme` is `field`, forces each field's label display to hidden, and hands the theme an `items` array of `{label, content}` pairs. The Twig template (`templates/field-group-dl.html.twig`) then emits the definition list.

Operationally it is configured entirely through the Field Group UI on an entity's "Manage display" tab — add a group, choose the "Definition list" formatter, and set the optional HTML id and extra classes (standard Field Group formatter settings). There are no routes, permissions, services, or configuration of its own, so there is no additional access surface; it only affects rendered output.
---
Depends on the contrib `field_group` module. The formatter is view-context only (display, not forms) and each grouped field's own label is hidden in favour of the `<dt>` label.
---
- Enable the module alongside `field_group`.
- Add a field group on an entity view display and choose the "Definition list" formatter.
- Render a set of node fields as a semantic `<dl>` label/value list.
- Give the definition list an HTML `id` via the formatter settings.
- Add custom CSS classes to the `<dl>` wrapper for theming.
- Display author/date/taxonomy metadata as a compact term list.
- Present product attributes (size, colour, SKU) as definition-list rows.
- Replace ad-hoc table markup for label/value pairs with accessible `<dl>` output.
- Group event details (date, location, price) into one definition list.
- Style the `<dt>`/`<dd>` pairs entirely from the theme layer.
- Override `field-group-dl.html.twig` in a theme for custom markup.
- Nest the definition list inside another field group formatter.
- Use per-view-mode (teaser vs full) definition lists for the same fields.
- Hide individual field labels automatically inside the group.
- Build a specification sheet block from grouped fields.
- Keep field markup semantic for screen readers and SEO.
- Apply it to media, taxonomy, or custom entity view displays, not just nodes.
- Combine with other Field Group formatters (details, tabs) on the same display.
