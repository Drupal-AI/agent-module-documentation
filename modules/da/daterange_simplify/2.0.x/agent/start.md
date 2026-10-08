<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Range Simplify (daterange_simplify) — agent index

Two **field formatters** plus a **Twig extension** that render date/daterange fields as compact,
locale-aware phrases (e.g. "October 5, 2013, 10:00 AM to 1:30 PM") by wrapping the
`openpsa/ranger` PHP library. Info package: none (`daterange_simplify.info.yml` sets no `package`).
Depends on core **`datetime`** and composer lib **`openpsa/ranger:^0.5`**. Core requirement
`^10.1 || ^11`. License GPL-2.0-or-later. Version 2.0.6.
**No permissions, routes, config schema, install file, Drush, or hooks.**

- **The two formatters, their settings, and how to enable them** →
  [fields/formatters.md](fields/formatters.md)
- **The `Simplify` service + the Twig `intl_date` filter / `current_lang()` function** →
  [api/service-and-twig.md](api/service-and-twig.md)

## What it actually is (from source)

- **`SimplifyFormatter`** (id **`daterange_simplify`**, label *"Simplify"*, `field_types =
  {"daterange"}`) — `src/Plugin/Field/FieldFormatter/SimplifyFormatter.php`. Formats a start/end
  pair; settings `date_format`, `time_format`, `range_separator` (`-`), `date_time_separator`
  (`, `), plus inherited `timezone_override`.
- **`IntlFormatter`** (id **`intl_formatter`**, label *"Intl"*, `field_types = {"date",
  "datetime"}`) — `src/Plugin/Field/FieldFormatter/IntlFormatter.php`. Formats a single value;
  settings `date_format`, `time_format`, `timezone_override`.
- Both extend **`SimplifyFormatterBase`** (`ContainerFactoryPluginInterface`), which injects
  `language_manager` and the `daterange_simplify.simplify` service and adds the
  `timezone_override` select.
- **`Simplify`** service (`daterange_simplify.simplify`, class `src/Simplify.php`) — static
  helpers `getAllowedFormats()`, `daterange()`, `datetime()`, `toDrupalDateTime()`; maps the
  string styles (`none/full/long/medium/short`) to `IntlDateFormatter` constants and drives
  `OpenPsa\Ranger\Ranger`.
- **`Extension`** Twig extension (`daterange_simplify.twig_extensions`, class
  `src/TwigExtension/Extension.php`, tagged `twig.extension`, arg `@renderer`) — filter
  **`intl_date`** and function **`current_lang`**.

## Key facts for agents

- Output is produced by Ranger and returned as `#markup` (Intl-formatted date strings); each
  element carries `#cache['contexts'] = ['timezone']`.
- Style options: date allows `none/full/long/medium/short`; **time is restricted to `none/short`**
  unless intl is unrestricted (`getAllowedFormats(TRUE)` → `['none','short']`).
- Non-`en` locales require the PHP **`php-intl`** extension (README).
- `provides_config_schema` is **false** — there is no `config/schema/`; formatter settings live in
  the view-display config only.
