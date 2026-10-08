Webform Entity View adds an "Entity View" webform element that renders a chosen entity (any type/bundle, in a selected view mode) inline within a webform.

---

The module provides a single Webform element plugin, `webform_entity_view` (label "Entity View", category "Entity reference elements"), extending Webform's `WebformMarkupBase`. When building a webform you add the element and configure four things in its "Entity settings": the target entity type, the target bundle, a specific entity (via an `entity_autocomplete`), and the view mode to render it with. At render time the element's `prepare()` loads that entity and renders it through the entity type's view builder (`view($entity, $view_mode, $langcode)`), translating to the webform submission's language when a translation exists. The element is a markup/display element — it collects no input and stores no submission value — so it is used to surface reference material (a node, a term, a media item, a block) inside a form. Because the entity and view mode are fixed at build time by the form author, output is static per configuration; if loading/rendering throws, the element is hidden (`#access = FALSE`) and the exception is logged. Requires the Webform module (`^5.6 || ^6`); no config schema, permissions, routes, or Drush of its own.

---

- Embed a full node render (e.g. a terms-and-conditions page) inside a webform.
- Show an informational media item or image above a set of form fields.
- Render a taxonomy term's description/fields as contextual help within a form.
- Display a promotional block or teaser between webform sections.
- Present a product/entity summary before an order or enquiry webform.
- Pick any entity type available on the site as the thing to display.
- Restrict selection to a specific bundle of the chosen entity type.
- Render the entity in a specific view mode (teaser, full, or a custom mode).
- Show the translated version of the entity matching the submission language.
- Add reusable "reference content" to multiple webforms without duplicating text.
- Insert a rendered View block entity (as an entity) into a form.
- Provide a rich, themeable alternative to a plain Markup element.
- Surface a user entity's profile fields inside a members-only form.
- Display a case-study or FAQ node inline with a feedback form.
- Use view-mode switching to control how much of the entity appears.
- Combine with Webform conditional logic to show/hide the rendered entity.
- Keep the displayed content in sync automatically as the referenced entity is edited.
- Show a call-to-action entity between a survey's pages.
- Render a document/media attachment preview within an application form.
- Provide onboarding content (rendered node) at the top of a registration webform.
