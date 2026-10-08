Filter Empty Tags is a text-format filter that recursively strips empty HTML tags (tags containing only whitespace, non-breaking spaces, and/or `<br>`) from content as it is rendered, so stray markup like `<p><b></b></p>` doesn't clutter your output.

---

The module provides a single `@Filter` plugin, `filter_empty_tags` (type
`TYPE_TRANSFORM_IRREVERSIBLE`), that you enable and order within any text format at
**Configuration → Content authoring → Text formats and editors**. During `process()` it runs
a regular expression that matches tags whose entire inner content is "empty" per the filter's
settings, removes those tags (opening + closing), and then re-runs itself on the result so
that nested/recursive empty structures (e.g. `<div><p></p></div>`) collapse fully — going
beyond what a single regex could do. Four settings control what counts as empty: a
space-separated list of **non-filterable tags** to never remove (default includes
`button canvas drupal-media drupal-entity iframe object script svg textarea td th`), and
three toggles for whether tags containing only **spaces**, only **non-breaking spaces
(`&nbsp;`)**, and/or only **`<br>`** are considered empty (all default on). Because it is an
irreversible transform filter, it should generally run **last**, after other HTML filters, so
it cleans up whatever markup they produce. It has no permissions, admin page, or Drush of its
own; configuration lives entirely inside each text format. Requires no modules outside core.

---

- Remove leftover empty tags like `<p></p>` or `<b></b>` from rendered content.
- Clean up markup from nightly/automated content imports that leave empty elements.
- Strip trailing empty paragraphs that contributors add at the end of a body field.
- Collapse nested empty structures (e.g. `<div><p><br></p></div>`) recursively.
- Treat paragraphs containing only `&nbsp;` as empty and remove them.
- Treat tags containing only `<br>` as empty and remove them.
- Treat whitespace-only tags as empty and remove them.
- Keep certain empty tags (e.g. `<iframe>`, `<svg>`, `<td>`) by listing them as non-filterable.
- Preserve empty `drupal-media`/`drupal-entity` embed placeholders while cleaning other tags.
- Prevent CSS spacing artifacts caused by stray empty block elements.
- Tidy WYSIWYG/CKEditor output before display without editing source content.
- Apply to a specific text format (e.g. Full HTML) while leaving others untouched.
- Run as the final filter after other HTML-altering filters in a format.
- Reduce visual gaps in templates caused by empty editorial markup.
- Normalise imported HTML that has no clean-up step at the source.
- Avoid manually re-editing hundreds of nodes to remove empty tags.
- Keep table cells (`<td>`, `<th>`) intact even when empty.
- Preserve interactive/embed tags (`button`, `object`, `textarea`) that are legitimately empty.
- Improve accessibility/semantics by removing meaningless empty elements from output.
