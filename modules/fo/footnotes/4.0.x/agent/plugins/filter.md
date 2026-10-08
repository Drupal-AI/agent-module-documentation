# The `filter_footnotes` text filter

Class `\Drupal\footnotes\Plugin\Filter\FootnotesFilter`. This is the piece that turns the
`<footnotes>` markup an editor inserts into numbered references + a notes list at display time.

```
@Filter(
  id = "filter_footnotes",
  module = "footnotes",
  type = TYPE_TRANSFORM_IRREVERSIBLE,
  cache = FALSE,
)
```

Because it is `TYPE_TRANSFORM_IRREVERSIBLE`, it must run when text is displayed and cannot be
reversed to the source. It auto-numbers footnotes with a static counter as they are processed.

## Settings (schema `filter_settings.filter_footnotes`)

| Setting | Default | Effect |
|---|---|---|
| `footnotes_collapse` | `false` | Merge footnotes whose content is identical into one number, with multiple back-reference links. |
| `footnotes_css` | `true` | Attach the bundled `footnotes/footnotes` CSS library. Turn off if your theme styles footnotes. |
| `footnotes_dialog` | `false` | Show each note in a popup dialog on click (attaches `footnotes.dialog` library) instead of scrolling to the footer. |
| `footnotes_dialog_prevent_bubbling` | `false` | When dialogs are on, stop the click event from bubbling. |
| `footnotes_footer_disable` | `false` | Do **not** append the inline footnotes list after the text. Use with the Footnotes Group block or the "footnotes" extra field to render notes elsewhere. Requires a cache clear to take effect. |
| `footnotes_preview_show_text` | `true` | Show the reference text in the CKEditor live preview. |
| `footnotes_preview_character` | `''` | Override the character shown as the footnote marker in the preview. |

## How it renders

- Each footnote marker in the body becomes a superscript reference link (numbered in order).
- A footnotes list is appended after the content (unless `footnotes_footer_disable`).
- Duplicate content is collapsed when `footnotes_collapse` is on, producing shared numbers and
  multiple return links.
- Markup is built from overridable Twig templates: `footnote-link`, `footnote-links`,
  `footnote-list`, `footnote-dialog` (see [../theming/templates.md](../theming/templates.md)).

## Setting it in config

```bash
drush cset filter.format.footnote filters.filter_footnotes.status true -y
drush cset filter.format.footnote filters.filter_footnotes.settings.footnotes_collapse true -y
drush cset filter.format.footnote filters.filter_footnotes.settings.footnotes_footer_disable true -y
```

Filter ordering matters: `footnotes_is_footnotes_later()` checks whether other filters run
after it. Keep `filter_footnotes` where its output HTML is not stripped by a later
"Limit allowed HTML tags" filter.

## Related: Search API processor

`footnotes_ignore_citations` (`@SearchApiProcessor`, label "Ignore citations") strips footnote
text from indexed values so citations do not pollute search relevance. Enable it on a Search
API index's *Processors* tab.
