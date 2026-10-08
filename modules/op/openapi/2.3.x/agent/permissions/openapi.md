# openapi — permissions

From `openapi.permissions.yml` (one permission):

| Permission | Machine name | Gates |
|---|---|---|
| Access API Docs | `access openapi api docs` | Viewing/downloading all OpenAPI output: the spec download route `openapi.download` (`/openapi/{generator}`), the admin list `openapi.downloads` (`/admin/config/services/openapi`), and the UI route `openapi.documentation` when `openapi_ui` is installed. |

Notes:
- This is a single gate for every OpenAPI route (all three routes require it via `_permission`).
- Description: "Access documentation page for the REST API".
- Grant only to trusted roles: the spec reveals your API's entity/bundle structure, paths, and
  supported authentication schemes.
