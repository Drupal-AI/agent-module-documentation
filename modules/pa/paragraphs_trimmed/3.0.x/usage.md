Paragraphs Trimmed adds a field formatter for Paragraphs (entity_reference_revisions) fields that renders the referenced paragraphs and then trims that rendered output to a summary length, the way core's Trimmed formatter trims a long text field.

---

The module ships a single field formatter plugin, `paragraphs_trimmed`, that applies to `entity_reference_revisions` fields (the field type Paragraphs uses). It works by rendering the paragraphs in a chosen view mode to HTML, then feeding that HTML through core's Trimmed (`text_trimmed`) text formatter to cut it to a length. On Manage Display you pick the paragraph view mode to render, a text format to apply to the rendered markup before trimming (default Full HTML), and the trim length inherited from the core Trimmed formatter (default 600). It also offers an optional "Summary Field" setting: if you name another field on the host entity and that field has a value, its value is rendered instead of the trimmed paragraphs, giving editors a manual teaser override. The formatter extends `EntityReferenceRevisionsEntityFormatter` and inherits its view-mode and link settings. The module defines no routes, permissions, services, config schema, `.install`, or Drush commands; it is pure display configuration. Its bundled submodule `paragraphs_smart_trim` swaps the core Trimmed trimmer for the contributed Smart Trim formatter.

---

- Show a short teaser of a Paragraphs field on a listing/teaser view mode while the full field shows on the full page.
- Trim rendered paragraphs to a character length like core's Trimmed formatter does for long text.
- Render paragraphs in a specific view mode and cut the resulting markup to a summary.
- Apply a text format (e.g. Full HTML) to the rendered paragraphs before trimming.
- Provide a "read more" style summary of complex paragraph content without hand-authoring it.
- Let editors override the auto-trim with a dedicated summary field on the entity.
- Fall back to trimmed output automatically when the chosen summary field is empty.
- Build a card/grid listing where each item shows a capped preview of its paragraphs.
- Keep search-result or RSS displays short by trimming heavy paragraph layouts.
- Reuse an existing view mode for full display and add a trimmed one for compact contexts.
- Configure the trim length per display via the inherited Trimmed formatter setting.
- Present a landing-page intro block that shows only the opening of a long paragraphs body.
- Avoid custom preprocess/Twig just to shorten paragraphs output.
- Apply the formatter through the Manage Display UI or via `core.entity_view_display.*` config.
- Use it on nodes, taxonomy terms, media, users, or any entity that has a Paragraphs field.
- Pick any configurable field on the entity as the summary override source.
- Combine with different view modes to control how much paragraph markup is trimmed.
- Support Drupal 8, 9, 10, and 11 from the same release.
- Serve as the base for `paragraphs_smart_trim` when word-based or "more link" trimming is needed.
- Standardize teaser rendering of paragraphs across many content types.
