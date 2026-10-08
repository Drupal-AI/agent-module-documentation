# Theming calendar output

Calendar registers its theme hooks in `calendar_theme()` (`calendar.module`); most render via
Twig templates in `templates/` with preprocess logic in `calendar.theme.inc`. Override a template
by copying it into your theme and clearing caches. CSS lives in `css/` (`calendar.css`,
`calendar_multiday.css`, `calendar-overlap.css`, `calendar-overlap-no-scroll.css`) and JS in `js/`
(`calendar_overlap.js`, `calendar_colorpicker.js`), declared in `calendar.libraries.yml`.

## Theme hooks → templates

| Theme hook | Template | Renders |
|---|---|---|
| `calendar_month` | `calendar-month.html.twig` | Full month grid |
| `calendar_month_row` | `calendar-month-row.html.twig` | A week row within the month |
| `calendar_month_col` | `calendar-month-col.html.twig` | A single day column/cell |
| `calendar_week` | `calendar-week.html.twig` | Week view |
| `calendar_week_overlap` | `calendar-week-overlap.html.twig` | Week view with overlapping events |
| `calendar_day` | `calendar-day.html.twig` | Day view |
| `calendar_day_overlap` | `calendar-day-overlap.html.twig` | Day view with overlapping events |
| `calendar_year` | `calendar-year.html.twig` | Year view (grid of mini months) |
| `calendar_mini` | `calendar-mini.html.twig` | Compact mini month |
| `calendar_datebox` | `calendar-datebox.html.twig` | The date number cell |
| `calendar_empty_day` | `calendar-empty-day.html.twig` | A day with no items |
| `calendar_item` | `calendar-item.html.twig` | A single placed event/item |
| `calendar_header` | `calendar-header.html.twig` | Period heading area |
| `calendar_pager` | `calendar-pager.html.twig` | Previous/next navigation |
| `calendar_stripe_legend` | `calendar-stripe-legend.html.twig` | Color/stripe legend |
| `calendar_time_row_heading` | (preprocess only) | Hour/half-hour row label in day/week |

Notable variables: month/week/day/year hooks receive `view`, `options`, `rows` (and `day_names`
for week, `months`/`mini` for year); `calendar_datebox` gets `date`, `view`, `items`, `selected`;
`calendar_item` gets `view`, `rendered_fields`, `item`; `calendar_header` gets `title`, `empty`,
`granularity`; `calendar_pager` gets `items`, `parameters`, `exclude`.

## Related pieces

- **Legend block** — `CalendarLegend` block plugin (`calendar_legend_block`) renders the stripe
  legend for a chosen calendar view/display on any page.
- **Twig extension** — the `calendar.twig.extension` service (`Template\TwigExtension`) adds
  helper functions used by the templates.
- The row plugin itself themes with core `views_view_fields`; the calendar layout comes from the
  style-level theme hooks above.
