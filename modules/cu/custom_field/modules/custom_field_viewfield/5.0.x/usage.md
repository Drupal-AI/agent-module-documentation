<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Field - Viewfield adds a `viewfield` subfield type to the Custom Field module, letting a single Custom Field column reference a View (and display) so an entity can embed a view without a dedicated entity-reference field.

---

This submodule registers plugins into the parent Custom Field plugin system rather than defining new plugin types. It provides a `CustomFieldType` plugin `viewfield` (an entity reference to a `view` config entity that stores the target view id, display id and arguments), a `CustomFieldWidget` `viewfield_select` (a select widget for choosing the view/display on the entity edit form), a `CustomFieldFormatter` `viewfield_default` (which renders the referenced view's output in the field display), and a `CustomFieldFeedsType` `viewfield` target for importing view references via Feeds. Because it plugs into Custom Field, a viewfield column lives inside a normal `custom` field's `columns` storage setting (`type: viewfield`, stored as `target_type: view`), and its widget/formatter are selected per column in the Custom Field widget's `settings.fields.<column>` on the form and view displays. It depends only on `custom_field` and core `views`. Config schema for the plugin is supplied through a `hook_config_schema_info_alter()` in `src/Hook/ConfigSchemaHooks.php` rather than a `config/schema` file.

---

- Embed a View (e.g. a "related articles" listing) inside a Custom Field column on a content type.
- Add a `viewfield` column alongside other subfields (string, image, …) in one `custom` field.
- Let editors pick which View + display to render per node via the `viewfield_select` widget.
- Render the chosen view automatically in the field output with the `viewfield_default` formatter.
- Reference a view display that takes arguments and pass them from the host entity.
- Avoid creating a standalone Viewfield/entity-reference field just to show a listing.
- Combine a promo image subfield and a viewfield subfield in a single composite field.
- Build a "section" field where each item references a different view.
- Import view references into Custom Field columns through Feeds using the `viewfield` target.
- Store the view reference compactly in the single Custom Field table (no extra entity-reference tables).
- Show a block-like view listing in the body region of an entity via a formatter, not Layout Builder.
- Provide a curated "featured content" view slot editors can change per page.
- Reference views of any entity type (the target is a `view` config entity).
- Keep multiple view slots on one entity by using a multi-value Custom Field.
- Migrate legacy Viewfield (D7) data into a Custom Field viewfield column.
- Drive a landing page's dynamic regions from editor-chosen views.
- Reuse the same Custom Field across bundles, each embedding different views.
- Present a taxonomy-term page with an editor-selectable related-content view.
- Configure whether the argument/display is exposed through the select widget.
- Pair with other Custom Field formatters (table/inline) to lay out mixed subfields including a view.
