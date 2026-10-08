<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD Agent — agent index

The **remote-agent** side of Drupal Remote Dashboard (DRD): install it on a site so a central
DRD portal can securely run maintenance/monitoring actions on it over encrypted HTTP. Driven by
the dashboard, not by a human. State-backed (no config schema), no permissions of its own.

Key facts:
- `configure` route = `drd_agent.settings.form` → `/admin/config/system/drd` (only a **Debug mode**
  toggle, stored in State as `drd_agent.debug_mode`; perm `administer site configuration`).
- Dashboard-facing routes: `/drd-agent` (main), `/drd-agent-crypt`, `/drd-agent-authorize-secret`,
  `/drd-agent-authorize`. Authorized dashboards + one-time token live in State
  (`drd_agent.authorised`, `drd_agent.ott`).
- Drush: `drd:agent:setup <token>` (alias `drd-agent-setup`).
- Defines plugin type **`drd_pi_auth`** (`plugin.manager.drd_pi_auth`); ships `acquia`,
  `pantheon`, `platformsh`.

- **Settings / State + authorize flow** → [configure/settings.md](configure/settings.md)
- **Drush command** → [drush/commands.md](drush/commands.md)
- **`drd_pi_auth` plugin type (provider auth)** → [plugins/drd_pi_auth.md](plugins/drd_pi_auth.md)
- **Actions the agent can perform + crypt/auth** → [api/actions.md](api/actions.md)
