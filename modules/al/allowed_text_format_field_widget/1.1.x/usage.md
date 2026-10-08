<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Allowed Text Format Field Widget adds an "Allowed Text Format" widget for formatted long-text (`text_long`) fields whose settings pick, per form display, which text formats appear in that field's format selector — narrowing what is offered without changing what any user is permitted to use.

---

Drupal's text format selector normally shows the intersection of the formats that exist and the formats the current user has permission to use — a permission question, not a content-modelling one. An editor who holds Full HTML therefore sees it offered on every formatted text field on the site, including the ones where it makes no sense: a caption, a short teaser, a summary meant to stay plain. Nothing stops them choosing it, and once one node's caption carries a table and an inline style the design accommodates it or someone fixes it by hand. This module lets a site builder express the content model's intent at the field's *form display*: swap the field's widget to **Allowed Text Format** and tick the formats that field should offer. Mechanically the widget extends core's `TextareaWidget`, adds a `checkboxes` element (setting `allowed_format`) listing every `filter_format` entity's label to the widget settings form, and on render sets the text area's `#allowed_formats` to the machine names of the ticked formats (an empty selection means "all formats"). Because the setting lives on the widget, two form displays of the same field can offer different lists — the point of difference from the older single-restriction "Allowed Text Format" module. Two boundaries to keep clear. First, it only handles the `text_long` field type — not `text_with_summary` (the standard Body field) nor single-line `text`, which will not show the widget as an option. Second, and more important, **it narrows what is offered, not what is permitted**: core's `TextFormat` element still intersects `#allowed_formats` with `getFormatsForAccount($user)`, so a user is never shown or allowed a format they lack the `use text format X` permission for, and a user who holds Full HTML still holds it. Version **1.1.0-rc1**, a release candidate, on `^8` through `^11`, depending on core `field` and `filter`. Anything that writes to the field outside this widget — a migration, JSON:API, a webform handler, a second form display without the widget — is unaffected. Treat it as content-model enforcement and editorial guidance, never as a security control that stops someone using a format they hold the permission for.

---

- Restrict a formatted long-text summary field to a single plain-text format.
- Offer only one format on a caption field.
- Keep Full HTML off a teaser body.
- Express a content model's intent at the widget level.
- Give two form displays of the same field different format lists.
- Reduce inconsistent markup in short formatted fields.
- Limit format choice per field and per form display.
- Simplify an editor's format options on a specific field.
- Discourage tables and inline styles in a caption.
- Restrict formats on a listing/promo field.
- Keep a field's rendered markup predictable.
- Reduce design breakage caused by over-rich content.
- Present a restricted format list on an entity edit form.
- Guide editors toward the intended format for a field.
- Standardise markup across a content type's short fields.
- Constrain formats on a field embedded in complex layouts.
- Discourage style attributes in a summary field.
- Cut the number of editorial decisions per field.
- Support a design system's markup constraints editorially.
- Default a field to a single allowed format so no selector even shows.
- Swap the default `text_textarea` widget for a format-restricted one without changing the field storage.
- Keep the same field permissive on an admin form display and locked-down on an editor-facing one.
