# Build a calendar view

Calendar has no meaningful admin config screen — a calendar is a **Views display**. The
`/admin/config/date/calendar` form (`administer calendar settings` permission) only sets
`calendar.settings:track_date` (0 = never, 1 = authenticated users, 2 = all users), which keeps
a user's place in the session when they switch granularities. Everything else is Views.

## Fastest path — Add from template

`views_templates` (a required dependency) adds an **"Add from template"** link on the Views
listing page (`/admin/structure/views`). Pick the date field and it generates a full view from
`views_templates/calendar_base_field.yml` (or `calendar_config_field.yml`): a **Master** display
plus **Month / Week / Day / Year** page displays at `{base_path}/month`, `/week`, `/day`, `/year`,
each a menu tab. This wires up the style, row, pager, header area, and date arguments for you.

## The Views plugins (to build or edit one by hand)

| Plugin | Type | id | Notes |
|---|---|---|---|
| Calendar | style | `calendar` | Grid layout. Key option `calendar_type`: `month` \| `week` \| `day` \| `year`. Also `mini`, `name_size`, `with_weekno`, `max_items` + `max_items_behavior` (`more`/hide), `groupby_times` (`hour`/`half`/custom), `theme_style` (overlap), `multiday_theme`, `multiday_hidden`, `granularity_links` (day/week/month). |
| Calendar entities | row | `calendar_row` | Renders each result as a placed item; `colors.legend` = `type` (per content type) or a taxonomy field; per-type/per-term hex colors. |
| Calendar Pager | pager | `calendar` | Previous/next through the current period; reads the view's date argument. `exclude_display` hides it. |
| Calendar Header | area | `calendar_header` | Header/footer heading; `content` (tokenized, e.g. `{{ arguments.field_date_year_month }}`), `pager_embed` to render the pager inside it. |
| Calendar Date Format | argument_validator | `calendar` | `replacement_format` (PHP date pattern) for the URL period value. |

## Period = a date contextual filter (argument)

The displayed period is driven by a Views **contextual filter** on the date field. Core supplies
year/month/day granularity arguments (`date_year`, `date_year_month`, `date_fulldate`, …); the
template uses these per display (Month → `date_year_month`, Week → `date_year_week`,
Day → `date_fulldate`, Year → `date_year`). Calendar adds an ISO **`year_week`** granularity
via `hook_views_data_alter()` / `hook_field_views_data_alter()` (argument ids `date_year_week`
for the base date column and `datetime_year_week` for datetime fields).

To default the period to today, set the argument's "Provide default value" to the
**`date` — "Calendar Current date"** plugin from the `calendar_datetime` submodule (format
`Y-m-d`). Without a period in the URL and no default, the calendar shows the "all" exception.

## Config schema keys

Each plugin's stored options are typed in `config/schema/calendar.schema.yml`
(`views.style.calendar`, `views.row.calendar_row`, `views.pager.calendar`,
`views.area.calendar_header`, `views.argument_validator.calendar`, plus
`block.settings.calendar_legend_block`). Enable Views result/render caching in the display's
Advanced section — calendars are expensive to render (see README).
