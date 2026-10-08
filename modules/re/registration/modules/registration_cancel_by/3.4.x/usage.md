<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Cancel By adds a "cancel by" deadline to a host's registration settings, after which registrants can no longer cancel their own registrations (unless they can bypass it).

---

The submodule adds a `cancel_by` datetime **base field** to the `registration_settings` entity and a
`CancelByConstraint` on that entity. The cancel-by date sits alongside the host's open/close dates and
represents the last moment a registrant may cancel. Once the date has passed, the workflow's cancel
transition is no longer available to ordinary registrants; a `CancelByAccessCheck` and a
`RouteSubscriber` enforce this on the cancel route. The single permission
`bypass cancel by access` lets trusted roles (e.g. staff) cancel even after the deadline. Because
cancellation is a workflow transition, the module **depends on Registration Workflow**. There is no
config object or settings form of its own — the deadline is stored per host in the registration
settings entity and edited on the host's registration settings form. This is useful for events with a
firm cut-off for refunds or catering counts, where late self-cancellation must be prevented while
still allowing administrative exceptions.

---

- Stop registrants cancelling within N days of an event (a firm cut-off).
- Set a per-event cancellation deadline separate from the open/close window.
- Prevent late self-cancellation that would disrupt catering or seating counts.
- Allow staff to cancel after the deadline via the bypass permission.
- Enforce a refund cut-off date by disabling cancellation afterwards.
- Give each host its own cancel-by date in its registration settings.
- Keep the base workflow cancel transition but time-limit it for registrants.
- Let a "Events team" role bypass the cancel-by date when needed.
- Communicate a clear cancellation deadline to attendees.
- Model "cancel up to 24 hours before" style policies.
- Combine with Registration Workflow so cancel is a governed transition.
- Block the cancel route automatically once the deadline passes.
- Support administrative cancellation exceptions after the cut-off.
- Store the cancel-by deadline as part of exportable per-host settings.
- Reduce no-cost late cancellations for paid or limited events.
- Apply different cancel-by deadlines to different events.
- Validate the cancel-by value via the CancelByConstraint.
- Coordinate cancellation policy with venue/vendor deadlines.
- Give organisers control over when the cancellation window closes.
- Avoid custom code to enforce a cancellation deadline.
