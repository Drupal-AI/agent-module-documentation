<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Advent Calendar Views style

## Install & enable

```bash
composer require drupal/advent_calendar
drush en advent_calendar -y
```

Only core `views` (plus core Single Directory Components) is required. For a ready-made calendar, enable the
`advent_calendar_quickstart` submodule instead of building the View by hand
(see `../../modules/advent_calendar_quickstart/1.0.x/agent/setup/quickstart.md`).

## The plugin

`Plugin/views/style/AdventCalendar` extends `StylePluginBase`:

```
@ViewsStyle(
  id = "advent_calendar_advent_calendar",
  title = "Advent Calendar",
  theme = "views_style_advent_calendar_advent_calendar",
  display_types = {"normal"},
)
```

- `$usesRowPlugin = TRUE`, `$usesRowClass = TRUE` — each result is a row; the style expects a **Fields** row
  style so you can map columns to door props.
- `defineOptions()` / `buildOptionsForm()` add three textfields:

| Option | Default | Meaning |
|---|---|---|
| `wrapper_class` | `item-list` | Space-separated classes for the calendar wrapper element. |
| `door_closed_image` | `''` | Path to a custom closed-door image (blank → shipped SVG). |
| `door_open_image` | `''` | Path to a custom open-door frame image (blank → shipped SVG). |

Config schema for these three keys: `views.style.advent_calendar_advent_calendar` in `config/schema/`.

## Preprocessing (`advent_calendar.module`)

- `template_preprocess_views_style_advent_calendar_advent_calendar()`: if `wrapper_class` is set, splits it into
  `attributes.class`; exposes `default_row_class`; wraps each row as `{ content, attributes }` and adds the row
  class from `style_plugin->getRowClass($id)`.
- `template_preprocess_views_view_fields__advent_calendar()`: copies `door_closed_image` / `door_open_image` from
  the style options into template variables (empty string when unset).
- `advent_calendar_theme()`: registers `views_view_fields__advent_calendar` with `base hook: 'views fields'`.

## Templates

- `templates/views-style-advent-calendar-advent-calendar.html.twig` — attaches
  `advent_calendar/advent_calendar`, builds classes `advent-calendar` + `advent-calendar-<id|clean_class>`, and
  loops rows.
- `templates/views-view-fields--advent-calendar.html.twig` — `include`s the door component, mapping View fields
  to props:

| Component prop | View field |
|---|---|
| `calendar` | `fields.field_year.content` |
| `day` | `fields.field_day.content` |
| `unlocked` | `fields.status.content` (published status) |
| `title` | `fields.title.content` |
| `path` | `fields.view_node.content` (the door's link) |
| `door_image` | `fields.field_door_image.content` |
| `door_closed_image` / `door_open_image` | style option variables |

## Building the View by hand

Create a View of your "day" content, set the display's **Format → Advent Calendar** with **Row style → Fields**,
then add the fields the template expects as hidden fields (field_year, field_day, status, title, a "Content: Link
to content" field aliased so it lands in `view_node`, field_door_image). The door number/link/image come from
those field outputs. A `status` field drives whether the door renders clickable (published) or as a plain closed
door (unpublished); publishing the day's node is what "reveals" it. The linked content page uses standard entity
view access.
