# Datetime Range Popup — agent index

One field widget for core Date-range (`daterange`) fields: a Materialize-style popup datetime picker
with start/end inputs. Configured per widget on *Manage form display*. Depends on core `datetime` +
`datetime_range`. No permissions, routes, config schema, or Drush; `configure` is null.

- **The widget, its settings, the two form elements, JS data attributes, and CDN assets** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Widget id `datetime_range_popup_widget` (field type `daterange`), class `DatetimeRangePopupWidget`
  extends core `DateRangeWidgetBase`.
- Settings: `hour_format` (`12h`/`24h`, default `24h`), `allow_times` minute granularity (default
  `15`), `disable_days` (Mon–Sun), `week_start` (default `7`), `exclude_date` (`YYYY-MM-DD` list).
- Form elements `date_time_range_start` / `date_time_range_end` attach the
  `datetime_range_popup/datetime_range_popup` library and pass settings via `data-*` attributes.
- The asset library pulls JS/CSS from external CDNs (Bootstrap, cloudflare, momentjs.com, Google Fonts).
