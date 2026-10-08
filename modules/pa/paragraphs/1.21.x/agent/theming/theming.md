# Theming

## Theme hooks (`paragraphs_theme()`) & templates (`templates/`)
| Theme hook | Template | Purpose |
|---|---|---|
| `paragraph` | `paragraph.html.twig` | Renders a single paragraph (like `node`). Most themes override this. |
| `paragraphs_summary` | `paragraphs-summary.html.twig` | Collapsed-item summary in the widget/formatter. |
| `paragraphs_actions` | `paragraphs-actions.html.twig` | Widget action buttons. |
| `paragraphs_add_dialog` | `paragraphs-add-dialog.html.twig` | Modal add-type dialog. |
| `paragraphs_dropbutton_wrapper` | `paragraphs-dropbutton-wrapper.html.twig` | Wraps widget dropbuttons. |
| `paragraphs_info_icon` | `paragraphs-info-icon.html.twig` | Status/info icon (e.g. unpublished). |

## Template suggestions
`paragraphs_theme_suggestions_paragraph()` adds suggestions so you can target by type and
view mode, e.g. `paragraph--<type>.html.twig`, `paragraph--<type>--<view_mode>.html.twig`.
`template_preprocess_paragraph()` provides `paragraph`, `content`, `view_mode`, and
`attributes`; behavior plugins can inject more variables via their `preprocess()`.

## View displays & the preview view mode
Each Paragraphs type has its own **Manage display** (view display) and Twig template.
The module ships a **preview** view mode (`core.entity_view_mode.paragraph.preview`) used by
the stable widget's `closed_mode: preview` (see [../configure/widget.md](../configure/widget.md));
it typically needs a custom admin theme to render usefully.

## Formatter & libraries
`ParagraphsSummaryFormatter` renders a compact field summary. Front-end/admin assets are
declared in `paragraphs.libraries.yml` (e.g. `paragraphs/drupal.paragraphs.widget`,
`drupal.paragraphs.summary`, `paragraphs-dragdrop`).
