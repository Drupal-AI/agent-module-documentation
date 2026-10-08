<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`acquia_perz.permissions.yml` defines one permission:

- **`administer acquia perz`** — "Administer Acquia Personalization". Gates the settings form
  route `acquia_perz.admin_settings` (`/admin/config/services/acquia-perz/settings`). This is a
  restricted admin permission (it controls integration credentials/behavior).

The per-bundle personalization opt-in lives on each entity's *Manage display* form, so it is
gated by the normal `administer <entity>_display` / display-management permissions, not by this
one.

The **acquia_perz_push** submodule adds its own `administer acquia perz push` permission (export
and delete forms) — see that submodule's docs.
