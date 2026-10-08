Recurring Events models events as two entity types — an EventSeries (the recurrence rule) and the EventInstance entities it generates — so editors define a schedule once and the module creates, updates and deletes the individual occurrences, with per-instance fields inherited from the series.

---

The module defines two revisionable, translatable content entity types with bundle types: `eventseries` (holds the date-recurrence configuration) and `eventinstance` (one occurrence). When a series is saved, `EventCreationService` reads its recur configuration (consecutive, daily, weekly, monthly, yearly or a set of custom dates), calculates the occurrence dates (honoring the module's `excluded_dates`/`included_dates` config entities), and creates matching instances; changing the recurrence recalculates and recreates instances (with a diff, threshold warnings, and many hooks fired around deletion/creation). Per-instance field values are populated from the series through the required `field_inheritance` module — the module ships default inheritances for title and description. Instance creation is delegated to an `event_instance_creator` plugin (attribute `#[EventInstanceCreator]`, manager `plugin.manager.event_instance_creator`); the default `recurring_events_eventinstance_recreator` is configurable per site. Two admin settings pages configure series display/creation (`recurring_events.eventseries.config`: interval, min/max time, date/time formats, allowed days, enabled recur field types, instance-count threshold warning/prevention, creator plugin) and instance display (`recurring_events.eventinstance.config`). Events are exposed at `/events/...` routes with a full permission set (view/edit/delete/clone/revisions per entity type, plus `restrict access: true` administer permissions and an orphaned-entity cleanup). A rich `recurring_events.api.php` lets other modules alter the available times/durations/days/months, the instances before creation, the active creator plugin, the diff, and hook into every pre/post instance-deletion step. Three submodules extend it: `recurring_events_ical` (iCalendar export + property mapping), `recurring_events_registration` (a Registrant entity, capacity/waitlist, notifications), and `recurring_events_views` (swaps the entity list builders for Views). A fourth, nested under registration, is `recurring_events_reminders`.

---

- Create an event that repeats daily, weekly, monthly, yearly, or on consecutive days.
- Define a set of arbitrary custom dates for an irregular schedule.
- Generate individual, separately-addressable event occurrences from one recurrence rule.
- Automatically recreate occurrences when the schedule changes, showing a diff of what changed.
- Warn (or block saving) when a series would create more than a threshold number of instances.
- Exclude specific dates (holidays/blackouts) from a series via excluded-dates config.
- Force-include specific extra dates via included-dates config.
- Inherit title, description and other field values from the series onto each instance.
- Override an individual occurrence's inherited fields where needed.
- Restrict which recurrence types editors may use (`enabled_fields`).
- Constrain the earliest/latest start time and the time-picker interval for events.
- Control the date/time display formats for series and instances.
- Clone an existing event series or a single instance.
- Track revisions of series and instances and revert them.
- Bulk-view all series or all instances via admin overview pages.
- Clean up orphaned instances left behind by data issues.
- Swap the default instance-creation strategy with a custom `event_instance_creator` plugin.
- Alter the times/durations/days/months offered in the creation form via hooks.
- Programmatically drop or modify occurrences before they are created (pre-create alter hook).
- Run code before/after each occurrence is deleted during a recurrence change.
- Export an event series or instance as an iCalendar (.ics) file (ical submodule).
- Let visitors register for event instances with capacity limits and waitlists (registration submodule).
- Send reminder emails ahead of upcoming events (reminders submodule).
- Render event lists through Views instead of entity list builders (views submodule).
- Build a public events calendar keyed off eventinstance date fields.
