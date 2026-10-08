# Drush: generate a calendar View

Registered via `drush.services.yml` (`fullcalendarview_generator.commands`,
`FullcalendarViewGeneratorCommands`, tagged `drush.command`).

## Command

`fullcalendarview:generate` — alias **`fcvg`**.

Generates a "Full Calendar Display" View from a bundled template
(`templates/views.view.template.yml`).

### Arguments (prompted interactively if omitted)

| Argument | Meaning |
|---|---|
| `view_name` | Human-readable name; a machine name is derived from it |
| `content_types_str` | Comma-separated node content type machine names |
| `start_date_field` | Machine name of the start-date field (datetime/daterange/timestamp) |
| `path` | Page path for the calendar display |

### Options

| Option | Meaning |
|---|---|
| `--end_date_field` | Machine name of an optional end-date field |
| `--title_field` | Title field (defaults to `title`) |
| `--enable` | Enable the View after creation (otherwise created disabled) |

### Examples

```bash
# Interactive — prompts for everything.
drush fcvg

# Non-interactive.
drush fcvg "My Calendar" "article,page" "field_event_date" "my-calendar" \
  --end_date_field=field_event_date_end --title_field=title --enable
```

## What it does

Validates that the content types and each named field exist and that `path` is not already routed
(`ResourceNotFoundException` check via the router), then: wires a `type` bundle filter, adds the
start/title (and optional end) fields to the default display, sets the Full Calendar Display style
`start`/`title`/`end` options, points the `page_1` display at `path`, sets the View's enabled status
from `--enable`, saves it, and flushes caches. Requires the `fullcalendarview_generator` module to be
enabled (it errors out otherwise). Provides no permissions or config of its own.
