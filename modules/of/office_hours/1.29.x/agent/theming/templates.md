# Theme hooks & templates

Registered by `OfficeHoursThemeHooks` (`src/Hook/OfficeHoursThemeHooks.php`). Templates in
`templates/`:

| Theme hook | Template | Renders |
|---|---|---|
| `office_hours` | `office-hours.html.twig` | default schedule output |
| `office_hours_table` | `office-hours-table.html.twig` | table layout |
| `office_hours_status` | `office-hours-status.html.twig` | open/closed status block |
| `office_hours_schema` | `office-hours-schema.html.twig` | schema.org markup |

Common variables: `office_hours` (row data), `office_hours_field`, plus per-hook extras (e.g.
`table` for the table hook). Theme suggestions are provided via
`hook_theme_suggestions_office_hours()` (keyed off `hook_name`), so you can override per display.

## CSS/JS libraries (`office_hours.libraries.yml`)
- `office_hours_formatter` — formatter CSS.
- `office_hours_formatter_status_update` — JS for live status refresh.
- `office_hours_widget` — widget CSS/JS.
- `office_hours_webform` — Webform element styling.
- `office_hours.custom-icon` — Field UI manage-fields icon.

Override templates/CSS in your theme to restyle the schedule.
