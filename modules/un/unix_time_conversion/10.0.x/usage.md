<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unix Time Conversion gives site visitors an interface to convert a date to a Unix timestamp and a timestamp back to a formatted date.

---

Unix Time Conversion provides two block plugins - `DateToUnixTimestampBlock` and `UnixTimestampToDateBlock` - each with its own form (`DateToUnixTimestampBlockForm`, `UnixTimestampToDateBlockForm`) that performs the conversion, plus a custom `TimeElement` form element. A settings form at `admin/config/regional/unix-time-conversion/settings` (permission `Configure unix time coversion`) stores field titles/descriptions and the PHP date output format in `unix_time_conversion.settings`, letting an admin control the labels and format used by the conversion blocks. It is a front-end utility for date/timestamp math.

---

- Convert a human date to a Unix timestamp.
- Convert a Unix timestamp to a formatted date.
- Place a date-to-timestamp block on a page.
- Place a timestamp-to-date block on a page.
- Customize the timestamp field title and description.
- Customize the date and time field titles.
- Set the PHP date output format for results.
- Give visitors a self-service time converter.
- Use a custom time form element.
- Configure output via an admin settings form.
- Gate configuration behind a dedicated permission.
- Store settings in unix_time_conversion.settings.
- Help developers debug timestamps on the site.
- Show conversion widgets in any block region.
- Support Drupal 9 and 10.
