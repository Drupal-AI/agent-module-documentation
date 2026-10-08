A demo/example submodule of Paragraphs Inline Entity Form that installs a ready-made content type, several paragraph types, an embed-enabled text format and a configured CKEditor 5 editor so you can immediately try the inline-paragraph embedding workflow.

---

This submodule is pure configuration scaffolding — it ships **no PHP code**, only `config/install`
and `config/optional` YAML plus demo images. On enable it creates a `paragraphs_ief_example` node
type with a body and a paragraph-reference field, and a set of example paragraph types
(`paragraphs_ief_text`, `paragraphs_ief_image`, `paragraphs_ief_gallery`, `paragraphs_ief_columns`,
`paragraphs_ief_view`, and social/embed types for Facebook, Twitter, Instagram, YouTube), each with
their own fields, default form and view displays, and preview view modes. It also installs a
`paragraphs_ief_example` text format wired to CKEditor 5 with the parent module's Paragraphs embed
button and the "Display embedded entities" filter, and an `embed` filter format — giving a
working end-to-end example of embedding paragraphs in a rich-text body. Intended for evaluation,
demos and functional tests, not production. Enable with `drush en paragraphs_inline_entity_form_example`.

---

- Evaluate the Paragraphs-in-WYSIWYG workflow without hand-building content types.
- Get a preconfigured `paragraphs_ief_example` content type with an embed-ready body.
- See example paragraph types (text, image, gallery, columns, view, social embeds) already set up.
- Inspect a correctly configured CKEditor 5 text format with the Paragraphs embed button enabled.
- Copy the example's Allowed-HTML / `<drupal-entity>` filter settings into your own format.
- Demo inline paragraph embedding to stakeholders quickly.
- Provide a baseline for the module's functional tests.
- Learn the required embed button + entity browser + filter configuration by example.
- Try embedding a gallery or columns paragraph inside article body text.
- Try embedding social media (YouTube/Twitter/Instagram/Facebook) paragraphs in content.
- Reference working default form/view displays and preview view modes for paragraph types.
- Use as a starting point to clone and rename paragraph types for a real project.
- Reproduce issues against a known-good configuration when filing bug reports.
- Understand how the `view_mode:paragraph.preview` display is used for embedded previews.
- Bootstrap a local sandbox for training content editors on the feature.
