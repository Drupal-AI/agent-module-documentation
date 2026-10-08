# Theming, templates & CSS libraries

The USWDS markup is produced entirely by Twig templates the module ships. To restyle a component,
copy its template into your theme and edit it (standard Drupal template override — the module's
copies live in each submodule's `templates/`).

## Theme hooks

Registered via `hook_theme()` in each module's `src/Hook/*Hooks.php`:

| Theme hook | Template | Provided by |
|---|---|---|
| `paragraph__default` | `paragraph--default.html.twig` | base module (wraps content in `.paragraph__column`) |
| `paragraph__uswds_accordion` | `paragraph--uswds-accordion.html.twig` | accordions |
| `paragraph__uswds_alert` | `paragraph--uswds-alert.html.twig` | alerts |
| `paragraph__uswds_card_group_regular` / `paragraph__uswds_card_group_flag` (+ `regular_cards`) | `paragraph--uswds-card-group-*.html.twig`, `regular-cards.html.twig` | cards |
| `paragraph__uswds_2_columns` / `paragraph__uswds_3_columns` | `paragraph--uswds-2/3-columns.html.twig` | columns |
| `paragraph__uswds_modal` | `paragraph--uswds-modal.html.twig` | modal |
| `paragraph__uswds_process_list` | `paragraph--uswds-process-list.html.twig` | process_list |
| `paragraph__uswds_step_indicator_list` | `paragraph--uswds-step-indicator-list.html.twig` | step_indicator |
| `paragraph__uswds_summary_box` | `paragraph--uswds-summary-box.html.twig` | summary_box |

All component hooks set `'base hook' => 'paragraph'`, so they inherit `template_preprocess_paragraph()`
variables (`paragraph`, `content`, `attributes`, `view_mode`, `logged_in`, `is_admin`).

## How the templates work (patterns to know)

- Boolean/checkbox fields drive USWDS modifier classes, read as
  `content.field_x['#items'].getString()` and appended to the `classes` array — e.g. accordion
  `field_bordered` → `usa-accordion--bordered`, `field_multiselect` → `usa-accordion--multiselectable`
  (+ `data-allow-multiple`); alert `field_slim`/`field_no_icon`; step indicator `field_centered`/
  `field_counters`/`field_no_labels`/`field_small_counters`.
- Select/list fields map values to classes: alert `field_alert_status` (info/warning/error/success) →
  `usa-alert--info` … ; column `field_*_grid_options` (`4-8`, `8-4`, `3-9`, `9-3`, `auto`, `even`, `100`)
  → `grid-col-*` per breakpoint.
- Container types loop their child paragraphs and render inner fields directly
  (`item['#paragraph'].field_*`), often with `|view` (formatter-rendered) or `.value` for scalars.
- Grid components read child "breakpoint" paragraphs (`field_card_breakpoints` /
  `field_uswds_*_column_breakpoints`) whose `field_uswds_breakpoints` term name + column count build
  responsive `grid-col-N` / `<breakpoint>:grid-col-N` classes; empty → default `grid-col-6`.

## CSS/JS libraries

The module ships only thin per-component CSS shims (marked `minified: true`), NOT the full USWDS
framework — that must come from your theme. Component submodules attach their shim via
`hook_preprocess_paragraph()` **only when `view_mode !== 'preview'`** (so it does not load inside the
admin Paragraphs widget preview):

| Library | File | Submodule |
|---|---|---|
| `uswds_paragraph_components_alerts/uswds-alerts` | `css/uswds-paragraph-components-alerts.css` | alerts |
| `uswds_paragraph_components_cards/uswds-cards` | `css/uswds-paragraph-components-cards.css` | cards |
| `uswds_paragraph_components_columns/uswds-grid-layout` | `css/uswds-paragraph-components-grid-layout.css` | columns |
| `uswds_paragraph_components_modal/uswds-modal` | `css/uswds-paragraph-components-modal.css` | modal |
| `uswds_paragraph_components_step_indicator/uswds-step-indicator-list` | `css/…-step-indicator-list.css` | step_indicator |

Accordions, process_list and summary_box ship no CSS library — they rely entirely on the theme's USWDS
styles.

## Gotcha

The modal template hard-codes an SVG sprite path
`/modules/contrib/uswds_paragraph_components/components/modal/sprite.svg#close` for its close button.
That path assumes the project sits at `modules/contrib/uswds_paragraph_components`; if the module is
installed elsewhere the close icon will 404 (functional, not a security issue).
