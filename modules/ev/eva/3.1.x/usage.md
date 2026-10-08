EVA (Entity Views Attachment) provides a Views display type that attaches the output of a View to the content of any Drupal entity (node, user, taxonomy term, comment, etc.), where it renders as a pseudo-field on the entity's display.

---

EVA adds a Views display plugin (id `entity_view`, label "EVA") that, instead of having its own page or block, binds a view display to a content entity type and optionally specific bundles. When enabled, `hook_entity_extra_field_info()` exposes each EVA display as an extra (pseudo) field on the chosen entity's "Manage display" page, so site builders can position it among the entity's real fields and reorder or disable it per view mode. At render time `hook_entity_view()` finds the attached view, sets its display, and — based on the display's **Arguments** mode — passes the current entity as a contextual filter argument: `id` mode passes the entity's ID, `token` mode replaces a slash-separated token string (e.g. `[node:author:uid]`) against the entity and passes the results, and `None` passes nothing. The display exposes options for entity type, bundles, show title, hide-if-empty, and disable-by-default, all stored under the `views.display.entity_view` config schema. If the view uses an exposed filter, EVA can render the exposed form as a second pseudo-field. EVA depends only on core Views; the optional `drupal/token` module adds a token browser to the arguments form. It keeps view configuration clean by removing its own dependency from a view when its last EVA display is deleted, and clears stale EVA pseudo-fields from entity displays on view save, module enable/disable.

---

- Show a "More by this author" view on user profile pages, passing the user ID as the argument.
- Attach a "Related articles" view to a node page, filtered by the node's taxonomy terms via a token argument.
- Display a list of a taxonomy term's children or tagged content directly on the term page.
- Render an entity's comments or related media through a view embedded in the entity display.
- Add a view of an author's recent posts under each node, using `[node:author:uid]` as a token argument.
- Place a view among a content type's fields on "Manage display" and reorder it like any other field.
- Attach the same view to only selected bundles of an entity type instead of all bundles.
- Turn an EVA field off in specific view modes (e.g. show it on full view but not teaser).
- Pass the current entity's ID directly to a view's contextual filter without writing custom code.
- Use token replacement to send multiple arguments to a view (separate with `/`).
- Show the view's title above its output on the entity page via the "Show title" option.
- Hide the attached view entirely when it returns no results using "Hide output if the view is empty".
- Add new EVA fields to the "disabled" region by default so editors opt them in per display.
- Render a view's exposed filter form as its own pseudo-field alongside the results.
- Build a per-entity dashboard by attaching several EVA displays to one entity type.
- Attach a view to core `user`, `node`, `comment`, `taxonomy_term`, or any content entity type.
- Replace custom "related content" block code with a configurable, view-driven attachment.
- Theme the attachment with the `eva_display_entity_view` template and per-view/per-display suggestions.
- Provide contextual data on an entity page (stats, listings) sourced from a view rather than a field.
- Keep view config tidy — EVA drops its module dependency automatically when its last EVA display is removed.
- Programmatically list all EVA attachments via the `eva.view_displays` service.
- Add a token browser to the argument field by installing the optional `drupal/token` module.
- Attach a view to an entity type but scope it to a single bundle for targeted listings.
- Vary output per entity with an argument-based render cache key so multiple EVAs on a page cache correctly.
