<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `api_browser_service` config entity

`src/Entity/ApiBrowserService.php` — a `ConfigEntityBase` (`#[ConfigEntityType(id: 'api_browser_service', config_prefix: 'service')]`).
`entity_keys`: `id`, `label => name`, `uuid`. `admin_permission: 'administer api_browser_service'`.
This one class is both the stored config **and** the HTTP + mapping engine (fetch, page, filter,
map). Schema: `config/schema/api_browser.schema.yml`. Six examples in `config/install/`
(`api_browser.service.packagist_*`).

## Stored config (`config_export`)

`id`, `name`, `description`, `categories`, `listing`, `search`, `project`, `listing_filter`,
`filter`, `log_requests`, `field_mapping`.

- `listing` (schema `api_browser.listing`, extends `api_browser.request`): `endpoint` (uri, required),
  `method` (`GET`/`POST`), `auth`, `credentials`, `path` (JMESPath to the record list), plus
  `pagination`.
- `pagination` (`api_browser.pagination`): `style` (`page` | `cursor`), `page`, `per_page`,
  `cursor`, `next` (JMESPath to next cursor). **Pagination is on only when the driving parameter is
  named** — no separate boolean (`getListingPaginationEnabled()`).
- `project` (`api_browser.request`): same shape, but `endpoint` is a **plain string** — an empty
  endpoint is the switch that turns the per-project request off (`getProjectEndpointEnabled()`).
- `search` (`api_browser.search`): sequence of `{parameter, value}` sent on every listing request.
  A trailing `[]` (e.g. `fields[]`) is treated as a repeatable parameter.
- `field_mapping` (`api_browser.field_mapping`): one Twig template per Project field — `type`,
  `package_name`, `machine_name`, `url`, `logo`, `title`, `short_description`, `long_description`,
  `compatible`, `maintained`, `covered`, `project_usage_total`, `categories`, `images`.
- `listing_filter` / `filter`: Twig conditions (see Filtering).
- `categories`: sequence of `{id, label}` (edited in the form as `id|label` lines).
- `log_requests`: bool.

## Request pipeline (how a listing becomes projects)

1. `getList($query)` → `getProjectList()`. Results are cached under cid `<id>:results` (tags
   `api_browser:results`, `api_browser:results:<id>`), so the listing endpoint is hit only on a
   cold cache.
2. `queryListingEndpoint()` builds the request (`makeListingRequest()`), sends it via
   `\Drupal::httpClient()->send($request, $this->getRequestOptions())`, JSON-decodes the body, runs
   the `api_browser_project_list` alter, then applies the listing `path` with JMESPath
   (`\JmesPath\search`). It recurses to walk pages up to `MAX_LISTING_PAGES = 100` (page-number
   style keeps going while a full page comes back; cursor style follows `next` until it is empty or
   repeats).
3. Records are normalised to arrays with an `item_key`, then `applyListingFilter()` drops records
   the `listing_filter` excludes **before** any per-project request.
4. `buildProjects()` — cached records are built directly; the rest go through
   `fetchProjectResults()`, which fires the per-project endpoint for **all** pending records
   concurrently with a Guzzle `Pool` (concurrency from settings, default 20). Each response is
   merged into its record (`mergeProjectResponse()` → `api_browser_project_info` alter → project
   `path` JMESPath).
5. `passesFilter()` (the `filter` Twig condition) decides keep/drop; excluded records are cached as
   `NULL` so they are not re-requested. Kept records go through `mapProjectInfo()`.
6. `mapProjectInfo()` renders each `field_mapping` template against the merged record and returns an
   array unpacked as named args into `\Drupal\project_browser\ProjectBrowser\Project`
   (`instantiateProject()`). A project whose `type` is not a `ProjectType` (module/recipe) is
   dropped and reported once per type. Per-project info is cached under
   `<id>:result:<md5(record)>`.

## JMESPath and Twig

- `path` fields (listing `path`, project `path`, cursor `next`) are **JMESPath** expressions run
  with `mtdowling/jmespath.php` (`use function JmesPath\search`). The project `path` is itself
  rendered through Twig first, so it can reference the record (`{{ item_key }}`).
- Every `field_mapping` value, the `endpoint` of the project request, both filters and the project
  `path` are **Twig**. `renderTwigTemplate()` wraps the template in `{% apply spaceless %}…` and
  renders it with `renderer->renderInIsolation()` against the record as `#context`. Errors are
  logged and yield an empty string. Templates are admin-authored config; the record data is the
  render context (variables), not the template.
- Helpers around mapping: `mapUrl()` (validates the URL, turns a leading `/` into a `base:` URI,
  else requires `FILTER_VALIDATE_URL`), `mapCategories()` (matches ids/labels against the service's
  own vocabulary), `mapImages()`, `mappedBool()`/`mappedInt()` (distinguish "unset" NULL from a
  real FALSE/0), `getMachineName()` (transliterate).

## Filtering

Both filters are Twig, evaluated by `evaluateCondition()`: a record is **excluded** when the
template renders to `''`, `'0'`, `'false'`, `'no'` or `'off'` (case-insensitive); anything else
keeps it. `listing_filter` runs on the raw listing record (cheap — no request). `filter` runs after
the project endpoint, on the full data. Example filters (from the form): `{{ type in ["drupal-module",
"drupal-recipe"] }}`, `{{ abandoned ? 0 : 1 }}`, `{{ downloads.total > 100 }}`.

## Caching & lifecycle

- `postSave()`/`postDelete()` call `invalidateCaches()` → invalidates
  `api_browser:results:<id>`, `api_browser:project_info:<id>`, `project_browser:<sourcePluginId>`
  **and** clears the `ProjectBrowserSourceManager` cached definitions (the deriver embeds the entity
  in the plugin definition). So Drush/config-import saves refresh too, not just the form.
- `testListingEndpoint()` / `testProjectEndpoint()` power the form's Test buttons — they fire the
  request and return the URL + pretty-printed JSON + a preview Project.

## Authentication & settings

Auth (`authorizeRequest()`, `resolveSecret()`, `getOauth2Token()`) → see
[authentication.md](authentication.md). Concurrency / retries / caching → see
[../config/settings.md](../config/settings.md).
