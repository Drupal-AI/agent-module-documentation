<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Change Host lets an existing registration be moved from one host entity to another (e.g. re-book an attendee onto a different event session), either in a single-step form or a guided multistep flow.

---

The submodule adds a **Change host** local task/route on registrations and a
`RegistrationChangeHostManager` service that computes the set of possible target hosts
(`getPossibleHosts()`), performs the move (`changeHost()`), and detects whether the change would lose
data (`isDataLostWhenHostChanges()`). It ships two flows selected by the `workflow` key in the
`registration_change_host.settings` config object: `multistep` (a page to pick the new host then a
confirmation form — `ChangeHostForm`) or single-step (`SingleStepChangeHostForm`). The settings
object also holds the translatable titles used in those forms (`task_title`, `form_title`,
`page_title`, `confirm_form_title`), each supporting placeholders like `@host_type_label` and `%id`.
Per registration type a third-party boolean `allow_data_loss` controls whether moving to a host of a
different type (which may drop type-specific field data) is permitted. Access is governed by two
permissions — `change host any registration` and `change host own registration` — plus the base
registration access checks. A `RegistrationChangeHostPossibleHostsEvent` lets other modules alter the
candidate hosts. It adds no storage fields of its own beyond the configuration.

---

- Move an attendee's registration from a cancelled session to another session.
- Re-book a registrant onto a different event without deleting and recreating.
- Offer a guided multistep "choose a new host, then confirm" change flow.
- Use a faster single-step change form for simple reassignments.
- Let users change the host of their **own** registration (change host own permission).
- Let staff change the host of **any** registration (change host any permission).
- Restrict which target hosts appear via the possible-hosts event.
- Allow or forbid moving to a host of a different registration type (allow_data_loss).
- Customise the change-host form titles with the host type label and registration id.
- Provide a "Change event" tab on each registration for organisers.
- Consolidate registrations onto a merged event by moving them across.
- Handle venue/date changes by moving all registrations to the new host.
- Preserve registration history/id while switching the associated event.
- Warn (or block) when a move would lose registration-type-specific field data.
- Reassign a mistakenly-booked registration to the correct event.
- Localise the change-host UI titles per language.
- Give a help-desk role the ability to transfer bookings between events.
- Support flexible rescheduling workflows for event-driven sites.
- Change host as part of an administrative correction process.
- Keep single-step vs multistep behaviour configurable site-wide.
