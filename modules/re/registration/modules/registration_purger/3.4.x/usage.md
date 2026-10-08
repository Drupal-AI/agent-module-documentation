<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Purger automatically deletes a host entity's registrations and registration settings when that host is deleted (and optionally when registration is disabled on update), preventing orphaned registration data.

---

The submodule implements `hook_entity_delete()` and `hook_entity_update()` and delegates to the
`registration_purger.purger` service (`RegistrationPurger`). Its behaviour is controlled by the
`registration_purger.settings` config object with four booleans: `purge_registration_on_delete` and
`purge_registration_settings_on_delete` (both default TRUE) remove a host's registrations and its
registration settings entity when the host entity is deleted; `purge_registration_on_update` and
`purge_registration_settings_on_update` (both default FALSE) additionally remove them when a host is
updated in a way that disables registration. This keeps the database free of registrations that
point at hosts which no longer exist or no longer accept registrations. There is no dedicated
settings form in this version — the values live in config and can be managed with `drush cget`/
`cset` or a config import. It is purely a data-hygiene submodule: it adds no fields, permissions,
routes or plugins of its own.

---

- Automatically delete an event's registrations when the event node is deleted.
- Remove the per-host registration settings entity when its host is deleted.
- Avoid orphaned `registration` rows pointing at non-existent hosts.
- Keep registration reports accurate by purging stale data on host deletion.
- Optionally purge registrations when a host is updated to disable registration.
- Optionally purge settings when registration is turned off on a host.
- Prevent unbounded growth of registration data on high-churn content.
- Reduce manual cleanup work for site administrators after deleting events.
- Keep only registrations for hosts that currently exist and accept sign-ups.
- Configure delete-time purging independently from update-time purging.
- Purge registrations but keep settings (or vice versa) by toggling the four flags.
- Enforce a data-retention policy tied to host lifecycle.
- Clean up test events and their registrations in one delete action.
- Ensure GDPR-style removal of registrant data when an event is removed.
- Avoid broken references in Views listing registrations by host.
- Turn off automatic purging entirely by setting all four flags false.
- Keep default safe behaviour (purge on delete) without configuration.
- Manage purge policy as exportable config across environments.
- Combine with the base module so deleting a host cascades to its registrations.
- Free storage by removing registrations for cancelled/removed events.
