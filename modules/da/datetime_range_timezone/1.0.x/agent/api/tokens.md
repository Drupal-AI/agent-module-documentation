<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storage, behavior & Token integration

## Storage & value processing

- Field type `daterange_timezone` extends `DateRangeItem`; alongside core's `value`/`end_value`
  (stored UTC) it adds a **`timezone`** string property/column (varchar 255).
- `DateRangeTimezoneFieldItemList::processDefaultValue()` sets a default `timezone` of
  `date_default_timezone_get()` when a default start date is present.
- Widget `massageFormValues()`: for each delta, it rebuilds the `value`/`end_value`
  `DrupalDateTime` objects using the submitted **timezone**, so the moment the editor meant is
  preserved before `DateRangeWidgetBase` normalizes to UTC for storage.
- Formatters call `dateFormatter->format($ts, $format_type, '', $timezone)` — i.e. every
  display uses the **stored** timezone, not the site/viewer one. `display_timezone` only toggles
  whether the human-readable timezone label is appended.
- The default formatter renders through `datetime-range-timezone.html.twig`, which emits
  `<time datetime="…Z">` ISO values plus the separator and optional timezone label.

## Token integration

Implemented in `datetime_range_timezone.tokens.inc` (requires the contrib **Token** module for
the base field tokens to exist):

- `hook_token_info_alter()` — for every `daterange_timezone` field it adds **`start_date`** and
  **`end_date`** format tokens (type `date`) next to the field's existing value tokens. So a
  field `field_event_when` on nodes exposes tokens like:
  - `[node:field_event_when:start_date]` and `[node:field_event_when:end_date]`
  - with date sub-formats, e.g. `[node:field_event_when:start_date:custom:Y-m-d H:i]`,
    `[node:field_event_when:end_date:long]`.
- `hook_tokens_alter()` — performs the replacement **after** core/token field handling, using
  the field item's stored `timezone` when formatting each date, so token output matches the
  displayed timezone. It handles deltas (`[node:field_x:0:start_date:…]`) and named/custom date
  formats.

There is no service or plugin type to implement; the module is field plugins + this token glue
+ a config schema for the field/formatter settings.
