# Block title link settings

No dedicated admin page. Settings appear on each block's configuration form (e.g.
`/admin/structure/block/manage/<block_id>`) in a collapsed **Block Title Link Settings** details
group placed in the form's `advanced` region. Added by `block_title_link_form_block_form_alter()`.

Stored in the block config's `third_party_settings.block_title_link`:

| Field | Key | Type | Notes |
|---|---|---|---|
| Title Link Url | `title_link_url` | entity_autocomplete (target `node`) | Accepts a node autocomplete selection or a generic URI; validated by `\Drupal\link\Plugin\Field\FieldWidget\LinkWidget::validateUriElement` (stored as `entity:node/ID`, `internal:/path`, or an external URL) |
| Link Title | `link_title` | textfield | Becomes the `title` attribute (tooltip) on the rendered link |
| Link Target | `title_link_target` | select | `_blank`, `_self`, `_parent`, `_top` (empty = none) → `target` attribute |
| Enable | `title_link_enable` | checkbox | Master switch; when off the label renders normally |

## Rendering
`block_title_link_preprocess_block()` runs for blocks that have an `#id` and `title_link_enable` set.
It swaps `$variables['label']` for:

```php
[
  '#type' => 'link',
  '#title' => $original_label,
  '#url' => \Drupal\Core\Url::fromUri($title_link_url),
  '#attributes' => ['target' => $title_link_target, 'title' => $link_title],
]
```

Notes:
- The URL is stored as a URI string; `Url::fromUri()` requires a scheme (`entity:`, `internal:`,
  `http(s):`), which is exactly what `validateUriElement` produces — do not store a bare path.
- No config schema ships, so the third-party settings are stored but not schema-validated.
- There is nothing to configure globally; behavior is entirely per block.
