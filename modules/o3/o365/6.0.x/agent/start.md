<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microsoft 365 Connector (o365) — agent index

Connector to Microsoft 365 / Entra ID and the Microsoft Graph API. Gives developers a
`GraphService` to read/write Graph data (users, groups, mail, calendar, SharePoint,
OneDrive, Teams) and an OAuth2 sign-in flow (delegated authorization_code via the
`o365_sso` submodule, plus an app-only client_credentials `oauth2_client` plugin).
A site can define multiple **connectors** (one per Microsoft app registration).

- Requires contrib `oauth2_client` (^4.0) and `externalauth` (^2.0); pulls in the
  `microsoft/microsoft-graph` (^1.40) and `xantios/mimey` composer libraries.
- Configure route: `o365.settings_form` → `/admin/config/system/o365/settings`.
- Defines permissions (7), config schema, a config entity type, block base classes,
  and one hook it invokes for others. No drush commands. No plugin type of its own.

Solution docs:
- **Register the Microsoft app / set client credentials + connectors** → [configure/settings.md](configure/settings.md)
- **Map Microsoft 365 groups to Drupal roles** → [configure/role-mapping.md](configure/role-mapping.md)
- **Call the Microsoft Graph API from code** → [api/graph-service.md](api/graph-service.md)
- **Use the other public services (auth, helpers, constants, persona, logger)** → [api/services.md](api/services.md)
- **Build a block that renders per-user Graph data** → [api/blocks.md](api/blocks.md)
- **Add extra Graph authorization scopes** → [hooks/auth-scopes.md](hooks/auth-scopes.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- **Credentials live in `settings.php`, not in config**: `$settings['o365'][<connector_id>]`
  with keys `client_id`, `client_secret`, `tenant_id` (read by `HelperService::getApiConfig()`;
  tenant defaults to `common`). The connector config entity only stores `redirect_login` and
  `auth_scopes`.
- Config entity type **`o365_connector`** (`config_prefix: o365_connector`, admin permission
  `administer o365 connectors`). CRUD under `/admin/config/system/o365/settings/o365-connectors`.
- Config objects: **`o365.settings`** (key `verbose_logging`), **`o365.role_settings`**
  (`default_role`, `roles_map`, `safe_roles`).
- Service ids: `o365.graph` (GraphService), `o365.authentication` (AuthenticationService),
  `o365.helpers` (HelperService), `o365.constants` (ConstantsService), `o365.roles` (RolesService),
  `o365.profile_render` (PersonaRenderService), `o365.logger` (O365LoggerService),
  `o365.role_event` (RoleEventSubscriber).
- Hook invoked: `hook_o365_auth_scopes(array &$scopes, O365ConnectorInterface $connector)`.
- Routes: `o365.settings_form`, `o365.auth_scopes` (`/admin/reports/o365-auth-scopes`),
  `o365.role_settings`, `o365.debugger`, `entity.o365_connector.*`.
- 14 submodules (`o365_sso`, `o365_sso_user`, `o365_profile`, `o365_outlook_mail`,
  `o365_outlook_calendar`, `o365_onedrive`, `o365_sharepoint_file`, `o365_sharepoint_field`,
  `o365_contacts`, `o365_groups`, `o365_teams`, `o365_links`, `o365_rest`, `o365_profile_rest`) —
  see [configure/settings.md](configure/settings.md) for the list.
- `o365.install` update hooks (`o365_update_10001`–`10003`) and `o365.post_update.php` migrate the
  old single-connector config to the entity; run `drush updatedb` after upgrading.
