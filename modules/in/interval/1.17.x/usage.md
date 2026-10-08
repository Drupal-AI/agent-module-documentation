<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Interval Field adds an `interval` field type that stores a number plus a period (e.g. "3 days", "2 weeks", "1 quarter") and can apply that span to any PHP `\DateTime`.

---

The module provides a single field type (`interval`) whose storage is two columns: an integer `interval` and a string `period` machine name. The widget (`interval_default`, "Interval and Period") renders a number input beside a period select, and its only setting, `allowed_periods`, restricts which periods appear in the dropdown (empty = all). Three formatters display the value: `interval_default` ("Plain", e.g. "3 Days" via `formatPlural`), `interval_php` ("PHP date/time", e.g. "21 days") and `interval_raw` ("Raw value"). The available periods are not hard-coded — they are plugin definitions discovered from any module's `*.intervals.yml` file through the `plugin.manager.interval.intervals` manager, each carrying `singular`, `plural`, a PHP unit (`php`, one of seconds/minutes/hours/days/months/years) and a `multiplier`. The module ships nine periods (second, minute, hour, day, week=7 days, fortnight=14 days, month, quarter=3 months, year). At the code level `IntervalItem::applyInterval(\DateTime $date, $limit)` mutates a date by the stored span (building a `"<n> <unit>"` string for `\DateTime::modify()`), with an optional month-overflow guard, and `buildPHPString()` returns that modify-compatible string. A themable `interval` form element and an `interval.html.twig` template render the two sub-inputs inline.

---

- Store a "reminder lead time" (e.g. 3 days before) on an event content type as a single field.
- Capture a subscription or membership duration such as "1 year" or "6 months".
- Record a "warranty period" and later add it to a purchase date with `applyInterval()`.
- Let editors pick a "publish for" span (number + period) without a custom widget.
- Model a recurring cadence like "every 2 weeks" for a newsletter node.
- Add a "grace period" field to an invoice entity and compute the due date in code.
- Store an SLA response time ("4 hours") on a support-ticket entity.
- Offer editors only whole-week periods by ticking just "Weeks" in the widget's Allowed periods.
- Restrict a field to days/weeks/months while hiding seconds and minutes from the dropdown.
- Display a duration as friendly text ("2 Fortnights") using the Plain formatter.
- Output a PHP-modify string ("14 days") with the PHP date/time formatter for downstream scripting.
- Compute an expiry timestamp by cloning a node's created date and applying its interval field.
- Add a new custom period (e.g. "decade" or "sprint") by shipping a `mymodule.intervals.yml` file.
- Override or extend built-in periods via `hook_intervals_alter()` (the manager's alter hook).
- Keep January-31-plus-one-month landing on the last day of February using the `$limit` guard.
- Build a "cooling-off period" field for an e-commerce order and gate refunds by it.
- Store a "retention period" on a document entity to drive automated cleanup.
- Provide a "trial length" field on a plan entity, selectable in days or weeks.
- Present the duration inline (number + period on one line) via the `container-inline` template.
- Feed the stored span into a queue/cron job to schedule a follow-up action.
- Use the raw formatter to show the untranslated plural label for exports.
- Attach an interval field to taxonomy terms, users, or media, not just nodes.
- Calculate an end date range by applying the interval to a start-date field value.
- Standardise duration entry across many content types with one reusable field type.
