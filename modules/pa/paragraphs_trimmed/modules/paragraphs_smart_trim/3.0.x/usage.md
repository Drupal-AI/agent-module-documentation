Paragraphs Smart Trim is a submodule of Paragraphs Trimmed that trims rendered Paragraphs output using the contributed Smart Trim formatter instead of core's Trimmed formatter, giving word-based trimming, a "more" link, and Smart Trim's other options.

---

The submodule ships a single field formatter plugin, `paragraphs_smart_trim`, for `entity_reference_revisions` (Paragraphs) fields. It reuses the parent module's base class (`ParagraphsTrimmedFormatterBase`) but sets its trimmer to the contrib `smart_trim` formatter via `getTrimFormatterType()`. It renders the paragraphs in a chosen view mode, runs the markup through a `processed_text` render with the configured text format, then hands the result to Smart Trim's `viewElements()` so all of Smart Trim's own settings (trim length, trim by characters or words, suffix, more link, etc.) apply. It inherits the parent's view-mode, text-format, and optional summary-field behavior; when a named summary field has a value it is rendered instead of the trimmed output. It forces Smart Trim's `summary_handler` to `ignore` (hidden as a fixed value in the settings form). Requires `paragraphs`, `paragraphs_trimmed`, and `smart_trim`. It defines no routes, permissions, config schema, or Drush commands.

---

- Trim Paragraphs output by word count rather than raw character count.
- Add a "read more" link to a trimmed Paragraphs teaser via Smart Trim's more-link option.
- Append an ellipsis/suffix to trimmed paragraphs output.
- Render paragraphs in a chosen view mode, then trim with Smart Trim's richer options.
- Apply a text format to the rendered paragraphs before Smart Trim processes them.
- Override the auto-trim with a manual summary field on the host entity.
- Fall back to Smart Trim trimming automatically when the summary field is empty.
- Produce cleaner teasers than character trimming by respecting word boundaries.
- Build listing/card displays of Paragraphs with a consistent, link-terminated preview.
- Configure trim length and behavior through Smart Trim's formatter settings on Manage Display.
- Apply via the Manage Display UI or `core.entity_view_display.*` config.
- Use on any entity type that has a Paragraphs field.
- Choose the paragraph view mode that gets rendered and trimmed.
- Swap in for `paragraphs_trimmed` when core's character-based Trimmed formatter is too blunt.
- Support Drupal 8, 9, 10, and 11 from the same release.
