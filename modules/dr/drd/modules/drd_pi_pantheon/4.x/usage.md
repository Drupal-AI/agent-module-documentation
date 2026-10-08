<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DRD Platform Integration: Pantheon (drd_pi_pantheon) imports and keeps in sync your Pantheon site inventory (sites, environments, domains) into DRD.

---

This submodule plugs Pantheon into DRD's platform-integration framework (drd_pi). You create one or more `pantheon_account` config entities, each holding a Pantheon machine token; the module exchanges that token for a session against the Pantheon/Terminus API (`https://terminus.pantheon.io:443/api/`) over HTTPS, then enumerates your Drupal sites as DRD hosts, their initialized environments as DRD cores, and each environment's resolved domain as a DRD domain (following redirects to find the live hostname). Accounts are managed at Configuration → DRD → Pantheon; the sync is run through the shared `drd_action_pi_sync` action, the `drush drd:pi:sync` command, or the DRD dashboard. The Pantheon machine token is stored as an encrypted config-entity field via DRD's encryption service.

---

- Connect a DRD dashboard to one or more Pantheon accounts.
- Automatically import all Pantheon-hosted Drupal sites into DRD as host entities.
- Import each initialized Pantheon environment as a DRD core entity.
- Import each environment's resolved domain as a DRD domain entity.
- Skip frozen sites and non-Drupal frameworks during import.
- Resolve the real live hostname by following environment domain redirects.
- Authenticate with a Pantheon machine token exchanged for a bearer session.
- Store the machine token as an encrypted account credential.
- Keep DRD's inventory current as Pantheon environments are added or removed.
- Manage multiple Pantheon accounts, each enabled or disabled independently.
- Run the Pantheon inventory sync from the CLI via `drush drd:pi:sync`.
- Trigger the sync as part of a multi-platform DRD action.
- View Pantheon host/core/domain counts in the DRD "Pantheon" dashboard block.
- Unpublish DRD entities automatically when a Pantheon site or environment is removed.
- Re-enable DRD entities when a Pantheon environment reappears.
- Add a new Pantheon account from Configuration → DRD → Pantheon → Accounts.
