<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Source plugin, deriver, routes & permissions

## The Project Browser source plugin

`src/Plugin/ProjectBrowserSource/ApiBrowserProjectBrowserSource.php` —
`#[ProjectBrowserSource(id: 'api_browser_project', local_task: [], deriver: ApiBrowserProjectBrowser::class)]`,
extends `project_browser`'s `ProjectBrowserSourceBase`. The empty `local_task: []` is what makes each
derived source show up as a **tab** in the Project Browser UI (Project Browser's `LocalTaskDeriver`
skips sources whose `local_task` is NULL; tab title falls back to the service label).

- `__construct` reads `$plugin_definition['service']` (the `ApiBrowserService`, injected by the
  deriver) into `$this->source`.
- `getFilterDefinitions()` → a `TextFilter` "search", a `MultipleChoiceFilter` "categories" **only if
  the service defines categories**, and a `BooleanFilter` "security_advisory_coverage".
- `getProjects($query)` → `$this->source->getList($query)` (the entity does all the fetching), then
  in-PHP filters the returned `Project[]` by `machine_name`, `security_advisory_coverage`,
  `categories` (comma list intersected with `$project->categories` keys), `search` (case-insensitive
  substring of title) and `sort` (`a_z`/`z_a`), and finally pages with `array_chunk` by
  `query['limit']`/`query['page']`. Returns `createResultsPage()`.

## The deriver

`src/Plugin/Derivative/ApiBrowserProjectBrowser.php` (`ContainerDeriverInterface`). Loads **all**
`api_browser_service` entities and, for each, produces a derivative `api_browser_project:<id>` whose
definition carries `label` and the `service` entity. That is why saving a service must clear the
`ProjectBrowserSourceManager` definitions (`ApiBrowserService::invalidateCaches()`). Source plugin id
for a service = `ApiBrowserService::getSourcePluginId()` = `api_browser_project:<id>`.

**Enabling a tab:** installing the module derives sources but shows nothing until you enable the
source in Project Browser's own settings.

## Routes (`api_browser.routing.yml`) & permission

All routes are `_admin_route: TRUE` and gated by the single permission
`administer api_browser_service` (`api_browser.permissions.yml`, `restrict access: true`). Entity
access goes through `ApiBrowserServiceAccessControlHandler`, which allows on that permission and is
otherwise neutral (so core's admin-permission handling applies).

| Route | Path (under `/admin/config/development/project_browser/api_browser`) | Handler | Requirement |
|---|---|---|---|
| `entity.api_browser_service.collection` | `/service` | `_entity_list` | `_permission` |
| `entity.api_browser_service.add` | `/service/add` | `ApiBrowserServiceForm` | `_entity_create_access` |
| `entity.api_browser_service.edit_form` | `/service/{id}` | `ApiBrowserServiceForm` | `_entity_access: update` |
| `entity.api_browser_service.delete_form` | `/service/{id}/delete` | `EntityDeleteForm` | `_entity_access: delete` |
| `entity.api_browser_service.refresh` | `/service/{id}/refresh` | `Controller::refresh` | `update` **+ `_csrf_token`** |
| `entity.api_browser_service.duplicate` | `/service/{id}/duplicate` | `Controller::duplicate` | `_entity_create_access` **+ `_csrf_token`** |
| `api_browser.settings` | `/settings` | `ApiBrowserSettingsForm` | `_permission` |

Menu/task/action links (`api_browser.links.*.yml`) hang the collection and settings under
`project_browser.settings`, and add "Add Service" / "Refresh" / "Duplicate".

## Controller actions

`src/Controller/ApiBrowserServiceController.php` (both CSRF-protected):

- `refresh()` — calls `$service->invalidateCaches()` (does **not** re-fetch; the listing rebuilds on
  next view, which keeps a huge listing from timing out the request), status message, redirect to
  the collection.
- `duplicate()` — `createDuplicate()` with a fresh `<id>_copy[_n]` id and a "(copy)" label, saves,
  redirects to the copy's edit form.

The service form (`ApiBrowserServiceForm`) also adds a "Refresh cached projects" submit action and
inline "Test Listing/Project Endpoint" buttons.
