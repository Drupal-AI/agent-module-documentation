<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Administrative Overrides lets privileged users bypass specific registration validation limits (enabled status, capacity, maximum spaces per registration, open date, close date) on a per-registration-type basis.

---

The submodule adds five **per-registration-type third-party settings** under the key `registration_admin_overrides` (`status`, `maximum_spaces`, `capacity`, `open`, `close`), each a boolean shown on the registration type edit form, plus five matching **permissions** (`registration override status/maximum spaces/capacity/open/close`). When both the third-party setting is enabled for the type **and** the acting account holds the corresponding permission (or `administer registration` / `administer <type> registration`), the `RegistrationOverrideChecker` service reports that the account may override that constraint. Two event subscribers hook into the registration validation flow so that the normal host-level constraints (host is open, host has room, within capacity, within maximum spaces, host is enabled) are relaxed for that account. This makes it possible for staff to add a late registration after the close date, squeeze an extra attendee past capacity, or register while a host is disabled — without loosening the rules for ordinary users. There is no settings form of its own; configuration lives entirely on each registration type and in role permissions.

---

- Let an administrator add a registration after the event's close date has passed.
- Allow staff to register an attendee even though the event is already at capacity.
- Permit a privileged user to exceed the maximum spaces normally allowed per registration.
- Register someone before the official open date for VIP or early-bird handling.
- Add a registration to a host whose registration is currently disabled (status off).
- Grant capacity-override rights to an "Events team" role but not to regular users.
- Enable only the "override close" ability on a workshop type while keeping capacity firm.
- Turn on all five overrides for a "Staff" registration type used for internal sign-ups.
- Keep overrides available to admins but invisible/unusable for anonymous registrants.
- Configure overrides per registration type so different event kinds have different latitude.
- Combine with the base capacity/open/close settings to run controlled exceptions.
- Audit which override permissions a role holds to reason about who can bypass limits.
- Let a site builder expose overrides via the registration type form without custom code.
- Allow a help-desk role to fix a missed registration after close without editing settings.
- Restrict override of maximum spaces to a specific type used for group bookings.
- Model "hard" limits (never override) vs "soft" limits (override allowed) via the toggles.
- Provide administrators a way to force-add registrations during on-site walk-ins.
- Keep the public registration form strictly validated while giving back-office staff flexibility.
- Grant `administer <type> registration` to give a type's manager all overrides at once.
- Document per-type override policy in config that is exportable with the site.
