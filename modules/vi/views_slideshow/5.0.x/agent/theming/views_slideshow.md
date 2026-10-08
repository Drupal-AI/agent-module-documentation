# Theming — templates, theme hooks & libraries

## Views style theme

The `slideshow` style renders through theme hook `views_view_slideshow`
(template `views-view-slideshow.html.twig`), preprocessed by
`template_preprocess_views_view_slideshow()` → `_views_slideshow_preprocess_views_view_slideshow()`
in `views_slideshow.theme.inc`.

## Theme hooks (`hook_theme` in views_slideshow.module)

All use `views_slideshow.theme.inc`. Override by copying the matching template into your theme:

| Theme hook | Template | Renders |
|---|---|---|
| `views_slideshow_main_section` | `views-slideshow-main-section.html.twig` | The slides container (`vss_id`, `slides`, `plugin`) |
| `views_slideshow_pager_widget` | `views-slideshow-pager-widget.html.twig` | Pager wrapper |
| `views_slideshow_pager_fields` | `views-slideshow-pager-fields.html.twig` | Field-based pager |
| `views_slideshow_pager_field_field` | `views-slideshow-pager-field-field.html.twig` | One field in a field pager |
| `views_slideshow_pager_field_item` | `views-slideshow-pager-field-item.html.twig` | One field-pager item |
| `views_slideshow_pager_bullets` | `views-slideshow-pager-bullets.html.twig` | Bullet pager |
| `views_slideshow_controls_widget` | `views-slideshow-controls-widget.html.twig` | Controls wrapper |
| `views_slideshow_controls_text` | `views-slideshow-controls-text.html.twig` | Text controls group |
| `views_slideshow_controls_text_previous` / `_pause` / `_next` | `views-slideshow-controls-text-{previous,pause,next}.html.twig` | Individual prev/pause/next links |
| `views_slideshow_slide_counter_widget` | `views-slideshow-slide-counter-widget.html.twig` | Counter wrapper |
| `views_slideshow_slide_counter` | `views-slideshow-slide-counter.html.twig` | "slide X of Y" |

## Libraries (`views_slideshow.libraries.yml`)

| Library | Contents |
|---|---|
| `views_slideshow/form` | `css/views_slideshow.css` — styles the Views style settings form (attached by the style) |
| `views_slideshow/widget_info` | `js/views_slideshow.js` (+ core jquery/drupal/drupalSettings) — coordinates widgets and the engine |
| `views_slideshow/controls_text` | `css/controls_text.css` |
| `views_slideshow/pager_bullets` | `css/views-slideshow-pager-bullets.css` |
| `views_slideshow/jquery_hoverIntent` | external jQuery HoverIntent from `/libraries/jquery.hover-intent` |

`views_slideshow.js` drives the front-end: it reads `drupalSettings`, wires widget actions
(next/prev/pause/play/goToSlide) to the active slideshow type, and reacts to the type's
`transitionBegin`/`transitionEnd` calls.
