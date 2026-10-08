# Views Bootstrap style plugins

These are core Views **style** (`@ViewsStyle`) plugins, not a new plugin type.
Choose one under a view display's **Format** section, then configure its options.
Config schema lives in `config/schema/views_bootstrap.style.schema.yml`.

| Plugin id | Component | Notable options |
|---|---|---|
| `views_bootstrap_cards` | Card group | display (fields vs rendered content), title/content/image field, columns, card_group, custom row/col/group classes |
| `views_bootstrap_carousel` | Carousel/slider | interval, ride (autoplay mode), keyboard, indicators, pause-on-hover, captions + hide breakpoint, columns, image/title/description fields |
| `views_bootstrap_accordion` | Accordion | panel_output (single vs grouped), panel_title_field, flush, behavior (closed/all/specify), open sections |
| `views_bootstrap_tab` | Tabs/pills | tab_output (single vs grouped), tab_field, tab_type (tabs/pills/list), tab_position (top/left/right/below/justified/stacked), tab_fade |
| `views_bootstrap_grid` | Responsive grid | grid/row classes, per-breakpoint columns col_xs…col_xxl |
| `views_bootstrap_list_group` | List group | title_field, custom list-group class |
| `views_bootstrap_dropdown` | Dropdown menu | (populated from rows) |
| `views_bootstrap_media_object` | Media object | heading_field, image_field, image_placement (left/right), image_class, body_field |
| `views_bootstrap_table` | Bootstrap table | extends core table; responsive + breakpoint, bootstrap_styles (bordered, borderless, sm/condensed, hover, striped), custom class |

Card/table styles that select fields require the display to use **Fields** rows
(or "Display row content" mode for cards). Each plugin lives in
`src/Plugin/views/style/ViewsBootstrap*.php` and sets a matching `theme =` and
`theme_file = ../views_bootstrap.theme.inc` preprocessor.
