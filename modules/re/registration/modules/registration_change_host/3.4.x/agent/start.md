<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Change Host — agent index

Moves an existing registration to a different host entity, via a single-step or multistep form. No
configure route (config edited directly).

- **Settings (workflow + titles), the manager service, third-party `allow_data_loss`** →
  [configure/change-host.md](configure/change-host.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:

- Config object `registration_change_host.settings`: `workflow` (`multistep` default | single-step),
  and titles `task_title`, `form_title`, `page_title`, `confirm_form_title`.
- Per registration type third-party `registration_change_host.allow_data_loss` (bool, default false).
- Routes `entity.registration.change_host` (pick host) and
  `registration_change_host.change_host_form`. Service `registration_change_host.manager`.
- Permissions: `change host any registration`, `change host own registration`.
