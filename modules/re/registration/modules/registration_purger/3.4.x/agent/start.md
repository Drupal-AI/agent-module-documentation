<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Purger — agent index

Auto-deletes a host's registrations and registration settings when the host is deleted (and
optionally when registration is disabled on update). No settings form, no configure route, no
permissions. All behaviour is in one config object.

- **The four purge flags, defaults, and the service** → [configure/purger.md](configure/purger.md)

Key fact: config object `registration_purger.settings` with booleans
`purge_registration_on_delete` (default true), `purge_registration_settings_on_delete` (true),
`purge_registration_on_update` (false), `purge_registration_settings_on_update` (false). Hooks
`entity_delete`/`entity_update` call `registration_purger.purger`.
