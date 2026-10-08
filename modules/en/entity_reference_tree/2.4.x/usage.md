<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Tree is a field widget for entity reference fields that adds a searchable, hierarchical **tree picker** (a jsTree modal with checkboxes) alongside the normal autocomplete, so editors can browse and select referenced entities — especially deep taxonomy term hierarchies — instead of typing names.

---

The module provides one field widget, `entity_reference_tree` (`EntityReferenceTreeWidget`), usable on any `entity_reference` field and selected on the field's *Manage form display*. It extends core's `EntityReferenceAutocompleteWidget`, keeping the autocomplete text field but adding a **button** that opens a modal dialog (`core/drupal.dialog.ajax`) containing a jsTree rendering of the target entity type's hierarchy with checkboxes and a search box; selections are written back into the autocomplete field. The tree data is built server-side by tagged `entity_reference_tree_builder` services — `TaxonomyTreeBuilder` for `taxonomy_term` and a general `EntityTreeBuilder` for other entity types (both implementing `TreeBuilderInterface`) — and served as JSON from `/admin/entity_reference_tree/json/{entity_type}/{bundles}`; the modal search form lives at `/admin/entity_reference_tree/search/...` (access is checked with a CSRF token per widget). The widget exposes many settings (config schema `field.widget.settings.entity_reference_tree`): `theme` (jsTree theme, e.g. default / default-dark), `dots`, `worker`, `disable_animation`, `force_text`, `label` (button label), `dialog_title`, `placeholder`, `match_operator`, `match_limit`, `size`, and `autocomplete_maxlength`. A hook, `hook_entity_reference_tree_create_term_node_alter()`, lets you customize each taxonomy term's label in the tree. The bundled jsTree JavaScript library ships with the module (no separate install). There is no settings page, permission, or Drush command of its own.

---

- Let editors pick taxonomy terms from a large vocabulary by browsing its tree instead of typing.
- Add a checkbox tree picker to a node's "Categories" entity reference field.
- Select multiple referenced entities at once from a modal hierarchy.
- Replace the plain autocomplete on a deep category field with a navigable tree.
- Search within the tree to jump to a term in a big taxonomy.
- Give content authors a clearer view of parent/child relationships when referencing terms.
- Reference nodes or other entities through a tree UI when a hierarchy is meaningful.
- Use the dark jsTree theme (`default-dark`) to match a dark admin theme.
- Customize the picker button label and the modal dialog title per field.
- Limit or tune the autocomplete suggestions with `match_limit` / `match_operator`.
- Show connector dots/lines in the tree via the `dots` setting.
- Disable tree animations or enable the jsTree web worker for very large trees.
- Provide a friendlier taxonomy selection UI than the core select or autocomplete widgets.
- Let editors select an entire branch of terms quickly with checkboxes.
- Alter tree term labels (e.g. prefix roots) with `hook_entity_reference_tree_create_term_node_alter()`.
- Add a custom tree builder for a non-taxonomy entity type by tagging a service `entity_reference_tree_builder`.
- Keep autocomplete typing available while also offering the tree button.
- Improve UX for reference fields that point at hundreds of options.
- Use inside Paragraphs (the widget builds unique element ids for nested parents).
- Configure the widget entirely through exported form-display config for deployment.
- Present a consistent term picker across multiple content types by reusing the widget.
- Constrain selections to the field's configured target bundles shown in the tree.
