# filter_empty_tags — configure (per text format)

No module settings page. Configure inside a text format:
**Configuration → Content authoring → Text formats and editors** → edit a format.

## Enable + order
1. In **Enabled filters**, tick **Filter Empty Tags**.
2. In **Filter processing order**, drag it to run **last** (recommended), after any other
   HTML filters, so it cleans up their output.
3. Configure its settings (below), then **Save configuration**.

## Settings (`FilterEmptyTags` plugin defaults)
| Setting | Default | Effect |
|---|---|---|
| `do_not_consider_empty` | `button canvas drupal-media drupal-entity iframe object script svg textarea td th` | Space-separated list of tag names that are **never** removed even when empty. Newlines/double spaces are normalised to single spaces on save. |
| `filter_spaces` | `TRUE` | Tags containing only whitespace count as empty. |
| `filter_nbsp` | `TRUE` | Tags containing only `&nbsp;` (or `\xc2\xa0`) count as empty. |
| `filter_br` | `TRUE` | Tags containing only `<br>` / `<br/>` / `<br />` count as empty. |

Config schema: `config/schema/filter_empty_tags.schema.yml`.

## How it works (`process`)
- Builds a regex from the enabled toggles matching `<tag ...>...</tag>` where the inner
  content is only the "empty" characters.
- Removes each matched tag not in `do_not_consider_empty`, then **re-runs `process()`** on
  the result until no further change — this collapses nested empty structures
  (e.g. `<div><p></p></div>`) that a single regex pass would miss.
- Type is `TYPE_TRANSFORM_IRREVERSIBLE`, so it transforms the rendered output (not the stored
  source) and cannot be undone — order it after other filters.

## Notes
- Add a tag to `do_not_consider_empty` to protect legitimately-empty elements (embeds,
  `<iframe>`, `<td>`, `<svg>`, media placeholders, etc.).
- It removes only the configured "empty" cases; tags with real content are untouched.
