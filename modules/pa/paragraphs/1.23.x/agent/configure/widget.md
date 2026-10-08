# Configure — Paragraphs field widget

Set on the host entity's **form display** (Manage form display) for the Entity Reference
Revisions field. Two widgets ship:

- **`paragraphs`** (Stable, formerly Experimental) — the default/recommended widget:
  duplicate, add-above, collapse, preview, and drag-and-drop reordering across nesting
  levels. Class `Drupal\paragraphs\Plugin\Field\FieldWidget\ParagraphsWidget`.
- **`entity_reference_paragraphs`** (Legacy/Classic) — stable but frozen, limited features.
  Class `InlineParagraphsWidget`.

## Stable widget settings (`field.widget.settings.paragraphs`)
Defaults from `ParagraphsWidget::defaultSettings()`:

| Setting | Default | Meaning |
|---|---|---|
| `title` / `title_plural` | Paragraph / Paragraphs | Noun shown in buttons/messages |
| `edit_mode` | `open` | `open`, `closed`, or `closed_expand_nested` |
| `closed_mode` | `summary` | How closed items render: `summary` or `preview` |
| `autocollapse` | `none` | Auto-collapse other items while editing one |
| `closed_mode_threshold` | `0` | Item count before items start closed |
| `add_mode` | `dropdown` | Add UI: `dropdown`, `select`, `button`, or `modal` |
| `form_display_mode` | `default` | Which form display to edit paragraphs with |
| `default_paragraph_type` | `''` | Type auto-added on new host entities |
| `features` | `duplicate`, `collapse_edit_all` | Optional buttons (also `add_above`) |

`preview` closed mode renders the paragraph in the **preview** view mode (shipped in
`config/install`, typically needs a custom admin theme).

## Drag & drop
The stable widget offers a drag-drop mode that reorders paragraphs within and *between*
nesting levels; collapsed items show a compact summary. The `core/sortable` library
(bundled with Drupal core) powers it — no extra install needed.

## Allowed types
On the field's **reference settings** (`ParagraphSelection`,
`entity_reference_selection.default:paragraph`) select `target_bundles`, order them
(`target_bundles_drag_drop`), `negate`, and a `default_paragraph_type`.
