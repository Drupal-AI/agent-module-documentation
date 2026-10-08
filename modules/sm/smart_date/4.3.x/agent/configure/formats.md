# Field type, widgets, formatters & date formats

## Field type
`smartdate` (`Plugin/Field/FieldType/SmartDateItem`) stores per value: `value` (start
timestamp), `end_value` (end timestamp), `duration` (minutes), `rrule`/`rrule_index` (when
Recurring is used), `timezone`. Add it like any field on a content type.

## Widgets (`Plugin/Field/FieldWidget/`)
- `smartdate_default` — the app-like widget (duration select auto-fills end, all-day toggle).
- `smartdate_inline` — inline variant.
- `smartdate_timezone` — adds a per-value timezone selector.
- `smartdate_datelist` — select-list style entry.
- `smartdate_only` — date-only range entry (also applies to core `daterange` fields).

## Formatters (`Plugin/Field/FieldFormatter/`)
- `smartdate_default` — compact intelligent range (hides redundant date/year parts).
- `smartdate_custom` — apply a chosen Smart date format.
- `smartdate_plain` — simple output.
- `smartdate_duration` — render the duration.
- (with Recurring submodule) `smartdate_recurring`, `smartdate_dailyrange`.

## Smart date format config entity
`smart_date_format` (config `smart_date.smart_date_format.{id}`), managed at
`/admin/config/regional/smart-date` (requires `administer site configuration`). Ships
`default`, `compact`, `date_only`, `time_only`. Each format defines the date/time format
strings and range-joining behavior. Example:
```yaml
id: compact
label: Compact
date_format: 'D, M j'      # start date
time_format: 'g:ia'        # time part
allday_class: ''
date_first: true
ampm_reduce: true          # "5-7pm" instead of "5pm-7pm"
```
Formats are exportable config; reference one from the `smartdate_custom` formatter or via
`SmartDateTrait::loadSmartDateFormat($id)`.
