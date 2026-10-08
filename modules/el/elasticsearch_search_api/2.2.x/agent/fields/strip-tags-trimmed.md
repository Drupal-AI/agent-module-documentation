# Field formatter: strip_tags_trimmed

`src/Plugin/Field/FieldFormatter/StripTagsAndTrimmedFormatter.php` — formatter id `strip_tags_trimmed`,
label "Strip tags and trim". Applies to field types `text`, `text_long`, `text_with_summary`.

Extends core `TextTrimmedFormatter`, so it inherits the trim-length setting, then runs
`strip_tags($text, '<p>')` on each element — keeping only `<p>` tags. Intended for rendering body/summary
text as a search-result snippet (plain-ish text, no markup except paragraphs).

Select it on a Manage-display screen (e.g. the `search_index` view mode that this module adds to every node
type — see [../theme/templates.md](../theme/templates.md)) for a text field. No formatter settings beyond
the inherited trim length.
