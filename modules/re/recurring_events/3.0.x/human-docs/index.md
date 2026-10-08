# Recurring Events — manual setup guide

**Recurring Events** (`recurring_events`) is a full events-management suite. Its
core idea is to split an event into two kinds of content: an **Event Series**,
where an editor defines the schedule once (the recurrence rule), and the
**Event Instances** it generates — one separately-addressable page per occurrence.
Set up "every Tuesday at 7pm" on the series, and the module creates all the
individual Tuesday events for you; change the schedule later and it recalculates and
recreates the occurrences, showing a diff of what changed.

Series can recur on **consecutive days, daily, weekly, monthly, yearly, or on a set
of arbitrary custom dates**, and you can exclude blackout dates (holidays) or force
extra dates in. Each instance inherits its fields — title, description, and more —
from the parent series through the required **Field Inheritance** module, while
still letting you override an individual occurrence where needed. Everything is
revisionable, translatable, and cloneable.

Because it is a suite rather than a single feature, Recurring Events ships several
submodules that add the pieces most event sites eventually want:

- **Registration** (`recurring_events_registration`) — lets visitors register for
  instances, with capacity limits and waitlists (and a nested **Reminders** piece
  for reminder emails).
- **iCal** (`recurring_events_ical`) — export a series or instance as an `.ics`
  calendar file.
- **Views** (`recurring_events_views`) — render the event overview lists through
  Views instead of the default list builders.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent — including the
`EventCreationService` API, the `event_instance_creator` plugin type, and the many
lifecycle hooks — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies
   with Composer, enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the series and instance settings, the
   permissions, and how to create your first event.

## Where it lives in the admin menu

Recurring Events does not have a single settings link; its admin pages live under
**Structure → Events** (`/admin/structure/events`). That is where the **Series**
and **Instance** settings forms, the excluded/included dates, and the orphaned-event
cleanup all sit. Editors create and manage events under the **Events** section
(`/events/...`), for example adding a series at `/events/add/{series type}`.
