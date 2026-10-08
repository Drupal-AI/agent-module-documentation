Gutenberg Content Embed adds Gutenberg editor blocks that let editors search for and embed existing Drupal node content (rendered in a chosen view mode) into Gutenberg-authored pages; admins control which content types and view modes are embeddable per bundle.

---

The module extends the Gutenberg editor: `hook_library_info_alter` injects its editor JS (a "Drupal content embed" block component) and CSS into Gutenberg's `edit-node` library. Two JSON routes, both requiring the `use gutenberg` permission, back the editor UI — `/editor/search-content/{type}/{search}` returns published nodes of a type whose title contains the search text (entity query with `accessCheck(TRUE)`), and `/editor/content/load/{nid}/{viewmode}` renders a node in a view mode and returns the HTML (after `$node->access('view')`). On the front end, a tagged `gutenberg_block_processor` service (`DrupalContentProcessor`, priority 50) replaces the stored block with the referenced node rendered via the entity view builder (again gated by `access('view')`), wrapping it with content-embed CSS classes and optional alignment/width classes. Per-content-type configuration is added to the node-type "Gutenberg experience" form (via `hook_form_alter`): admins pick, per bundle, which view modes are allowed for embedding and which offer width control; the choices are stored in `gutenberg_content_embed.settings:allowed_content_embed` and passed to the editor through `drupalSettings`. There is no standalone settings page (config lives on each content type's edit form) and no permissions of its own beyond Gutenberg's `use gutenberg`.

---

- Let editors embed an existing article inside a Gutenberg-built landing page.
- Search published nodes by title from within the Gutenberg editor.
- Render an embedded node in a specific view mode (teaser, full, or a custom mode).
- Restrict which content types are embeddable per bundle via the Gutenberg experience settings.
- Restrict which view modes are offered for embedding per content type.
- Offer width control (alignment/width classes) for selected view modes.
- Reuse a single canonical node across many Gutenberg pages instead of duplicating content.
- Keep embedded content in sync — it renders live through the view builder, not a copy.
- Respect node view access on both the editor preview and the rendered front end.
- Build promo/landing pages that pull in existing team, product, or event nodes.
- Style embedded content consistently with the module's `content-embed` CSS classes.
- Add per-bundle embed configuration without a separate admin page (it's on the type form).
- Expose allowed content configuration to the editor JS via drupalSettings.
- Limit embedding to editors who hold Gutenberg's `use gutenberg` permission.
- Return only published nodes in the editor search results.
- Integrate as a Gutenberg block processor so embeds resolve at render time.
