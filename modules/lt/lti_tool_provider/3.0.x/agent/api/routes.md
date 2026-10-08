# Routes (parent + content submodule)

All machine names and paths are exact from `*.routing.yml`.

## Parent module (`lti_tool_provider.routing.yml`)

| Route | Path | Controller / target | Access | `_auth` |
|---|---|---|---|---|
| `lti_tool_provider.v1p0.launch` | `/lti` (POST) | `LTIToolProviderV1P0Launch::route` | `_custom_access` `::access` (valid launch req) | `lti_auth_v1p0`, `no-cache` |
| `lti_tool_provider.v1p0.return` | `/lti/return` | `LTIToolProviderV1P0Return::route` | `_access: 'TRUE'` | — |
| `lti_tool_provider.v1p3.login` | `/lti/v1p3/login` | `LTIToolProviderV1P3Login::route` | `_custom_access` `::access` (valid login req) | — |
| `lti_tool_provider.v1p3.launch` | `/lti/v1p3/launch` | `LTIToolProviderV1P3Launch::route` | `_access: 'TRUE'` | `lti_auth_v1p3`, `no-cache` |
| `lti_tool_provider.v1p3.return` | `/lti/v1p3/return` | `LTIToolProviderV1P3Return::route` | `_access: 'TRUE'` | — |
| `lti_tool_provider.v1p3.jwks` | `/lti/v1p3/jwks` | `LTIToolProviderV1P3Jwks::route` | `_custom_access` `::access` (valid jwks req) | — |
| `lti_tool_provider.admin` | `admin/config/lti-tool-provider` | `SystemController::systemAdminMenuBlockPage` | `_permission: administer lti_tool_provider module` | — |
| `lti_tool_provider.settings` | `/admin/config/lti-tool-provider/settings` | `LtiToolProviderSettingsForm` | `_permission: administer site configuration` | — |
| `lti_tool_provider.consumer.add` | `…/consumer/add` | `_entity_form: lti_tool_provider_consumer.add` | `_entity_create_access: lti_tool_provider_consumer` | — |
| `entity.lti_tool_provider_consumer.collection` | `…/consumer` | `_entity_list` | `_permission: administer lti_tool_provider module` | — |
| `entity.lti_tool_provider_consumer.canonical` | `…/consumer/{id}/view` | `_entity_view` | `_entity_access: …consumer.view` | — |
| `entity.lti_tool_provider_consumer.edit_form` | `…/consumer/{id}/edit` | `_entity_form: …edit` | `_entity_access: …consumer.edit` | — |
| `entity.lti_tool_provider_consumer.delete_form` | `…/consumer/{id}/delete` | `_entity_form: …delete` | `_entity_access: …consumer.delete` | — |

The launch flow: the LMS POSTs to `/lti` (1.0) or, after OIDC init at `/lti/v1p3/login`, to
`/lti/v1p3/launch` (1.3). The auth provider validates and establishes the session before the launch
controller runs and redirects. Entity access on the consumer routes resolves through
`LtiToolProviderConsumerAccessController` → `administer lti_tool_provider module`.

## Submodule routes

Roles / Attributes / Provision each add two admin forms, all gated by
`_permission: administer lti_tool_provider module`:

- `lti_tool_provider.admin.roles.lti_v1.0` (`…/roles/v1p0`), `…roles.lti_v1.3` (`…/roles/v1p3`).
- `lti_tool_provider.admin.attributes.lti_v1.0` (`…/attributes/v1p0`), `…attributes.lti_v1.3`.
- `lti_tool_provider.admin.provision.lti_v1.0` (`…/provision/v1p0`), `…provision.lti_v1.3`.

Content selection (`lti_tool_provider_content.routing.yml`), LTI 1.3 Deep Linking under
`/lti/v1p3/content/*`:

| Route | Path | Target | Access | `_auth` |
|---|---|---|---|---|
| `lti_tool_provider.admin.content` | `/admin/config/lti-tool-provider/content` | `LtiToolProviderContentSettingsForm` | `administer lti_tool_provider module` | — |
| `lti_tool_provider.content.list` | `/lti/v1p3/content/list` | `LtiToolProviderContentListForm` | `_custom_access` `::access` (session context + client_id + return) | — |
| `lti_tool_provider.content.select` | `/lti/v1p3/content/select` | `LTIToolProviderContentSelect::route` | `_custom_access` `::access` | `lti_auth_v1p3`, `no-cache` |
| `lti_tool_provider.content.return` | `/lti/v1p3/content/return` | `LTIToolProviderContentReturn::route` | `_custom_access` `::access` | — |
| `lti_tool_provider.content.launch` | `/lti/v1p3/content/launch` | `LTIToolProviderContentLaunch::route` | `_custom_access` `::access` | `lti_auth_v1p3`, `no-cache` |

Action/menu/task links live in `lti_tool_provider.links.{action,menu,task}.yml` (the
`admin/config/lti-tool-provider` hub, "Add Consumer" action, and view/edit/delete local tasks).
