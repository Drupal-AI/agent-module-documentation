Paragraphs Browser adds a form widget for Paragraphs Entity Reference Revisions fields that opens a modal "browser" where editors pick a paragraph type from user-defined, filterable groups, each type optionally showing a preview image and description.

---

The module extends the Paragraphs module's inline widgets with two field widgets ("Paragraphs Browser EXPERIMENTAL" id `paragraphs_browser`, and "Paragraphs Browser Classic" id `entity_reference_paragraphs_browser`) for `entity_reference_revisions` fields. Instead of the default paragraph-type dropdown/buttons, editors get a modal dialog (built on `core/drupal.dialog.ajax` and `core/once`) that lists available paragraph types grouped into categories. You define one or more Browser Types (config entity `paragraphs_browser_type`) at Structure » Paragraph Types » Manage Browsers; each browser holds an ordered set of Groups (e.g. Layouts, Media, Text). Paragraph types are then assigned to groups per browser via the "Configure Groups" tab on each paragraph type, stored in the browser type's `map`. A per-field setting selects which browser a widget uses, so the same paragraph types can be organized differently across fields. Each paragraph type also gains third-party settings on its own entity — a `description` and an `image_path` (uploaded or path-based, defaulting to the Paragraphs icon) — surfaced through a fieldset added to the paragraph type edit form; these drive the browser's visual preview cards. Two Twig templates (`paragraphs-browser-wrapper` and `paragraphs-browser-paragraph-type`) render the browser and its cards. Administration of browsers and groups is gated by the core Paragraphs "administer paragraphs types" permission.

---

- Give content editors a visual, image-driven picker for choosing which paragraph type to add instead of a plain dropdown.
- Organize a large library of paragraph types into filterable groups (Banners, Galleries, Slideshows, Text, Media, Lists).
- Present layout paragraph types (single-column vs multi-column) as grouped, browsable options.
- Attach a thumbnail/preview image to each paragraph type so editors recognize components visually.
- Add a short description to each paragraph type explaining when to use it.
- Define multiple browser types so different fields expose different subsets/orderings of the same paragraph types.
- Use a "Layouts" browser on a main content field and a "Media" browser on a sidebar field.
- Reduce editor confusion on sites with dozens of paragraph types by categorizing them.
- Replace the default Paragraphs add widget with a modal browser to save vertical space in long forms.
- Let editors filter paragraph types by group inside the modal to find components faster.
- Reorder groups within a browser to surface the most-used component categories first.
- Reassign a paragraph type from one group to another without changing the paragraph type itself.
- Reuse the same paragraph type in several groups/browsers via per-browser mapping.
- Upload paragraph preview images directly through the paragraph type edit form when you lack server file access.
- Reference an existing image by relative public-file path for a paragraph type preview.
- Provide a curated component-selection experience for marketing/landing-page building with Paragraphs.
- Onboard non-technical authors with a friendlier "add component" experience.
- Standardize how new paragraphs are added across a multi-editor team.
- Keep experimental (extends ParagraphsWidget) vs classic (extends InlineParagraphsWidget) behavior available depending on your Paragraphs setup.
- Theme the browser and its cards via the provided Twig templates for brand-consistent selection UIs.
- Configure browsers entirely through the admin UI at Structure » Paragraph Types » Manage Browsers.
- Ship a default "Content" browser type (installed config) as a starting point.
- Restrict browser/group administration to users with "administer paragraphs types".
- Build a design-system component gallery inside the node edit form.
