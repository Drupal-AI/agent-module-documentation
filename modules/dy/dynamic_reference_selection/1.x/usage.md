<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic Reference Selection lets one entity-reference field's options depend on the value chosen in another (parent) field, using a View as the data source with an AJAX refresh.

---

Install the module (it needs core **Views** enabled; Views is required at runtime but not declared in the module's `info.yml`, so enable it yourself). The pattern is Country → City, Genre → Song, and similar cascading selects. First build a **View** on the *child* entity type with an **Entity Reference** display whose first **contextual filter** accepts the parent value (an entity ID, or a UUID). Then on the child reference field's settings choose **Reference method → "Dynamic Reference Selection: Make field dependent using views"** (`dynamic_reference_selection_views`), pick that **View + display**, choose the **Parent field** it depends on, optionally tick **Reference parent by UUID** (when the view's argument expects UUIDs), and optionally add extra comma-separated **View arguments** appended after the parent value. In **Manage form display**, set **both** the parent and child widgets to **Select list** or **Check boxes/radio buttons** (the handler warns it does not fully work with the autocomplete widget). At runtime the parent value is passed as the view's first argument to compute the child's options; when the parent changes, an attached `#ajax` callback re-runs the view and rebuilds the child `<select>`/checkboxes/radios in place while preserving any still-valid selection. Multi-value child fields and Paragraphs subforms are supported. Note that the list of allowed targets is defined entirely by the **View** you configure, so use the view's own filters and access settings to control which entities are offered.

---

- Build cascading (dependent) select lists such as Country → City.
- Filter a child reference field's options by a parent field's value.
- Use a Views Entity Reference display as the source of referenceable entities.
- Refresh child options over AJAX when the parent selection changes.
- Configure the dependency entirely in the child field's reference-method settings.
- Map a parent field as the first contextual-filter argument of the view.
- Pass extra static arguments to the view after the parent value.
- Reference the parent by UUID instead of entity ID for config portability.
- Support multi-value parent fields (values are passed as a comma list).
- Keep multi-value child fields multiple even when they start with no options.
- Work with Select list and Check boxes/radio buttons widgets.
- Support Paragraphs subforms (resolves the nearest nested paragraph).
- Replace the unmaintained Business Rules Entity Reference Selection plugin.
- Offer a Drupal 11-compatible alternative to Dependent Field / Dependant Reference Method.
- Validate submitted targets against what the current parent value allows.
- Sort child options alphabetically with a leading "-Select-" placeholder.
- Alter the built reference element via the `dynamic_reference_selection.form_field_alter` event.
- Extend behaviour with a custom `DynamicReferenceSelectionReactsOn` plugin.
- Rely on the configured View's filters and access for which entities are offered.
- Add cascading references without a full rules engine.
