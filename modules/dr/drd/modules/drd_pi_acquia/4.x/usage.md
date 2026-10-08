<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DRD Platform Integration: Acquia (drd_pi_acquia) imports and keeps in sync your Acquia Cloud site inventory (sites, environments, domains) into DRD.

---

This submodule plugs Acquia Cloud into DRD's platform-integration framework (drd_pi). You create one or more `acquia_account` config entities, each holding an Acquia e-mail and private key; the module authenticates to the Acquia Cloud API v1 (`https://cloudapi.acquia.com/v1/`) over HTTPS using HTTP basic auth and enumerates your sites as DRD hosts, their environments as DRD cores, and each environment's default domain as a DRD domain. During a sync it also fetches each environment's database username/password so DRD can authorize itself against the remote site. Accounts are managed at Configuration → DRD → Acquia; the actual sync is run through the shared `drd_action_pi_sync` action, the `drush drd:pi:sync` command, or the DRD dashboard. The Acquia private key is stored as an encrypted config-entity field via DRD's encryption service.

---

- Connect a DRD dashboard to one or more Acquia Cloud subscriptions.
- Automatically import all Acquia-hosted sites into DRD as host entities.
- Import each Acquia environment (dev/test/prod) as a DRD core entity.
- Import each environment's default domain as a DRD domain entity.
- Keep DRD's inventory current as Acquia environments are added or removed.
- Store the Acquia API e-mail and private key as an encrypted account credential.
- Authenticate to the Acquia Cloud API v1 with HTTP basic auth over HTTPS.
- Retrieve environment database credentials so DRD can authorize itself remotely.
- Manage multiple Acquia accounts, each enabled or disabled independently.
- Run the Acquia inventory sync from the CLI via `drush drd:pi:sync`.
- Trigger the sync as part of a multi-platform DRD action.
- View Acquia host/core/domain counts in the DRD "Acquia" dashboard block.
- Unpublish DRD entities automatically when an Acquia site or environment is deleted.
- Re-enable DRD entities when an Acquia environment reappears.
- Centralize monitoring of Acquia-hosted Drupal sites alongside other platforms in DRD.
- Add a new Acquia account from Configuration → DRD → Acquia → Accounts.
