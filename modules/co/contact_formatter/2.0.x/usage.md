<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact Formatter adds a field formatter that renders a full, working Drupal contact form inline wherever an entity-reference field points at a contact form entity.

---

The module ships a single field formatter plugin, `contact_field_formatter` (labelled "Rendered Contact Form"), that applies to `entity_reference` fields. For each referenced contact form it builds a new `contact_message` entity for that form and renders the contact form's submit form with the entity form builder, outputting the rendered HTML as the field's display. This lets a site builder embed a specific site-wide contact form directly into a node, taxonomy term, block, or any other fieldable entity simply by referencing the form and choosing this formatter on the *Manage display* tab — no custom template, block, or code required. Personal (user) contact forms are deliberately skipped (`ContactMessage::isPersonal()`), because they require a target user context. The module has no settings form, no configuration schema, no permissions, no services and no Drush commands; all behaviour lives in the one formatter. It depends only on core's `contact` module and works on Drupal 8 through 11.

---

- Embed the site-wide "Contact" form at the bottom of a landing page node.
- Add a "Request a quote" contact form inline on a product or service node.
- Reference and render different contact forms per content item (sales form on one node, support form on another).
- Put a contact form inside a Layout Builder or block-referenced entity via an entity-reference field.
- Show a department contact form on a taxonomy term page (e.g. one form per office/location term).
- Render a feedback form directly in an article without writing a custom form block.
- Let editors pick which contact form appears on a page by changing a single entity-reference value.
- Display a contact form on a paragraph or media entity that has an entity-reference field.
- Replace a hand-built "contact us" webform with the core contact form embedded in content.
- Provide a "Get in touch" form section on an editorial page built from fields.
- Attach a recruitment/application enquiry form to a job listing content type.
- Surface an event-specific contact form on each event node.
- Combine with view modes to show the contact form only in the full view mode, not teasers.
- Reuse one core contact form across many nodes instead of duplicating form markup.
- Give content authors a WYSIWYG-free way to place forms by reference.
- Render a contact form in a custom entity type that has an entity-reference field.
- Show a "Contact this author" style form (non-personal) referenced from a profile-like content type.
- Build a multi-page site where each section references its own contact form.
- Keep contact-form logic in core's contact module while controlling placement through fields.
- Avoid a custom controller just to print a contact form on an entity page.
