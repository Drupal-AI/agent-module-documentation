<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration lets people sign up for "host" entities (events, sessions, anything) by adding a **Registration** field to a content type or other entity bundle, tracking each sign-up as a `registration` entity with capacity limits, open/close dates, per-space counts, workflow states and reminder emails.

---

You enable registrations on any fieldable entity by adding a field of type **Registration** (`registration`) to its bundle; the field stores which `registration_type` applies. A `registration_type` config entity binds a **Workflow** (states such as pending / complete / held / canceled) plus hold-expiration behaviour. Each host entity then gets a **register** tab, a **manage registrations** list, and a **registration settings** form; the per-host `registration_settings` entity holds `status` (enabled), `capacity`, `open`/`close` dates, `maximum_spaces` per registration, `multiple_registrations`, reminder date/template and the confirmation message. Each individual `registration` entity records the registrant (a user, another user, or an anonymous email), a `count` of spaces, its workflow `state`, and language. A `RegistrationValidator` service and a set of host-level **RegistrationConstraint** plugins enforce capacity, open/close windows, uniqueness and editability. Global behaviour (HTML email, notification queue threshold, filter thresholds, settings synchronisation) lives in the `registration.settings` config object at `/admin/structure/registration-settings`. Nine optional submodules add administrative overrides, cancel-by dates, host changing, confirmation emails, Inline Entity Form editing, automatic purging, scheduled actions, wait lists and workflow transition operations. Cron expires held registrations and sends reminders; the module also ships Views integration, a status block, and email/set-state actions.

---

- Let members register for an event node (conference, meetup, class) with a limited number of seats.
- Cap total attendance on an event using the per-host `capacity` setting.
- Open and close registration automatically with `open` and `close` datetime settings.
- Allow each registrant to reserve multiple spaces (e.g. "register 3 guests") via `maximum_spaces`.
- Allow a user to submit more than one registration for the same event (`multiple_registrations`).
- Collect a registrant's email for anonymous sign-ups without requiring an account.
- Register other people by email address or register another user account on their behalf.
- Track each sign-up through a workflow: pending -> complete, or hold -> canceled.
- Automatically expire "held" registrations after N hours (hold expiration on the registration type).
- Send scheduled reminder emails to registrants before an event using the reminder date/template.
- Add a "Register" tab and "Manage registrations" admin list to every event automatically.
- Show remaining/reserved spaces on the event page with the Registration Status block.
- Sell tickets by pairing this module with Commerce Registration for fee-based sign-ups.
- Collect extra data with each registration (shirt size, dietary needs) by adding fields to a registration type.
- Build administrative Views of registrations with host spaces-remaining / reserved / count fields.
- Email all registrants of an event at once from the Manage Registrations broadcast form.
- Bulk-set the workflow state of selected registrations with the "Set registration state" action.
- Restrict who can create, view, update or delete registrations with the module's permission set.
- Apply per-language registration settings and language-targeted reminder emails on multilingual sites.
- Prevent duplicate sign-ups from the same user/email with the unique-registrant constraint.
- Disable new registrations while still (optionally) allowing edits to existing ones.
- Vary the confirmation message and redirect path shown after a successful registration.
- Provide a wait list for overflow sign-ups once capacity is reached (Wait List submodule).
- Let administrators override capacity, open/close or maximum-spaces limits (Admin Overrides submodule).
- Add a "cancel by" deadline after which registrants can no longer self-cancel (Cancel By submodule).
- Move an existing registration to a different host entity (Change Host submodule).
- Automatically delete a host's registrations and settings when the host is deleted (Purger submodule).
- Schedule recurring automated email actions relative to open/close/reminder dates (Scheduled Action submodule).
- Sanitize registrant emails and names when producing a scrubbed database dump (`drush sql:sanitize`).
- Expose registration counts and "user is registered" flags as Views fields and filters.
