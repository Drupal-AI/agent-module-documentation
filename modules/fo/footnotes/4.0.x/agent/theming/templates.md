# Theme hooks & templates

`footnotes_theme()` registers four overridable Twig templates (in the module's `templates/`).
Copy one into your theme and clear caches to change footnote markup.

| Template / theme hook | Renders |
|---|---|
| `footnote-link.html.twig` | A single in-text footnote **reference** (the superscript link). |
| `footnote-links.html.twig` | The set of back-reference links for a note (used when `footnotes_collapse` produces multiple returns). |
| `footnote-list.html.twig` | The **list of footnotes** appended after the content (the footer). |
| `footnote-dialog.html.twig` | The popup body when `footnotes_dialog` is enabled. |

## Overriding

1. Copy the template into your theme's `templates/` directory.
2. Adjust markup/classes as needed (variables mirror the default templates — references,
   numbers, back-links, note content).
3. `drush cr`.

## Other theming-related pieces

- **CSS libraries:** `footnotes/footnotes` (base `footnotes.css`, attached when
  `footnotes_css` is on), `footnotes.dialog` (dialog styles/JS), and
  `footnotes.group_block_via_js` (client grouping for the block).
- **Twig extension:** `footnotes.twig.FallbackSpacelessTwig`
  (`\Drupal\footnotes\Twig\FootnotesSpacelessTwig`) provides a spaceless fallback used while
  rendering footnote markup.
- **Extra field:** the `footnotes` pseudo-field (see [../plugins/block.md](../plugins/block.md))
  lets you position the notes list in *Manage display*.
