<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Scheduled Action lets you define reusable, cron-driven actions (typically emails) that run a configurable amount of time before or after a registration-related date across all matching registrations.

---

The submodule provides a `registration_scheduled_action` **config entity** managed at
`/admin/structure/registration/schedule`
(`entity.registration_scheduled_action.collection`, the module's configure route). Each scheduled
action wraps a core **Action plugin** of type `registration` that implements `QueryableActionInterface`
(e.g. the base module's `registration_send_email_action`) and stores: a `datetime` offset
(`length` integer, `type` = minutes/hours/days/months, `position` = before/after), a `target_langcode`,
the `plugin` id, arbitrary plugin `configuration`, a `weight`, and `status`. A cron worker
(`Cron\RegistrationSchedule`) evaluates each enabled action on every cron run, finds the registrations
whose relevant date falls in the computed window, and executes the action against them. This is how
you build things like "email everyone 3 days before the event" or "send a follow-up 1 day after
close" without writing code. Access to manage the schedule is gated by the
`administer registration scheduled action` permission. It adds no fields to registrations; everything
is configuration plus the reused action plugin.

---

- Email all registrants 3 days before their event.
- Send a follow-up/thank-you email 1 day after an event closes.
- Schedule a reminder a configurable number of hours/days/months before or after a date.
- Reuse the base module's registration email action on a schedule.
- Run the same scheduled email across every matching event automatically via cron.
- Target a specific language's registrants with `target_langcode`.
- Define multiple scheduled actions with an ordering `weight`.
- Enable/disable a scheduled action without deleting it (`status`).
- Build a pre-event checklist email series (e.g. 7 days, 1 day before).
- Send a post-event survey link some days after the event.
- Configure the offset direction (before/after) and unit (minutes/hours/days/months).
- Manage all scheduled actions from one admin collection page.
- Avoid custom cron code for time-based registrant messaging.
- Apply a scheduled action only to registrations in a given language.
- Schedule "last chance to register" nudges before the close date.
- Export scheduled actions as configuration across environments.
- Trigger any registration-type action plugin (implementing QueryableActionInterface) on a schedule.
- Restrict schedule management to trusted admins via the permission.
- Combine with the base reminder feature for layered notifications.
- Coordinate multi-step registrant communications entirely through config.
