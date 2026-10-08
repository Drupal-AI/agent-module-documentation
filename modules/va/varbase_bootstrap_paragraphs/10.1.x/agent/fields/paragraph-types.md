# Paragraph types & fields

Everything here is shipped as **installed optional config** under `config/optional/` (paragraph
types, field storages, field instances, and default/preview view+form displays). Enabling the
module imports them; there are no PHP plugins behind these bundles. Bundle content is authored by
users with the relevant Paragraphs permissions.

## Paragraph types (bundles)

15 bundles (`paragraphs.paragraphs_type.*`). Most carry the shared styling fields (see below); a few
are inner/child bundles.

| Machine name | Label | Purpose / key content fields |
|---|---|---|
| `bp_columns` | Columns (Equal) | Equal Bootstrap columns; `bp_column_content` (nested paragraphs). |
| `bp_columns_two_uneven` | Columns (Two Uneven) | Two columns; `bp_column_content_2` + `bp_column_style_2` (width ratio). |
| `bp_columns_three_uneven` | Columns (Three Uneven) | Three columns; `bp_column_content_3` + `bp_column_style_3`. |
| `bp_column_wrapper` | Column Wrapper | Inner wrapper holding `bp_column_content_w` (nested paragraphs). No styling fields. |
| `bp_accordion` | Accordion | Holds `bp_accordion_section` children. |
| `bp_accordion_section` | Accordion Section | Child of accordion; `bp_accordion_section_title` + `bp_accordion_section_body`. |
| `bp_tabs` | Tabs | Holds `bp_tab_section` children. |
| `bp_tab_section` | Tab Section | Child of tabs; `bp_tab_section_title` + `bp_tab_section_body`. |
| `bp_carousel` | Carousel | `bp_slide_content` (nested) + `bp_slide_interval`. |
| `bp_modal` | Modal | `bp_modal_title`, `bp_modal_body`, `bp_modal_footer`, `bp_modal_button_text`. |
| `bp_image` | Image | `bp_image_field` (media) + optional `bp_link`. |
| `bp_simple` | Rich Text | `bp_text` (formatted text). |
| `bp_view` | View | `bp_view` (viewsreference to embed a View). |
| `bp_webform` | Webform | `bp_webform_field` (embeds a Webform). |
| `bp_block` | Drupal Block | `bp_block` (block plugin reference). |

The submodule adds bundle `text_and_image` — see
[modules/vbp_text_and_image](../../../modules/vbp_text_and_image/10.1.x/agent/start.md).

## Shared styling fields (attached to most `bp_*` bundles)

These are the module's cross-cutting fields; the templates + `hook_preprocess_paragraph` turn them
into Bootstrap classes / markup (see [../theme/styling.md](../theme/styling.md)).

| Field | Type | Values / meaning |
|---|---|---|
| `bp_width` | `list_string` | Content column width. Keys: `paragraph--width--tiny\|narrow\|medium\|wide\|full`, `bg-edge2edge` → mapped to Bootstrap `col-*`/`offset-*` classes in preprocess. |
| `bp_background` | `list_string` | Background style class. `allowed_values` are kept in sync with the settings `background_colors` list (`vbp_color_01`..`05` by default). |
| `bp_gutter` | `boolean` | Wrap content in a `.container` (adds horizontal gutter). |
| `bp_classes` | `string` (max 255) | Free-text extra CSS classes; sanitised in Twig (`striptags` + `clean_class`) before being added. |
| `bp_title` | `string` (max 255) | Optional heading rendered as `<h2 class="text-center">` (striptags'd). |
| `bp_title_status` | `boolean` | When true, **hides** the title (`bp_title_status` = "hide title" flag). |
| `bp_image_field` | entity_reference (media) | Optional background image; preprocess builds a `background-image` URL (Drimage-aware). |
| `bp_link` | `link` | (`bp_image` only) wraps the image in an `<a href>`. |

## Displays

Each bundle ships `core.entity_form_display.paragraph.<bundle>.default` and
`core.entity_view_display.paragraph.<bundle>.default`; several also ship a `.preview` view display
used by Paragraphs Previewer. `paragraphs.settings.yml` and per-bundle
`language.content_settings.paragraph.*` (content translation) are imported too.

## Adding your own bundle

There is no plugin/API to extend — add a normal Paragraphs type in the UI (or export config), and
attach `bp_background`/`bp_width`/`bp_gutter`/`bp_classes`/`bp_title`/`bp_title_status` if you want
the same styling controls. Provide a `paragraph--<bundle>.html.twig` (copy
`templates/paragraph--default.html.twig`) to render them.
