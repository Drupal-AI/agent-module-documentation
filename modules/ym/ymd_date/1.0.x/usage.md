<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
YMD Date is a Drupal field type for dates that core's date field cannot store: dates before 1970, and dates where the month or day is unknown.

---

Core's date field is built on ISO date/time handling that assumes a complete, modern date. Two ordinary needs of archives, genealogy, museum catalogues and historical research break that assumption.

The first is **range**: values before 1970 (the Unix epoch) are awkward or unsupported for timestamp-based handling. YMD Date sidesteps this by storing the date as a plain `YYYYMMDD` string, so a year like `1847` is just as valid as `2024`.

The second is **precision**. "1847" is a date; so is "March 1912". Forcing either into a complete date means inventing a month and a day that are afterwards indistinguishable from real ones. YMD Date records only the precision that is actually known: the widget lets the editor leave month and/or day unset, and stores `00` in those positions (`18470000` for a year, `19120300` for a year and month). Because the value is a zero-padded fixed-width string, records still sort naturally, and the formatter can display each record at its real precision — a year-only value renders with a year-only date format instead of being padded up to "1 January 1847".

Beyond the field type, widget and formatter, the module ships a Views filter (with year/month/day select inputs and equal/between operators aware of the `00` padding), a `year_only` Token for any YMD field, and a Feeds target for importing values. The per-field "Beginning year" setting controls the lowest year offered by the widget's year select list.

---

- Store a date from before 1970 (e.g. `1847`) that a timestamp-based date field cannot hold.
- Record a year with no known month or day.
- Record a year and month with no known day.
- Keep uncertainty in a date explicit instead of fabricating a full date.
- Avoid rendering an approximate year as a false "1 January".
- Catalogue an archival or museum item with its real acquisition/creation date.
- Support genealogy dates where only the birth year is known.
- Sort records naturally by the zero-padded `YYYYMMDD` string value.
- Set the earliest selectable year per field with the "Beginning year" setting.
- Display year-only, year+month and full dates each with their own Drupal date format.
- Add a Views exposed filter that accepts year, year+month or year+month+day.
- Filter records "greater than" / "less than" / "between" partial dates in a view.
- Match a whole year with a between-style query over `YYYY0000`–`YYYY1231`.
- Expose a `year_only` token (first four characters of the value) for other modules.
- Import historical dates from a CSV or feed via the Feeds target.
- Migrate legacy partial-date data into a structured field.
- Add the field to nodes, users, taxonomy terms or any fieldable entity.
- Store multiple partial dates on one entity (field supports multiple values).
- Audit a dataset for dates that were silently completed by guesswork.
- Document the module's storage format and behaviour for a team.
- Review the field type during a content-model or site audit.
- Verify the widget/formatter behaviour after a Drupal core upgrade.
