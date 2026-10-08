<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Views Select provides two field widgets that render an entity-reference field — whose allowed values come from a View — as a select list, or as checkboxes/radio buttons, on entity forms. Each option is rendered using the View's own row output, so the widget shows exactly what the View would display.

---

Core lets an entity-reference field use a **View** as its "reference method" (handler), but only offers autocomplete/tag-style widgets for entering values. This module adds two `OptionsWidgetBase`-derived field widgets — `erviews_options_select` ("Entity Reference Views Select list") and `erviews_options_buttons` ("Entity Reference Views Check boxes/radio buttons") — that turn that same View-backed field into a fixed set of options. When the field's handler is `views`, the widget executes the referenced View (`view_name`, `display_name`, `arguments` from the field's `handler_settings`), renders each result row with the View's row plugin, and uses that rendered markup as the option label; the referenced entity id is the option value. The select widget adds a configurable empty option (default "- None -", set per widget via the `empty_value` setting) for non-required fields; the buttons widget renders radios (single value) or checkboxes (multiple). Both declare `multiple_values` and support option groups. If the field is not actually using a View handler, the widgets fall back to standard select/checkbox behaviour. There is no admin settings page, permission, service, or config entity of its own — you simply pick the widget on the bundle's *Manage form display*. Requires `field` and `views`.

---

- Show a View-backed entity-reference field as a single-select drop-down instead of autocomplete.
- Present reference options as radio buttons for a single-value field.
- Present reference options as checkboxes for a multi-value field.
- Render each option using a View row (e.g. an image + title) rather than just the entity label.
- Let editors pick from a curated, View-filtered list of referenceable entities.
- Use a View's contextual filters/arguments to scope the options offered in a form.
- Add a friendly empty option ("- None -") to an optional reference select.
- Customise the empty-option text per widget via the `empty_value` setting.
- Constrain a taxonomy-term reference to terms matched by a specific View.
- Offer a small, fixed set of related content as radios on a node form.
- Replace autocomplete with a bounded select where the option set is known and short.
- Show rendered teaser markup as the choosable label for each referenced entity.
- Drive a "choose a featured article" field from a View of promoted articles.
- Let content authors select referenced media/users/nodes from a designed list.
- Keep entity selection consistent with what a View already displays elsewhere.
- Configure everything from Manage form display — no code, no settings page.
- Fall back gracefully to a standard select when the field's handler is not a View.
- Provide checkbox multi-select for tagging content from a View-defined vocabulary subset.
- Use option groups in the select where the widget's grouping applies.
- Swap the widget per form mode (e.g. select on default, checkboxes on a custom mode).
