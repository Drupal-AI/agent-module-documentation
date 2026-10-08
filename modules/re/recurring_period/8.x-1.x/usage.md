<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Recurring Time Period is a developer/API module that defines a RecurringPeriod plugin type for turning a start date into a recurring sequence of time periods, with bundled fixed, rolling, and unlimited plugins and a reusable Period value object.

---

Recurring Time Period provides no UI of its own; it gives other modules a configurable plugin type (managed by `plugin.manager.recurring_period`) whose plugins compute the end date of a period from a given start date and iterate that sequence forward. Bundled plugins cover a rolling interval (end = start + interval), a fixed reference-date interval that aligns every period to the calendar, and an unlimited period with no end. Periods are expressed with the Interval module's interval element, returned as immutable `Period` value objects (half-open `[start, end)` ranges), and can be stored on an entity via `Period::toEntity()` and `PeriodEntityTrait`. It was built for Commerce License and Commerce Recurring but works without Commerce, and it registers its plugin type as referenceable by Commerce plugin-reference fields when Commerce is present.

---

- Calculate the end date of a period given a start date.
- Model a monthly billing cycle with a rolling interval plugin.
- Model a tax year that always ends on 1 January (fixed reference date).
- Define an unlimited, never-ending period.
- Iterate successive periods forward with getNextPeriod().
- Get the period that contains an arbitrary date (backdated start).
- Back a subscription term with a configured period plugin.
- Back Commerce License / Commerce Recurring billing schedules.
- Compute how long a period lasts in seconds (getDuration()).
- Check whether a timestamp falls within a period (contains()).
- Store a computed period as start/end fields on a custom entity.
- Store a computed period as a single daterange field on an entity.
- Add period base fields to an entity type via a trait.
- Provide a plugin-reference field option for recurring periods in Commerce.
- Write a custom period plugin by extending RecurringPeriodBase.
- Alter or override bundled period plugins with a hook.
- Embed a period plugin's configuration form inside another module's form.
- Configure a period as "every 6 months" or "every year on Jan 1".
- Standardise recurrence/date-math logic across modules.
- Handle timezone-aware period boundaries.
- Expire a user's access or a published node on the next period boundary.
- Schedule newsletter or notification sends on recurring dates.
- Reuse period plugins across subscriptions, memberships, and bookings.
- Produce a human-readable label for a period.
