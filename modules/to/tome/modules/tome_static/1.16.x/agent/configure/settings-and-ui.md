<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Static — settings, UI, permission, state

**No config object / no `configure` route.** Configuration is `settings.php` + state.

## settings.php keys (via Settings::get, relative to the Drupal root)
| Key | Default | Meaning |
|---|---|---|
| `tome_static_directory` | `../html` | Output directory for generated HTML (`getStaticDirectory()`). |
| `tome_static_path_exclude` | `[]` | Paths to exclude from generation (used by `ExcludePathSubscriber`). |
| `tome_static_cache_exclude` | `[]` | Paths the `cache.tome_static` bin must never cache (`StaticCache`). |

## Admin UI (permission: `use tome static`, restrict access: true)
Menu root `/admin/config/tome/static` (`tome_static.main`):
- `tome_static.generate` → `/admin/config/tome/static/generate` — StaticGeneratorForm (runs a build).
- `tome_static.download_page` / `tome_static.download` → download the latest build as an archive.
- `tome_static.preview_form` / `tome_static.preview_exit` → preview the build inside Drupal.

## State keys (runtime, not config)
- `tome_static.url` — base URL used for the last build (also the Generate form's default).
- `tome_static.building` — TRUE while a build runs; deleted on uninstall.

## Services worth knowing
- `tome_static.generator` (`StaticGenerator`) — `getPaths()`, `requestPath()`, `exportPaths()`,
  `getStaticDirectory()`, `prepareStaticDirectory()`, `cleanupStaticDirectory()`.
- `cache.tome_static` (`StaticCache`) — dedicated cache bin for rendered output.
- Decorators: `page_cache_request_policy`, `context.repository`, `path.matcher` are decorated so
  per-request state can be reset between rendered requests.
