<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DRD Platform Integration: Platform.sh (drd_pi_platformsh) imports and keeps in sync your Platform.sh project inventory (projects, environments, domains) into DRD.

---

This submodule plugs Platform.sh into DRD's platform-integration framework (drd_pi). You create one or more `platformsh_account` config entities, each holding a Platform.sh API token; the module uses the official `platformsh/client` PHP library (which authenticates over HTTPS by exchanging the token) to enumerate your active projects as DRD hosts, their active environments that have code as DRD cores, and each environment's public route host as a DRD domain. Where an environment protects itself with HTTP basic auth, the credentials are captured and injected as an Authorization header so DRD can reach it. Accounts are managed at Configuration → DRD → Platform.sh; the sync is run through the shared `drd_action_pi_sync` action, the `drush drd:pi:sync` command, or the DRD dashboard. The API token is stored as an encrypted config-entity field via DRD's encryption service.

---

- Connect a DRD dashboard to one or more Platform.sh accounts.
- Automatically import all active Platform.sh projects into DRD as host entities.
- Import each active, code-bearing Platform.sh environment as a DRD core entity.
- Import each environment's public route host as a DRD domain entity.
- Capture per-environment HTTP basic-auth credentials as an Authorization header.
- Authenticate via the official platformsh/client library using an API token.
- Store the Platform.sh API token as an encrypted account credential.
- Keep DRD's inventory current as Platform.sh environments are added or removed.
- Skip inactive projects and environments without code during import.
- Manage multiple Platform.sh accounts, each enabled or disabled independently.
- Run the Platform.sh inventory sync from the CLI via `drush drd:pi:sync`.
- Trigger the sync as part of a multi-platform DRD action.
- View Platform.sh host/core/domain counts in the DRD "PlatformSH" dashboard block.
- Unpublish DRD entities automatically when a project or environment is removed.
- Re-enable DRD entities when a Platform.sh environment reappears.
- Add a new Platform.sh account from Configuration → DRD → Platform.sh → Accounts.
