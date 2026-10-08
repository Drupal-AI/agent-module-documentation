<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Serve Plain File (serve_plain_file) — agent index

Serves **admin-configured plain-text files** (ads.txt, site-verification, sellers.json, etc.) at
chosen URLs. Content and path are stored as **`served_file` config entities**, not read from the
filesystem. No non-core dependencies. Core requirement `^8 || ^9 || ^10 || ^11`. Package: none
declared. License GPL-2.0-or-later. Version **8.x-1.11** (version-dir `8.x-1.x`).

- **The `served_file` config entity, admin routes, the dynamic serving route/controller, settings,
  permissions and how to operate it** → [config/served-files.md](config/served-files.md)
- **The entity API (`ServedFileInterface`) for cache-purge integration** →
  [api/served-file-entity.md](api/served-file-entity.md)

## What it actually is

- One config entity type: **`served_file`** (`src/Entity/ServedFile.php`, config prefix
  `serve_plain_file.served_file`), with fields `id`, `label`, `path`, `content`, `max_age`,
  `mime_type`, `langcode`. Admin permission `administer serve plain file`.
- Static admin routes in `serve_plain_file.routing.yml` (collection/add/edit/delete under
  `/admin/config/system/served_files`) plus a **dynamic route callback**
  `ServePlainFileRoutes::routes()` that registers one public route per configured path.
- Controller `ServePlainFile::content()` returns the entity's stored `content` with the configured
  MIME-Type (validated against the `serve_plain_file.settings` `allowed_mime_types` allowlist,
  default `text/plain`) and cache max-age.
- Provides: 1 config entity type, 1 permission, config schema, a settings config object. **No**
  plugin types, **no** Drush, **no** fields/widgets, **no** services. `.module` file is empty.

## Key facts (from source)

- The served body is **config data**, never a file read from disk — there is no request- or
  config-supplied filesystem path, so no path-traversal surface. Dynamic serving routes use
  `_access: 'TRUE'` because these files (ads.txt, verification) are meant to be public.
- Add/edit form (`ServedFileForm`) `ltrim`s the leading `/` from the path, rejects a path where a
  **real file already exists** (`file_exists($appRoot . '/' . $path)`), rejects duplicate
  path+langcode, and calls `router.builder->rebuild()` on save/delete so the dynamic route appears.
- Multilingual serving only takes effect when `language.negotiation` `url.source === 'domain'`;
  otherwise the language select is disabled and the default language is used.
