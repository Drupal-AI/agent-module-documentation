<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Wait List adds a "waitlist" registration state so that sign-ups beyond a host's capacity are placed on a wait list instead of being rejected, with optional autofill into open slots and a wait-list confirmation email.

---

The submodule introduces a `waitlist` workflow state and swaps in its own host-entity handler,
spaces widget and state widget so that when a host reaches capacity, a new registration is moved to
the `waitlist` state (an event lets other modules alter the chosen state). It adds a
`registration_waitlist_capacity` setting field to each host's registration settings (default 0 =
none) that caps how many wait-list places exist, and a `registration_waitlist_autofill` toggle;
when autofill is enabled and capacity is increased or a spot frees up, wait-listed registrations are
promoted into standard capacity in a configurable priority order. Per registration type it adds
third-party settings under `registration_waitlist`: `confirmation_email` (bool),
`confirmation_email_subject`, `confirmation_email_message` (`{value, format}`), plus autofill
priority `autofill_sort_field` / `autofill_sort_order` (default: Registration ID ascending — oldest
first). It also exposes Views fields for wait-list spaces reserved/remaining and a host-entity
wait-list indicator template/Twig extension. A minimum-wait-list-capacity constraint validates the
setting. No global settings form; configuration is on the registration type and per-host settings.

---

- Let people join a wait list once an event is full instead of being turned away.
- Cap the wait list itself with a per-host `registration_waitlist_capacity`.
- Automatically promote the next wait-listed person when a spot opens (autofill).
- Promote wait-listed registrants oldest-first (Registration ID ascending) by default.
- Change autofill priority via `autofill_sort_field` / `autofill_sort_order` on the type.
- Send a distinct wait-list confirmation email when someone is added to the wait list.
- Personalise the wait-list email subject/message per registration type with tokens.
- Show remaining wait-list places on the event page via the wait-list indicator.
- Report wait-list spaces reserved/remaining in administrative Views.
- Run a limited-capacity event with a controlled overflow list.
- Let staff increase capacity and have autofill move waiters into confirmed slots.
- Keep a "waitlist" state visible in the registration workflow and listings.
- Distinguish confirmed attendees from wait-listed ones by workflow state.
- Turn the wait list on for popular event types and off for others (capacity 0).
- Handle cancellations gracefully by backfilling from the wait list.
- Prioritise autofill by a field other than registration id if needed.
- Provide overflow handling without custom code or a second event.
- Combine with capacity limits so registrations flow: confirmed -> wait list -> full.
- Give organisers visibility of demand beyond capacity via the wait list count.
- Notify wait-listed users so they know their status immediately.
- Model VIP/priority autofill by sorting on a custom priority field.
