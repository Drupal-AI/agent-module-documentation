Markup adds a `markup` field type that outputs a fixed block of HTML/markup you define once in the field settings, rendered both on the entity edit form (via its widget) and on the entity display (via its formatter).

---

The module registers a single Field API plugin set — a `markup` field type, `markup` widget, and `markup` formatter — whose "value" is not entered per entity but stored once in the field's settings as a `text_format` (value + text format). Add it like any other field via Field UI ("Add a new field" → "Markup"), then type the HTML/markup and pick a text format in the field settings form; that markup is what every entity of the bundle will show. The widget renders the markup as `processed_text` inside the node/edit form, letting site builders drop instructions, notices, dividers, or arbitrary HTML in front of content authors — the equivalent of adding a `#markup` element to `$form`. The matching formatter renders the same markup on the entity's display output. Cardinality is forced to single value: the module removes the "number of values" selector from the field storage edit form. The module has no admin settings page, no permissions, and no configuration UI of its own (`configure` is null); all setup happens in the per-field settings. It depends only on core `field`, ships a config schema mapping the field setting to `text_format`, and provides `hook_help` that renders its README on the module help page.

---

- Show standing instructions or author guidance at the top of a content type's edit form.
- Insert a warning or notice (e.g. "Do not publish before legal review") into the node/edit form.
- Add a visual divider or section heading between groups of fields on the edit form.
- Embed static HTML (buttons, links to docs, help videos) for content authors while editing.
- Reproduce the old CCK-style "markup" element without writing a custom `hook_form_alter`.
- Render a fixed promotional/legal boilerplate block on every node of a bundle's display.
- Provide a consistent call-to-action or disclaimer on all entities of one type.
- Add contextual help text that only editors (not visitors) see, by enabling the widget but hiding the formatter.
- Display a static banner or announcement on an entity view without a block.
- Give designers a way to inject arbitrary markup into forms without code deployment.
- Add a styled `<div class="form-item">` explanatory panel following form standards.
- Attach the same static footer/header markup to taxonomy terms, users, or any fieldable entity.
- Embed an iframe, map, or third-party widget snippet on every entity of a bundle.
- Provide onboarding/tooltip HTML for editors in a multi-author workflow.
- Standardize repeated markup across entities without duplicating it per node.
- Insert a link to related admin tasks or documentation inside the edit form.
- Add a horizontal rule or spacing element between fieldsets.
- Show a compliance checklist as static HTML above the submit button.
- Render fixed structured markup (definition lists, tables) on entity display.
- Use one text format's filters (e.g. Full HTML) to control what tags the markup may contain.
- Give a bundle a permanent "how to fill this form" panel that survives config redeploys via config export.
- Replace ad-hoc description text with richer, format-processed markup.
- Add a static legal/GDPR notice above a webform-like content entity.
- Provide editors a preview of brand guidelines inline on the edit form.
