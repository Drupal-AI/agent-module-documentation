<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Cancel By — agent index

Adds a **`cancel_by`** deadline to each host's registration settings; after it passes, registrants
can no longer cancel (unless they hold the bypass permission). Depends on **Registration Workflow**
(cancellation is a workflow transition). No configure route, no config object.

- **The `cancel_by` settings field, the constraint & access check** →
  [configure/cancel-by.md](configure/cancel-by.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:

- `cancel_by` is a datetime **base field** on the `registration_settings` entity (added by
  `RegistrationCancelByHooks`, validated by `CancelByConstraint`).
- Enforced on the cancel route by `CancelByAccessCheck` + a `RouteSubscriber`.
- Permission `bypass cancel by access` allows cancelling after the deadline.
