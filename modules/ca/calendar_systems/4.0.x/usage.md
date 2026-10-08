Calendar Systems localizes Drupal dates into non-Gregorian calendars — principally the Persian/Jalali (Shamsi) calendar — by swapping core's `date.formatter` service and date form elements so every formatted date, date field widget, Views date filter/argument, and a date block renders in the active calendar and language.

---

The module's service provider replaces core's `date.formatter` service class with `CalendarSystemsFormatter`, so any date formatted through `\Drupal::service('date.formatter')` (and thus most rendered dates and `[node:created]`-style tokens) comes out in the active calendar. It picks a calendar from the current interface language (`fa` → Persian, `en` → Gregorian, or per site config) and can use either PHP-intl's `IntlCalendar` or bundled "poor man's" Jalali/Gregorian implementations (the shipped default uses the non-intl implementations). Via `hook_element_info_alter`, `hook_field_widget_info_alter`, `hook_views_plugins_filter_alter`, and `hook_views_plugins_argument_alter` it swaps core's `date`/`datelist`/`datetime` render elements, the `datetime_default`/`datetime_datelist`/`datetime_timestamp` field widgets, and the Views date filters/arguments with calendar-aware subclasses, and attaches a bundled `persian-datepicker` JS library (`calendar_systems/picker`) to date inputs. A `calendar_systems_block` shows the current/relative date in a chosen calendar, format, and timezone. `hook_tokens` adds `[date:gregorian]` / `[date:gregorian:custom:…]` token variants that deliberately bypass the localized formatter so machine-readable/SEO output stays Gregorian. A set of "translation hack" handlers and Farsi-digit/word normalization helpers convert Persian digits and relative-date words to machine values on input. It defines no permissions, config, Drush commands, or configure route. Two submodules extend it to Better Exposed Filters exposed date forms and to the FullCalendar module.

---

- Display all site dates in the Persian/Jalali (Shamsi) calendar for a Farsi-language site.
- Localize `[node:created]` / `[node:changed]` and other date tokens into the active calendar.
- Render core Date/time field widgets (default, datelist, timestamp) in a non-Gregorian calendar.
- Give editors a Persian date-picker popup on date input fields.
- Show a block with the current date/time in a chosen calendar, PHP date format, and timezone.
- Keep search-engine/meta-tag dates Gregorian via the `[date:gregorian]` token while displaying Jalali to users.
- Filter a View by date using Jalali date input (Views date filter swap).
- Use a Jalali date as a contextual filter / argument in a View.
- Accept Persian (۰۱۲۳) digits in date fields and normalize them to ASCII on submit.
- Interpret Farsi relative-date words ("امروز/دیروز/فردا") as today/-1 day/+1 day in Views date arguments.
- Switch calendars automatically based on the interface language (fa vs en).
- Localize the datelist (drop-down day/month/year) date widget into Jalali.
- Localize timestamp-based date widgets (e.g. authored-on) into the active calendar.
- Provide consistent Jalali formatting across nodes, comments, taxonomy terms, users, and blocks.
- Serve a self-contained Persian datepicker (persian-date.js + persian-datepicker.js) with themes.
- Turn a Views exposed date filter into a Jalali datepicker via the `calendar_systems_bef` submodule.
- Render a Jalali FullCalendar via the `calendar_systems_fullcalendar` submodule.
- Localize dates in content-translation workflows through the bundled translation handler hacks.
- Format a one-off date in a specific calendar programmatically via `CalendarSystemsDrupalDateTime`.
- Offer both an intl-based and a dependency-free ("poor man's") Jalali implementation.
- Present relative/current dates ("time ago" style) correctly under a non-Gregorian calendar.
- Support multilingual sites where different languages should see different calendars.
