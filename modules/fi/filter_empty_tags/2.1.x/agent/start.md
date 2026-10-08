# filter_empty_tags — agent start

Provides one text-format **filter** plugin, `filter_empty_tags` (class `FilterEmptyTags`,
type `TYPE_TRANSFORM_IRREVERSIBLE`), that recursively removes empty HTML tags (tags whose
content is only whitespace / `&nbsp;` / `<br>`) at render time. Enable + order it inside a
text format. No permissions, admin page, or Drush; core-only. Should generally run **last**.

- Enable, ordering, the four settings, and how matching works → [configure/filter_empty_tags.md](configure/filter_empty_tags.md)
