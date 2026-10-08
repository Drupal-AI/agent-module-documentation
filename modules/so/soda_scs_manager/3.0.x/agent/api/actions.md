<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SODa SCS manager — action service surface

Provisioning logic lives in tagged, autowired services (all `public: true`):

**Component/Stack actions** — `soda_scs_manager.component.actions`, `.sql_component.actions`, `.triplestore_component.actions`, `.wisski_component.actions`, `.webprotege_component.actions`; `.stack.actions`, `.jupyter_stack.actions`, `.nextcloud_stack.actions`, `.wisski_stack.actions`.

**Request actions (external APIs)** — `.portainer_service.actions`, `.docker_run_service.actions`, `.docker_exec_service.actions`, `.docker_volumes_service.actions`, `.docker_registry_service.actions`, `.opengdb_service.actions`, `.keycloak_service.{client,group,user}.actions`, `.nextcloud_service.actions`.

**Service / key / snapshot** — `.sql_service.actions`, `.service_key.actions`, `.snapshot.actions` (+ `.snapshot.integrity.helpers`).

Controllers exposing these to HTTP (all permission-gated):
- Health: `SodaScsComponentController::componentStatus`, `SodaScsStackController::stackStatus`.
- Progress: `SodaScsProgressController::getLatestSteps` (UUID-constrained route).
- Service links: `SodaScsManagerServiceController::{generateComponentUrl,getComponentServiceUrl,generateStackUrl,getStackServiceUrl}` with owner `_custom_access`.
- Package inspection (admin): `SodaScsComponentController::{checkDrupalPackages,installedDrupalPackages,installedDrupalPackagesJson}`.

Docker exec commands are built server-side by `SodaScsDockerExecServiceActions` against the configured Portainer endpoint; the route surface is limited to `soda scs manager admin`/owner access.
