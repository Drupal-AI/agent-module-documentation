<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Wait List — agent index

Adds a **`waitlist`** registration state so overflow sign-ups go to a wait list, with optional
autofill into freed slots and a wait-list confirmation email. No settings form, no configure route,
no permissions.

- **Wait list state, capacity/autofill settings, per-type third-party settings & confirmation email** →
  [configure/waitlist.md](configure/waitlist.md)

Key facts:

- A new workflow state `waitlist`; when a host is full a new registration is set to `waitlist`.
- Per-host settings gain `registration_waitlist_capacity` (default 0) and
  `registration_waitlist_autofill`.
- Per registration type third-party key `registration_waitlist`:
  `confirmation_email` (bool), `confirmation_email_subject`, `confirmation_email_message`
  (`{value,format}`), `autofill_sort_field`, `autofill_sort_order`.
