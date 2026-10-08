Fullcalendar View Generator adds a single Drush command that scaffolds a working "Full Calendar Display" View from content types and date fields, so you don't have to build the calendar View by hand.

---

This submodule of Full Calendar View provides the Drush command `fullcalendarview:generate`
(alias `fcvg`, class `FullcalendarViewGeneratorCommands`). It loads a bundled View template
(`templates/views.view.template.yml`), then fills it in from your input: a view name (turned into a
machine name), one or more node content types, a required start-date field, an optional end-date
field, a title field (default `title`), and a page path. It validates that each content type and
field actually exists and that the path is not already routed, wires a `type` bundle filter and the
chosen fields into the default display, sets the Full Calendar Display `start`/`end`/`title` style
options, and points the `page_1` display at your path. The command runs interactively (prompting via
`choice`/`multiselect`/`confirm`) when arguments are omitted, or fully non-interactively when all
arguments and options are supplied; `--enable` decides whether the resulting View is enabled. It
depends on `views` and `fullcalendar_view` and provides no UI, permissions, or config schema of its
own.

---

- Scaffold a calendar View from the command line instead of clicking through the Views UI.
- Run `drush fcvg` interactively and be prompted for view name, content types, and fields.
- Generate a calendar View non-interactively in a deploy/build script with all arguments.
- Pick which node content types feed the calendar via a multiselect prompt.
- Choose the start-date field from the date fields (datetime/daterange/timestamp) on those types.
- Optionally choose an end-date field so events span a range.
- Choose the title field for event labels (defaults to the node `title`).
- Set the page path where the generated calendar View is served.
- Auto-generate a valid machine name from a human-readable view name.
- Validate up front that named content types exist, warning and skipping invalid ones.
- Validate that the chosen start/end/title fields exist on the selected content types.
- Validate that the chosen path is not already in use before creating the View.
- Decide whether to enable the new View immediately with the `--enable` option.
- Quickly spin up a demo calendar to try Full Calendar View on existing content.
- Standardize how calendar Views are created across a team via a repeatable command.
- Bootstrap a starting-point View you then refine in the Views UI (colors, buttons, filters).
- Create multiple calendars for different content types by running the command repeatedly.
- Wire a `type` bundle filter and Full Calendar Display style options automatically.
