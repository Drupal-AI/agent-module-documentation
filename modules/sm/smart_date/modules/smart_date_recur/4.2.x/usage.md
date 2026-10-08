Smart Date Recurring extends Smart Date to make events repeat, storing RRULE recurrence rules (via the `simshaun/recurr` library) and letting editors override or cancel individual instances.

---

This submodule of Smart Date adds recurrence to `smartdate` fields. When enabled, the widget gains a "Repeat" option that generates an RRULE (daily, weekly, monthly, yearly, with intervals and limits), stored in a `smart_date_rule` entity linked to the host field value. Instances are materialized from the rule (via the `simshaun/recurr` library) and can be managed individually: editors can reschedule a single occurrence, remove/cancel one, or apply changes forward to the rest of the series, using management screens under Admin → Content → Smart date recurring. Per-instance changes are stored as `smart_date_override` entities so the base rule stays intact. It ships recurrence-aware formatters (a recurrence formatter and a daily-range formatter), a Views frequency filter, and a queue worker that keeps generated instances up to date. A Drush command prunes invalid rules. Permissions gate who may make dates recur and who may reschedule or cancel instances. It requires the parent Smart Date module and core Datetime.

---

- Turn a Smart Date event into a repeating series.
- Create daily, weekly, monthly, or yearly recurrence rules.
- Repeat every N days/weeks (interval-based recurrence).
- Limit a series by end date or number of occurrences.
- Reschedule a single occurrence without touching the series.
- Cancel/remove one instance of a recurring event.
- Apply a change forward to all remaining instances.
- Revert a modified instance back to the rule default.
- Store per-instance overrides separately from the base rule.
- Display recurrence info with the recurrence formatter.
- Show daily time ranges across a multi-day series.
- Filter recurring events by frequency in Views.
- Keep instances current automatically via the queue worker.
- Prune invalid recurrence rules with a Drush command.
- Manage all instances of a series from one admin screen.
- Model a weekly class schedule as a recurring event.
- Build a "first Monday of the month" style meeting series.
- Handle holiday cancellations by removing single instances.
- Restrict recurrence creation to trusted editors via permission.
- Generate calendar feeds of expanded recurring occurrences.
