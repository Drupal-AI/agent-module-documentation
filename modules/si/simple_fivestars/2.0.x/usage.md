<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Fivestars supplies a reusable five-star UI: a custom `fivestars` form element, a matching field widget for entering a 0–5 value, and a formatter for displaying a stored numeric value as filled stars.

---

The `FivestarsElement` (a `@FormElement`) renders six radio inputs (0–5) styled as stars via CSS, with a `[0-5]` pattern constraint; it is a normal form input, so submitted values flow through Drupal's Form API. The `FivestarsWidget` (`@FieldWidget` for integer/decimal/float fields) wraps that element for content forms and offers a "Hide label" setting. The `FivestarsFormatter` (`@FieldFormatter` for the same field types) renders each value through the `fivestars` theme hook; `simple_fivestars_preprocess_fivestars()` computes a fill width (`number * 2 * 10` percent) and the `fivestars.html.twig` template shows a filled bar over the star background.

Importantly, this is a field-level rating input/display, not a public voting endpoint — values are stored on entity fields and edited through ordinary entity forms, which are CSRF-protected by the Form API and gated by entity/field access; there is no anonymous submission route, so there is no vote-stuffing or CSRF surface introduced by the module. The generated radio markup uses only internal, numeric values (0–5) and the element id, so there is no untrusted data in the output. Typical setup: on a numeric field's form display choose the Fivestars widget, and on its display choose the Fivestars formatter.
---
- Add a star-rating widget to a numeric entity field
- Display a stored score as filled five stars
- Capture a 0–5 rating on nodes, users, or other entities
- Use the fivestars form element in a custom form
- Constrain input to whole values 0–5
- Hide the field label on the star widget
- Show ratings in teasers and full view modes
- Style ratings with the bundled CSS and SVG star assets
- Render decimal/float scores as a proportional star fill
- Provide editors a simple rating control without contrib voting APIs
- Reuse the same widget/formatter across integer, decimal, float fields
- Build an editorial quality-score field with stars
- Present product or content ratings visually
- Collect ratings through standard, access-controlled entity forms
- Constrain the rating input to the 0–5 pattern
- Attach the bundled star styling automatically on render
- Add a star control to a custom form via the fivestars element
