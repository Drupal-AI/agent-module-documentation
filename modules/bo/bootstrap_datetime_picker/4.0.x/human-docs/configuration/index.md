# Configuration

Bootstrap DateTime Picker is configured in two layers: a **global settings form**
that sets site-wide defaults for how the picker looks and behaves, and
**per-widget options** you set on each field's Manage form display. The global
settings provide the defaults; each widget can add or override options for that
one field.

## Global settings form

Go to **Configuration → Content authoring → Bootstrap DateTime Picker**
(`/admin/config/content/bootstrap_datetime_picker`). You need the core
*Administer site configuration* permission. The form saves to the
`bootstrap_datetime_picker.settings` configuration.

### Icons and library source

- **Icon type** (`icon_type`, default `fontawesome`) — choose Font Awesome or
  Bootstrap Icons for the calendar/clock glyphs.
- **Use CDN** (`use_cdn`, default on) — load the icon CSS from a CDN.
- **Use Tempus Dominus CDN** (`use_tempus_dominas_cdn`, default off) — load the
  picker library itself from a CDN instead of your local `/libraries` copy. Turn
  this on if you don't want to self-host the library.
- **Icon glyph classes** (`display_icons_time`, `_date`, `_up`, `_down`,
  `_previous`, `_next`, `_today`, `_clear`, `_close`) — the CSS classes used for
  each picker control. The defaults are Font Awesome solid classes; change them if
  you use a different icon set.

### Display and components

- **Side by side** (`display_sideBySide`, default off) — show the date and time
  panels next to each other.
- **Calendar weeks** (`display_calendarWeeks`, default off) — show ISO week
  numbers.
- **View mode** (`display_viewMode`, default `calendar`) — the panel shown first
  (calendar, clock, and so on).
- **Toolbar placement** (`display_toolbarPlacement`, default `bottom`) — where the
  toolbar sits.
- **Keep open** (`display_keepOpen`, default off) — leave the picker open after a
  selection instead of closing it.
- **Toolbar buttons** (`display_buttons_today`, `_clear`, `_close`, all default
  off) — which quick-action buttons appear in the toolbar.
- **Components** (`display_components_calendar`, `_date`, `_month`, `_year`,
  `_decades`, `_clock`, `_hours`, `_minutes`, all on by default; `_seconds` off) —
  which parts of the picker are shown. Turn components off to make a date-only or
  time-only picker, or turn on seconds for finer time selection.
- **Inline** (`display_inline`, default off) — render the picker always-visible
  inline rather than opening on focus.
- **Theme** (`display_theme`, default `auto`) — `auto`, `light`, or `dark`.
- **Hour cycle** (`hourCycle`, default `undefined`) — force 12-hour or 24-hour
  time, or let the picker guess from the locale.
- **Language** (`language`, default `en`) — the calendar locale; the matching
  locale file is loaded from the library's `dist/locales/` folder.

Click **Save configuration** to store the defaults. You can also set any key from
the command line, for example:

```bash
drush cset bootstrap_datetime_picker.settings use_tempus_dominas_cdn true -y
```

## Per-widget settings

Global config sets the defaults; each field widget instance adds options you set
on **Manage form display**. Pick the **Bootstrap DateTime Picker** widget for a
date field, then click the gear icon to reveal:

- **Wrapper class** (`wrapper_class`) and **Column size class**
  (`column_size_class`) — Bootstrap grid/layout classes to wrap the input for
  responsive forms.
- **Date format** (`date_date_format`) — the display/format string for this field.
- **Minimum date** (`date_date_min`) and **Maximum date** (`date_date_max`) — the
  earliest and latest selectable dates.
- **Disabled hours** (`disabled_hours`) — hours of the day to block in the time
  picker.
- **Disable days** (`disable_days`) — weekdays to disable, for example weekends on
  a booking field.
- **Exclude dates** (`exclude_date`) — specific calendar dates to disable
  (comma-separated, for example holidays or blackout days).

Save the display. The widget renders the Tempus Dominus picker with the global
defaults plus these per-field options merged in.
