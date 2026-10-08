<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yaml Form Element provides a reusable `#type => 'yaml'` Form API element — a textarea that parses and validates YAML on submit — plus a field widget and formatter that let a core `map` field be edited and displayed as YAML.

---

This is a developer-facing module with no UI of its own: install it with `composer require drupal/yamlelement` and enable it (`drush en yamlelement`), and there is no settings page to visit. In a custom form you add a field with `'#type' => 'yaml'`; you set `#default_value` to a **PHP array/structure** (the element dumps it to YAML text for the textarea), and after a valid submit `$form_state->getValue()` gives you back the **parsed PHP structure** rather than a string — so your code always works with native values and never has to call the parser itself. Invalid YAML is caught by the element's own `#element_validate`, which reports the error `"The Yaml in <field> is not valid."` on the element instead of letting a parse error surface later in the save handler. The same element powers a field **widget** and **formatter** (both named `yamlelement`) for the core `map` field type: attach the widget on *Manage form display* to edit the stored map as YAML, and the formatter on *Manage display* to render it inside a `<pre>` block. Because `map` fields are not offered in the *Add field* UI, this is most useful for `map` fields defined in code. It runs on Drupal `^8.8 || ^9 || ^10 || ^11` (release **8.x-1.5**) and depends only on core. One thing to keep in mind: the element validates YAML **syntax** only — it does not check that the keys and values are the ones your code expects, so consuming code still needs to validate the parsed structure it receives.

---

- Add a YAML textarea to a settings or configuration form.
- Validate YAML syntax before a form is saved.
- Report YAML parse errors on the element, not in the save handler.
- Reuse one YAML element across many custom forms.
- Edit a stored `map` field as YAML in the entity form.
- Display a `map` field's contents as formatted YAML.
- Store structured, free-form data without writing a custom widget.
- Let developers hand-edit a nested configuration structure.
- Provide per-entity settings as an editable YAML blob.
- Avoid re-inventing a YAML parse/validate callback in each module.
- Get a parsed PHP array straight from `$form_state`.
- Seed the element from a PHP array via `#default_value`.
- Edit a list of key/value pairs quickly.
- Prototype a structured field before building a real widget.
- Store options for a custom render/plugin as YAML.
- Give admins a code-editor-style textarea for structured input.
- Round-trip a nested data structure between form and storage.
- Render map-field data read-only inside a `<pre>` block.
- Keep developer-only configuration out of the main UI.
- Attach the widget/formatter to a code-defined `map` base field.
