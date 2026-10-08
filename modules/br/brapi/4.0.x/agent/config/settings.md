<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BrAPI configuration

## Install / enable

```
composer require drupal/brapi   # pulls galbar/jsonpath
drush en brapi -y               # requires core datetime
```
Nothing is exposed until configured: the shipped `config/install/brapi.settings.yml` sets `v1: false`, `v2: false`, empty `v1def`/`v2def` and **no** `calls`, so no `/brapi/v1` or `/brapi/v2` route exists yet. Visit `/brapi/admin` (see below) and save settings to build the endpoints, mappings and routes; a router rebuild is needed after enabling calls (route callback `BrapiRoutes::routes`).

## Config object `brapi.settings`

Schema (`config/schema/brapi.schema.yml`) formally types only `v1`, `v1def`, `v2`, `v2def`; the admin forms write many more keys (untyped `config_object`). Keys written by `BrapiAdminForm::submitForm()` and `BrapiCallsForm`:

| Key | Meaning | Default |
|---|---|---|
| `v1` / `v2` | enable the v1 / v2 endpoint | `false` |
| `v1def` / `v2def` | active BrAPI release (e.g. `1.3`, `2.1`) used to select the JSON definition | empty |
| `calls` | nested `[version][call][method] = bool`, plus per-call `[method_access] = [role => bool]` role lists and optional `deferred` flag | unset |
| `page_size` | default pagination size | `40` (`BRAPI_DEFAULT_PAGE_SIZE`) |
| `page_size_max` | max page size a client may request | `200` (`BRAPI_DEFAULT_PAGE_SIZE_MAX`) |
| `token_default_lifetime` | seconds a new/renewed token is valid | `86400` (1 day) |
| `search_default_lifetime` | seconds a deferred-search result is cached | `604800` (1 week) |
| `insecure` | allow bearer-token auth and `/login` over plain HTTP (not HTTPS) | `false` |
| `server_name`, `server_description`, `contact_email`, `documentation_url`, `location`, `organization_name`, `organization_url` | `/serverinfo` metadata (default to `system.site` values) | site defaults |

`getCleanPageSize()` clamps a requested `pageSize` to `[1, page_size_max]`, falling back to `page_size`.

## Admin routes & permissions

All under `/brapi/admin`, gated by `_permission: 'administer site configuration,administer brapi'` (either permission suffices):
- `/brapi/admin` → `BrapiAdminForm` (versions, paging, tokens, search, server info). Menu link `system.brapi_settings` under *Configuration › Web services*.
- `/brapi/admin/datatypes` → `BrapiDataTypesForm`; `/brapi/admin/datatypes/list` + add/edit/delete → the `brapidatatype` mapping entity forms.
- `/brapi/admin/calls` → `BrapiCallsForm` (enable calls/methods, set per-call role access and deferred flag).

## Definitions

BrAPI call/data-type/field definitions live as JSON in the module's `definitions/` dir (`brapi_v1_1.2.json`, `brapi_v1_1.3.json`, `brapi_v2_2.0.json`, `brapi_v2_2.1.json`). `brapi_available_versions()` scans that dir; `brapi_get_definition($version,$subversion)` loads and statically caches one (sanitizing the version strings, then invoking `hook_brapi_definition_alter`). The `versions/openapi_*.json` files are the OpenAPI sources; `brapi_open_api_to_definition()` converts them (a build-time helper, not called at runtime).

## Permissions (`brapi.permissions.yml`)

- `use brapi` — read (GET / search) any enabled call.
- `edit brapi content` — read and write (POST/PUT/DELETE) any enabled call.
- `use restricted brapi` — only calls a client's roles are granted via per-call `*_access` settings (also opens mapping-view access).
- `administer brapi` — BrAPI admin forms.

## Cron / maintenance

`BrapiToken::purgeExpiredTokens()` deletes tokens past expiration (expiration `-1`/`<0` = never expires).
