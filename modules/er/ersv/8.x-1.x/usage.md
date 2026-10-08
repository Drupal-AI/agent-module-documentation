<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ERSV provides one EntityReference selection plugin (`ersv`) that decouples the two jobs a normal selection handler does: building the list of choosable entities and validating the reference that was actually submitted.

---

In core, a single selection handler both narrows the options a reference widget offers and validates the saved value against the same criteria. ERSV lets you configure a separate *selection* handler and *validation* handler on one entity reference field: the selection handler controls what a user can pick (optionally a filtered, AJAX-dependent subset), while the validation handler decides what is ultimately acceptable — usually a broader or different rule. Because it implements `SelectionWithAutocreateInterface`, autocreate is delegated to the validation handler too, and because it wires its nested handler-settings subforms with the required `ajax_dependency` module, the offered options can rebuild in reaction to the chosen handler. It is a pure field-configuration tool: set it as the reference method on a field, choose the two handlers, and all behaviour is evaluated at form-build and validation time. It exposes no routes, permissions, services or config schema of its own.

---
- Offer a filtered subset of entities for selection while validating against a wider set.
- Reference only future events for selection but accept any event on validation.
- Separate the "what can be picked" rule from the "what counts as valid" rule.
- Allow a broader validation than selection so editing does not strip valid references.
- Add and reference non-reusable entities via Inline Entity Form while keeping a stricter selection list.
- Use different selection and validation handlers on a single reference field.
- Configure ERSV as the reference method in an entity reference field's settings.
- Delegate autocreate to the validation handler (via SelectionWithAutocreateInterface).
- Reuse core `default` / `views` selection handlers as the underlying selection plugin.
- Reuse core `default` / `views` selection handlers as the underlying validation plugin.
- Apply distinct handler settings (bundles, filters, views) to selection vs validation.
- Restrict the visible options without changing the validation constraints.
- Prevent invalid picks even when the offered options are dynamically filtered.
- Support reference fields whose selectable set legitimately differs from the acceptable set.
- Configure target bundles independently for the display side and the validation side.
- Build widgets where the choosable list is narrower than what the field can hold.
- Combine with a `views`-based selection handler for a curated pick list plus a permissive validator.
- Avoid writing a bespoke selection-plugin class just to split select from validate.
- Keep config export accurate — dependencies of both child handlers are calculated.
- Let the selection handler and validation handler target the same entity type with different scopes.
- Migrate an existing reference field to split selection/validation by switching its reference method.
- Support inline-entity-form widgets that create entities the selection list never shows.
- Provide a narrow autocomplete while still validating references created elsewhere.
