<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Served files: entity, routes, settings, operation

Everything needed to configure and serve files with `serve_plain_file`. Cite files under
`src/**`, `*.routing.yml`, `config/**`.

## Install / enable

Core-only module, no Composer requirements. Enable with `drush en serve_plain_file`. Grant the
**`administer serve plain file`** permission (`serve_plain_file.permissions.yml`) to trusted roles.
`hook_uninstall()` (`serve_plain_file.install`) deletes `serve_plain_file.settings`. Admin UI:
**Administration › Configuration › System › Serve plain files**
(`/admin/config/system/served_files`), also reachable via the config-system menu link
(`serve_plain_file.links.menu.yml`).

## The `served_file` config entity

Defined in `src/Entity/ServedFile.php` (`@ConfigEntityType id = "served_file"`, config prefix
`served_file`, admin permission `administer serve plain file`). `config_export` keys — schema in
`config/schema/serve_plain_file.schema.yml` (`serve_plain_file.served_file.*`):

- `id` (string, machine name) / `label` (string) — entity id and human label.
- `path` (string) — URL path the file is served at, stored **without** a leading slash
  (e.g. `ads.txt`). `getPath()`.
- `content` (string) — the raw body returned in the response. `getContent()`;
  `getContentHead()` returns the first ~20 chars for the list builder.
- `max_age` (integer) — cache max-age in seconds. `getFileMaxAge()` casts to int.
- `mime_type` (string) — Content-Type to send. `getMimeType()`; default constant
  `ServedFile::DEFAULT_MIME_TYPE = 'text/plain'`.
- `langcode` — standard config-entity language; a served file is bound to one language.

`getLinkToFile()` / `pathToUrl()` build an absolute URL for the admin list, deliberately ignoring
language path-prefix negotiation.

## Settings config: allowed MIME-types

`config/install/serve_plain_file.settings.yml` ships `allowed_mime_types` (a map) with:
`text/plain`, `text/csv`, `application/json`, `application/xml`, `text/html`. This is the allowlist
offered in the form's MIME-Type select and enforced at serve time. There is no admin form for the
setting itself — edit `serve_plain_file.settings:allowed_mime_types` via config
import/`drush cset` (per README `@see serve_plain_file.settings.yml`). `text/plain` is always
available (merged in by the form and used as the fallback).

## Admin routes (static)

`serve_plain_file.routing.yml`, all requiring `_permission: 'administer serve plain file'`:

- `entity.served_file.collection` — `/admin/config/system/served_files`, `_entity_list`
  (list builder `ServedFileListBuilder`: columns Label, Path, Content head, Language).
- `entity.served_file.add_form` / `entity.served_file.edit_form` (`/{served_file}`) — the
  add/edit form `ServedFileForm`. An "Add file" action link comes from
  `serve_plain_file.links.action.yml`.
- `entity.served_file.delete_form` (`/{served_file}/delete`) — `ServedFileDeleteForm`
  (confirm form).

Note: the static admin route paths use `.../served_files/...` while the entity's `links`
annotation points at `.../serve_plain_file/...`; day-to-day editing goes through the collection +
action link, which use the `served_files` routes.

## Add/edit form (`src/Form/ServedFileForm.php`)

Fields: `label` (required), `id` (machine name, locked after create), `max_age` (number, min 0),
`mime_type` (select from allowlist + `text/plain`), `path` (required textfield), `content`
(required textarea), `langcode` (language select — **disabled unless** domain-based negotiation is
on; a warning item is shown when it is off).

- `save()` stores `ltrim($path, '/')`, shows a message, redirects to the collection, and calls
  `router.builder->rebuild()` so the new path's dynamic route is registered immediately.
- `validateForm()` rejects the path if `file_exists($appRoot . '/' . $path)` (won't let you shadow
  a real on-disk file) and rejects a duplicate `path` + `langcode` (excluding the current entity).
- Delete (`ServedFileDeleteForm::submitForm`) deletes the entity and rebuilds routes.

## Dynamic serving route + controller

`src/Routing/ServePlainFileRoutes::routes()` (wired as `route_callbacks` in the routing.yml) loads
all `served_file` entities and adds one `Route('/'.$path)` per distinct path, named
`serve_plain_file.served_file.<sha1(path)[0:16]>.route`, with:

- `_controller` → `ServePlainFile::content`
- `_disable_route_normalizer: TRUE` (prevents multilingual redirects to a language prefix)
- `requirements` → `_access: 'TRUE'` (public — these files are meant to be crawler/anon reachable)

`src/Controller/ServePlainFile.php::content()`:

1. If `lupus_ce_renderer` is enabled and the request's preferred format is `custom_elements`,
   redirects to the scheme+host+path (bypasses the API prefix). Otherwise:
2. Resolves the langcode: default language, unless `language.negotiation` `url.source === 'domain'`,
   then current language.
3. Loads `served_file` by `['path' => ltrim($request->getPathInfo(), '/'), 'langcode' => $langcode]`
   and picks the entity whose language matches.
4. If found and the path matches exactly, returns a `Response` with the entity's `content`,
   `Content-Type` = the entity `mime_type` **only if it is in `allowed_mime_types`, else
   `text/plain`**, `setPublic()`, `setMaxAge($max_age)`, and an `Expires` header at
   request-time + max_age. Otherwise throws `NotFoundHttpException`.

## Operating notes

- After editing config directly (import), routes rebuild on cache clear; the form path rebuilds
  routes itself.
- To keep files editable in production without config import clobbering them, add the
  `serve_plain_file.served_file.*` config to Config Ignore (README recommendation).
- For external caches (Varnish/CDN), watch the entity and purge — see
  [../api/served-file-entity.md](../api/served-file-entity.md) for `getUrlsForCachePurging()`.
