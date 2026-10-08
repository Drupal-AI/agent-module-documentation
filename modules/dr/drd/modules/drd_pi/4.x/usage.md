<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DRD Platform Integration (drd_pi) is an abstract framework submodule of DRD that lets other submodules import and keep in sync a hosting platform's site inventory (hosts, cores, domains) as DRD entities.

---

drd_pi ships no configuration UI of its own. It provides the reusable PHP building blocks that platform-specific submodules (drd_pi_acquia, drd_pi_pantheon, drd_pi_platformsh) extend: an abstract `DrdPiAccount` config-entity base that talks to a hosting API and encrypts its credentials, the `DrdPiHost` / `DrdPiCore` / `DrdPiDomain` value objects representing a platform's inventory, a shared account form and list builder, and read-only base fields (`pi_type`, `pi_account`, `pi_id_host`, `pi_id_core`, `pi_id_domain`) that are attached to DRD's own `drd_host`, `drd_core` and `drd_domain` entities so each imported entity remembers where it came from. A `drd_action_pi_sync` DRD action (also exposed as the `drd:pi:sync` Drush command and a dashboard block) walks every enabled platform account and reconciles the remote inventory with DRD: new remote entities are created, ones that disappeared are unpublished, and returning ones are re-enabled.

---

- Provide a common base class for a new hosting-provider integration submodule.
- Model a remote platform's hosts, cores and domains without writing entity CRUD by hand.
- Attach the "which platform did this come from" tracking fields to DRD host/core/domain entities.
- Store a platform account's API credential as an encrypted config-entity field.
- Reconcile DRD inventory against a platform: create newly-found sites automatically.
- Automatically unpublish DRD entities for sites that no longer exist on the platform.
- Re-enable DRD entities for sites that reappear on the platform.
- Run a full multi-platform inventory sync from the CLI with `drush drd:pi:sync`.
- Trigger the same sync as a DRD action (`drd_action_pi_sync`) from the dashboard.
- Show a "Platform Integrations" widget block on the DRD dashboard.
- Loop over every enabled account of every registered platform type in one pass.
- Determine a remote site's reachable base URL by probing https then http.
- Inject a platform-provided Authorization header into a DRD domain entity for remote access.
- Provide platform-specific database/auth secrets so DRD can authorize itself on a remote site.
- Give provider submodules a consistent account collection/add/edit/delete UI.
- Keep imported credentials out of plaintext config by using DRD's encryption service.
- Serve as the shared dependency that Acquia, Pantheon and Platform.sh submodules build on.
- Run a platform sync headlessly from cron or a deployment pipeline via Drush.
