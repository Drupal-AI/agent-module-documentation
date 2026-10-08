<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundles, fields and how to wire them up

`configure: null` — there is **no settings form**. Configuration = the `bp_*` paragraph types,
their fields, and the paragraphs reference field you attach to your own content type.

## The bundles and their distinctive fields

Every bundle below also gets the shared style fields (see next section) unless noted.
"Distinctive" = the fields that are unique to that bundle.

| Bundle id | Label | Distinctive fields (type, cardinality) |
|---|---|---|
| `bp_simple` | Simple | `bp_text` (text_long, 1) |
| `bp_blank` | Blank | `bp_unrestricted` (text_long, 1) — meant for a Full HTML / no-editor format |
| `bp_image` | Image | `bp_image_field` (image, 1), `bp_link` (link, 1) |
| `bp_block` | Drupal Block | `bp_block` (entity_reference → block_content, unlimited) |
| `bp_view` | View | `bp_view` (viewsreference, unlimited) |
| `bp_columns` | Columns (Equal) | `bp_column_content` (entity_reference_revisions, **max 6**) |
| `bp_columns_two_uneven` | Columns (Two Uneven) | `bp_column_content_2` (err, **max 2**), `bp_column_style_2` (list_string, 1) |
| `bp_columns_three_uneven` | Columns (Three Uneven) | `bp_column_content_3` (err, **max 3**), `bp_column_style_3` (list_string, 1) |
| `bp_column_wrapper` | Column Wrapper | `bp_column_content_w` (err, unlimited). **Only** `bp_margin` + `bp_padding` — no background/width/header |
| `bp_carousel` | Carousel | `bp_slide_content` (err, unlimited), `bp_slide_interval` (list_string, 1). No `bp_header` |
| `bp_accordion` | Accordion | `bp_accordion_section` (err → `bp_accordion_section`), `bp_accordion_expand` (boolean), `bp_always_show` (boolean), `bp_show_indicators` (boolean) |
| `bp_accordion_section` | Accordion Section | `bp_accordion_section_title` (string), `bp_accordion_section_body` (err, unlimited), `bp_show_button` (boolean). **No style fields** |
| `bp_tabs` | Tabs | `bp_tab_section` (err → `bp_tab_section`) |
| `bp_tab_section` | Tab Section | `bp_tab_section_title` (string), `bp_tab_section_body` (err, unlimited). **No style fields** |
| `bp_modal` | Modal | `bp_modal_title`, `bp_modal_button_text` (string), `bp_modal_body`, `bp_modal_footer` (err, unlimited) |

`err` = `entity_reference_revisions`. `bp_accordion_section` and `bp_tab_section` are
**children only** — do not offer them on a top-level node field.

## Shared style fields (the whole styling model)

All `list_string`, cardinality 1, stored on the paragraph. The **stored value is the CSS class
string**, and the view display renders them with the `list_key` formatter so the template can
read the raw value.

| Field | Values (value → label) |
|---|---|
| `bp_width` | `paragraph--width--tiny` Tiny · `--narrow` Narrow · `--medium` Medium · `--wide` Wide · `--full` Full Screen |
| `bp_margin` | `mt-1 mb-1` / `mt-3 mb-3` / `mt-5 mb-5` (Top and Bottom S/M/L) · `mt-1`,`mt-3`,`mt-5` (Top S/M/L) · `mb-1`,`mb-3`,`mb-5` (Bottom S/M/L) |
| `bp_padding` | same shape with `pt-*` / `pb-*` |
| `bp_background` | 58 options. Brand: `paragraph--color paragraph--color--primary` (also `secondary`, `success`, `info`, `warning`, `danger`). RGBA family: `paragraph--color paragraph--color--rgba-<hue>-<slight\|light\|strong>` for black, blue, bluegrey, …, teal, white, yellow. Plus `paragraph--color--transparent` |
| `bp_header` | plain `string`, rendered as `<h2>` by the templates |
| `bp_column_style_2` | `paragraph--style--75-25`, `--66-33`, `--25-75`, `--33-66` |
| `bp_column_style_3` | `paragraph--style--25-50-25`, `--50-25-25`, `--25-25-50`, `--16-66-16`, `--66-16-16`, `--16-16-66` |
| `bp_slide_interval` | `false` (None), `1000`…`7000` (1–7 Seconds) |

On the **form display** the four style fields are collected into a closed `details`
`field_group` named `group_styles` labelled "Styles" (`third_party_settings.field_group` in
`core.entity_form_display.paragraph.<bundle>.default`).

## Config object names

```
paragraphs.paragraphs_type.<bundle>                          # the bundle (id + label only)
field.storage.paragraph.<field>                              # storage + allowed_values
field.field.paragraph.<bundle>.<field>                       # instance + handler settings
core.entity_form_display.paragraph.<bundle>.default
core.entity_view_display.paragraph.<bundle>.default
```

Read one:

```bash
drush cget field.storage.paragraph.bp_width settings.allowed_values
drush cget core.entity_view_display.paragraph.bp_simple.default content.bp_margin
drush cget field.field.paragraph.bp_columns.bp_column_content settings.handler_settings.target_bundles
```

All 167 files ship in `config/optional/`, so they install only when their dependencies exist
and are **not reverted** on later module updates — after install they are site config.

## Nesting allow-lists

Container fields restrict what can be dropped inside them via
`settings.handler_settings.target_bundles`:

- `bp_columns.bp_column_content`, `bp_column_wrapper.bp_column_content_w`,
  `bp_carousel.bp_slide_content` (and the two/three-uneven equivalents) allow
  `bp_simple, bp_image, bp_blank, bp_accordion, bp_carousel, bp_column_wrapper, bp_columns,
  bp_columns_two_uneven, bp_columns_three_uneven, bp_block, bp_modal, bp_tabs, bp_view`.
- `bp_accordion.bp_accordion_section` allows **only** `bp_accordion_section`;
  `bp_tabs.bp_tab_section` allows **only** `bp_tab_section`.

The widget used for these is `entity_reference_paragraphs` with
`edit_mode: closed`, `add_mode: dropdown`.

## Attach a paragraphs field to a content type

The module does **not** do this for you. Create an `entity_reference_revisions` field on your
node bundle, cardinality unlimited, target type `paragraph`, and allow the bundles you want:

```php
// drush php:eval
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_page_sections',
  'entity_type' => 'node',
  'type' => 'entity_reference_revisions',
  'settings' => ['target_type' => 'paragraph'],
  'cardinality' => -1,
])->save();

FieldConfig::create([
  'field_name' => 'field_page_sections',
  'entity_type' => 'node',
  'bundle' => 'page',
  'label' => 'Sections',
  'settings' => [
    'handler' => 'default:paragraph',
    'handler_settings' => [
      'target_bundles' => ['bp_simple' => 'bp_simple', 'bp_image' => 'bp_image', 'bp_columns' => 'bp_columns'],
      'negate' => 0,
    ],
  ],
])->save();

$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.page.default');
$fd->setComponent('field_page_sections', [
  'type' => 'entity_reference_paragraphs',
  'region' => 'content',
  'weight' => 10,
  'settings' => ['edit_mode' => 'closed', 'add_mode' => 'dropdown', 'form_display_mode' => 'default', 'title' => 'Section', 'title_plural' => 'Sections', 'default_paragraph_type' => '_none'],
])->save();
```

Do **not** list `bp_accordion_section` / `bp_tab_section` in a node-level `target_bundles`.

## Create a paragraph programmatically

```php
use Drupal\paragraphs\Entity\Paragraph;

$p = Paragraph::create([
  'type' => 'bp_simple',
  'bp_header' => 'Welcome',
  'bp_text' => ['value' => '<p>Hello</p>', 'format' => 'basic_html'],
  'bp_background' => 'paragraph--color paragraph--color--primary',
  'bp_width' => 'paragraph--width--narrow',
  'bp_margin' => 'mt-3 mb-3',
  'bp_padding' => 'pt-3 pb-3',
]);
$p->save();

$node->set('field_page_sections', [['target_id' => $p->id(), 'target_revision_id' => $p->getRevisionId()]]);
$node->save();
```

Store the **value**, not the label — e.g. `paragraph--width--narrow`, not `Narrow`.

## Post-install steps the README calls out

- Verify at `/admin/structure/paragraphs_type`.
- On **Simple** and **Blank**, pick the text formats you want (`Full HTML` for Simple, a
  no-editor Full HTML for Blank) — the module ships no opinion on formats.
- There are deliberately **no default margins/paddings**; the site builder sets them per
  paragraph with `bp_margin` / `bp_padding`.
- Your theme must supply the Bootstrap 5 CSS/JS itself; the module only ships its own
  component CSS.
