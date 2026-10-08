<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring SODa SCS manager

Settings form: `/admin/config/soda-scs-manager/settings` (`soda scs manager admin`).

Configure the external service endpoints and credentials the action services use:
- **Portainer / Docker**: base URL + API token used by `SodaScsPortainerServiceActions`, `SodaScsDockerRunServiceActions`, `SodaScsDockerExecServiceActions`, `SodaScsDockerVolumesServiceActions`, `SodaScsDockerRegistryServiceActions`.
- **Keycloak**: realm/client used by the OIDC login and `SodaScsKeycloakService*Actions`; core `user.login`/`user.pass` routes are disabled by `SodaScsDisableDrupalLoginRouteSubscriber`.
- **Nextcloud**: endpoint + Login-Flow-v2 connect; credentials stored via `NextcloudMountCredentialsStore` (encrypted attribute).
- **Triplestore / OpenGDB** endpoint for `SodaScsOpenGdbServiceActions`.

Operational notes:
- Register users at `/user/register` (Keycloak form → pending approval at `/admin/people/keycloak-registrations`, `administer users`).
- Debug tools at `/soda-scs-manager/debug` and snapshot integrity at `/soda-scs-manager/debug/snapshots` are admin-only.
- Treat the Portainer token and Keycloak/Nextcloud credentials as high-value secrets; all docker exec/run routes are gated by `soda scs manager admin`/owner access.
