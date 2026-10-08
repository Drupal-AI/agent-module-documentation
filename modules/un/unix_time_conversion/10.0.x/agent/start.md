<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unix Time Conversion - agent index

Blocks/forms to convert **date <-> Unix timestamp**. Version **10.0.0** (dir `10.0.x`), core `^9 || ^10`.

- Block plugins `DateToUnixTimestampBlock`, `UnixTimestampToDateBlock` with per-block conversion forms; custom `TimeElement` form element.
- Settings form route `unix_time_conversion.settings` at `admin/config/regional/unix-time-conversion/settings`, permission `Configure unix time coversion`; config `unix_time_conversion.settings` (field titles/descriptions, output format).