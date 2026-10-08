# Configuration

Recurring Events has no single settings link in the admin menu. Its configuration
lives under **Structure → Events** (`/admin/structure/events`), split between the
**Series** settings and the **Instance** settings, plus the excluded/included dates
and orphaned-event cleanup. This page summarises what you can tune; because the
suite is large, it focuses on the settings most sites touch.

## Series settings

The **Event Series** settings form controls how the recurrence creation form
behaves and how many occurrences a series may produce. Key options:

- **Time interval** (`interval`, default **30**) — the number of minutes between
  selectable times in the event creation form.
- **Minimum / maximum time** (`min_time` / `max_time`, default **08:00am** /
  **11:45pm**) — the earliest and latest start times editors can pick.
- **Date format / time format** — how series dates and times are displayed.
- **Available days** (`days`) — which days of the week are offered.
- **Enabled recurrence types** (`enabled_fields`) — which of the six recurrence
  types (consecutive, daily, weekly, monthly, yearly, custom dates) editors may use.
  Trim this if you only want to allow, say, weekly and monthly.
- **Excluded / included dates** (`excludes` / `includes`) — whether editors can
  exclude blackout dates or force extra dates on a series.
- **Threshold warning** (`threshold_warning`, `threshold_count` default **200**,
  `threshold_message`) — show a warning when a series would create more than a set
  number of instances, so nobody accidentally generates thousands.
- **Prevent save over threshold** (`threshold_prevent_save`, default **off**) — turn
  this on to actually block saving a series that exceeds the threshold, not just
  warn.
- **Instance creator plugin** (`creator_plugin`, default the built-in
  *recreator*) — the strategy used to build instances from a series. Developers can
  provide alternatives via the `event_instance_creator` plugin type.
- **Items per page** (`limit`, default **10**) — page size on the series listing.

These are stored in the `recurring_events.eventseries.config` object.

## Instance settings

The **Event Instance** settings form is simpler — it controls the **date format**
for displaying instances and the **items per page** (`limit`, default **10**) on the
instance listing. Stored in `recurring_events.eventinstance.config`.

## Excluded and included dates

Also under **Structure → Events**, you can define site-wide **excluded dates**
(dates to always skip, such as public holidays) and **included dates** (extra dates
to force in). Series honor these when their occurrences are calculated.

## Orphaned-event cleanup

If data issues ever leave instances (or registrants) without a valid parent, the
**Orphaned** cleanup screen under Structure → Events lets an administrator delete
them. It is gated by a restricted permission (see below).

## Creating your first event

1. Make sure at least one **Event Series type** and **Event Instance type** exist
   (the module provides defaults).
2. Go to **Events → Add** (`/events/add/{series type}`).
3. Fill in the shared fields (title, description, etc.) and choose a recurrence type
   and schedule.
4. Save. The module calculates the occurrence dates — honoring your excluded and
   included dates — and generates the individual instances, each viewable at
   `/events/{instance}`.

Change the schedule later and the module recalculates and recreates the instances,
showing you a diff first.

## Permissions

Recurring Events defines a large, granular permission set at **People →
Permissions**, one group for **Event Series** and one for **Event Instances**. The
everyday, grantable permissions for building editor roles include:

- `add eventseries entity`, `edit`/`edit own`, `delete`/`delete own`,
  `clone eventseries entity`, `view eventseries entity`,
  `view unpublished eventseries entity`, `access eventseries overview`, and the
  matching revision permissions — and the equivalent set for **eventinstance**.

The following are marked **restricted / trusted-admin only** and should not be given
to ordinary editors:

- `administer eventseries entity`, `administer eventseries`,
  `administer eventseries types`, and the matching `administer eventinstance…` and
  `administer eventinstance types` permissions.
- `administer orphaned events entities` — for the orphaned-event cleanup screen.

None of these cross a trust boundary beyond ordinary content administration, but the
`administer…` ones grant broad control, so keep them to trusted roles.

## Going further

The submodules (Registration, iCal, Views, Reminders) add their own settings and
permissions once enabled. And developers can reshape almost every step — the
available times, durations, days, months, the instances before creation, the active
creator plugin, and the deletion lifecycle — through the hooks documented in the
[`agent/`](../../agent/hooks/hooks.md) docs.
