<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autocomplete Field Match is an entity-reference field widget whose autocomplete can resolve free-typed input against fields other than the entity label.

---

Autocomplete Field Match replaces the core "Entity reference autocomplete" widget with one that, when an editor types a value and does not pick a suggestion from the dropdown, tries to resolve that free text against one or more configured non-label fields on the referenced entity (or on a field-collection / paragraph one level deep) instead of only matching by title. Per widget you choose which field(s) to match, the field property to compare (`value`, `uri`, or `target_id`), a comparison operator (`=`, `>`, `<`, `>=`, `<=`, `STARTS_WITH`, `CONTAINS`, `ENDS_WITH`), an AND/OR conjunction when several fields are listed, and the language(s) to search. The live dropdown itself is still standard core entity autocomplete (label matching, access-respecting); the extra field-matching only runs during form validation as a fallback when no dropdown entity was selected. If the typed value matches exactly one entity it is silently referenced; if it matches several a validation error asks the editor to disambiguate via the dropdown. It depends on core Field and Field UI and adds no permissions, services, or admin pages of its own — everything is configured per field on Manage form display.

---

- Let editors reference a taxonomy term, node, or user by typing a SKU, code, email, or other non-title field value.
- Match a product by its part number field while the reference target is still the product node.
- Reference a user entity by typing an email address or account field rather than the username label.
- Match against a field inside a referenced Paragraph or Field collection item, one level deep.
- Keep the familiar core autocomplete dropdown (label suggestions) but broaden what a manually typed value can resolve to.
- Configure several candidate match fields and require the value to appear in ALL of them (AND conjunction).
- Configure several candidate match fields and accept a match in ANY of them (OR conjunction).
- Choose the comparison operator per widget: exact `=`, range (`>`, `<`, `>=`, `<=`), or `STARTS_WITH` / `CONTAINS` / `ENDS_WITH`.
- Match the `uri` property of a link field or the `target_id` of a nested reference instead of the default `value` property.
- Restrict matching to specific content languages, or leave language empty to search all installed languages.
- Fall back automatically to standard core title matching when the editor picks an item from the dropdown.
- Surface a disambiguation error when the typed value matches more than one entity, forcing the editor to select from the dropdown.
- Reuse the widget on any `entity_reference` field via Manage form display, with no code.
- Set the textfield size and placeholder like the core autocomplete widget.
- Import the widget configuration through `core.entity_form_display.*` config for repeatable deployments.
- Improve data-entry ergonomics on bulk content-editing forms where editors know a field value but not the title.
- Support autocreate of new referenced entities where the selection handler allows it, matching core widget behaviour.
- Drive references from external identifiers (order numbers, ISBNs, ticket ids) stored in a dedicated field.
- Avoid building a custom form element or selection plugin just to match on an alternate field.
- Provide a drop-in upgrade path for sites already using core entity-reference autocomplete widgets.
