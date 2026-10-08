# AP Style Date Formats — agent index

Renders dates/timestamps/date-ranges in Associated Press style via two field formatters, a
service, and a Twig filter. Global defaults live in `date_ap_style.settings`; each formatter
instance can override them. No dependencies, no plugins of its own, no Drush.

- **Formatters, global settings & all option keys, config route/permission** →
  [configure/settings.md](configure/settings.md)
- **`ApStyleDateFormatter` service (`formatTimestamp` / `formatRange`) and the `ap_style` Twig filter** →
  [api/service-and-twig.md](api/service-and-twig.md)

Key facts:
- Formatter `timestamp_ap_style` → field types `datetime`, `timestamp`, `created`, `changed`,
  `published_at`. Formatter `daterange_ap_style` → `daterange`, `smartdate`. Both labeled "AP Style".
- Global settings: config `date_ap_style.settings`, form `/admin/config/regional/date-ap-style`
  (route `date_ap_style.settings`), permission `administer ap style settings`.
- Options (booleans unless noted): `always_display_year`, `use_today`, `cap_today`, `display_day`,
  `display_time`, `hide_date`, `time_before_date`, `display_noon_and_midnight`,
  `capitalize_noon_and_midnight`, `use_all_day`, `month_only`, `separator` (`to`|`endash`|`hyphen`),
  `timezone` (string override).
- Service id `date_ap_style.formatter`; Twig filter `{{ timestamp|ap_style }}`.
