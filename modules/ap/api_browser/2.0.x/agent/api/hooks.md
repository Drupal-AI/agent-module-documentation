<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks (`api_browser.api.php`)

The module invokes these alter hooks via `moduleHandler()->alter([...])`. Each has a generic form
and an entity-specific form suffixed with the service id (`_<ENTITY_ID>`), invoked together so the
entity-specific one wins. All are pure customisation points — no new plugin types are defined.

| Hook | Invoked in | Purpose |
|---|---|---|
| `hook_api_browser_project_list_request_alter(&$options, &$endpoint)` | `makeListingRequest()` | Adjust Guzzle options / listing endpoint before the listing request is sent. |
| `hook_api_browser_project_list_alter(&$items)` | `queryListingEndpoint()` (as `api_browser_project_list`) | Alter the decoded listing body before the JMESPath `path` is applied. |
| `hook_api_browser_project_request_alter(&$options, &$endpoint, $list_item)` | `makeProjectRequest()` | Adjust options / endpoint for a per-project request (e.g. set a `Content-Type`). |
| `hook_api_browser_project_info_data_alter(&$projectInfo, $results)` | via `api_browser_project_info` in `mergeProjectResponse()` | Alter the decoded per-project response before its `path` is applied. |
| `hook_api_browser_project_browser_project_alter(Project &$project, $data)` | `instantiateProject()` | Alter the built `Project` object before it enters the listing (e.g. override `machineName`). |
| `hook_api_browser_auth_types_alter(&$list)` | `getAuthTypes()` | Add/relabel authentication types. |
| `hook_api_browser_auth_config_screen_alter(&$config_screen, $auth_type, $credentials)` | `getAuthConfigScreen()` | Add credential form fields for a custom/existing auth type. |
| `hook_api_browser_authorize_request[_ID]` | `authorizeRequest()` | Adjust request options/credentials after the built-in auth handling (no `.api.php` stub, but invoked). |

Notes:
- The name in `queryListingEndpoint()` is invoked as `['api_project_project_list_' . $id,
  'api_browser_project_list']` — the generic `hook_api_browser_project_list_alter` is the documented
  one and is the form that fires for every service.
- Twig templates in the field mapping / filters / endpoints are usually enough; reach for these
  hooks only when you need to touch the raw request, response or `Project` object in PHP.
