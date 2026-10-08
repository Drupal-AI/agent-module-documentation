<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field formatter conditions (fico) lets you attach a "hide/show" condition to any field on an entity's *Manage display*, so a field is conditionally removed from the rendered output based on data (empty/non-empty, matching string), the current user's role, the author, or the current path.

---

The module adds a per-field **Conditions** section to field formatter settings via
`hook_field_formatter_third_party_settings_form()`, and also integrates with Display Suite (DS)
fields (it depends on `ds`). Each condition is a `FieldFormatterCondition` plugin
(`src/Plugin/Field/FieldFormatter/Condition/*`) implementing `alterForm()` (its settings form),
`access()` (the hide logic), and `summary()`. The chosen condition id and its settings are stored
as the field component's third-party settings under `fico.fico` (`condition` + `settings`). At
render time `fico_entity_view_alter()` instantiates the condition plugin and calls `access()`,
which sets `$build[$field]['#access'] = FALSE` to hide the field (it hides the display only, it is
not a data-access control). Built-in conditions cover empty/non-empty target fields, substring
matching in a target field, boolean checks, author / non-author, current-user role, link-title
presence, and path matching (all-pages-except / only-listed with `*` wildcards). Conditions
declare which field `types` they apply to (or `all`) and whether they show on DS fields
(`dsFields`). There is no global config page and no permissions; you build custom conditions by
adding a `FieldFormatterCondition` plugin in your own module. Field type eligibility is filtered
by `fico_field_options()`, and text-matching conditions are limited to the types in
`fico_text_types()`.

---

- Hide a field on the entity display when another target field is empty (e.g. hide a label when its value is missing).
- Hide a field when a target field is *not* empty.
- Hide a field when a target text field contains a specific string (with optional whole-word and case-sensitive matching).
- Hide a field when a target field does *not* contain a string.
- Hide a field based on a boolean field's value.
- Hide a field from the content author (or show it only to the author).
- Hide a field from non-authors so only the author sees it.
- Hide a field when the current user has one of the selected roles.
- Optionally include or exclude user 1 (the admin) from a role-based hide.
- Hide a link field/label when the link title is empty.
- Hide a field on specific pages (only the listed paths).
- Hide a field on all pages except the listed paths, using `*` path wildcards.
- Conditionally hide date/time output with the datetime condition.
- Apply conditions to Display Suite (DS) fields as well as regular formatter fields.
- Build a "read more" style layout where a summary field hides once a full body is present.
- Suppress an empty address/phone field so it does not render an empty wrapper.
- Show a "members only" field only to authenticated roles by hiding it from others.
- Hide administrative or editorial fields from the public view mode by role.
- Vary field visibility per path without creating separate view modes.
- Write a custom `FieldFormatterCondition` plugin for project-specific hide rules.
- Keep conditional-display logic in configuration (component third-party settings) instead of preprocess/Twig.
- Combine with view modes to reduce the number of bespoke display configurations needed.
