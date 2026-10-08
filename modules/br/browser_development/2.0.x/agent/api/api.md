<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes & the POST `api` endpoint

## Routes (`browser_development.routing.yml`)

| Route | Path | Handler | Method | Requirement |
|-------|------|---------|--------|-------------|
| `browser_development.home` | `/admin/browser-development` | `Controller\Home::getContent` | GET | `_permission: 'TRUE'` |
| `browser_development.settings` | `/admin/browser-development/settings` | `Form\Settings` | GET/POST | `_permission: 'TRUE'` |
| `browser_development.editor` | `/admin/browser-development/editor` | `Controller\Editor::getContent` | GET | `_permission: 'TRUE'` |
| `browser_development.api` | `/admin/browser-development/api` | `Controller\Api::getApi` | POST | `_permission: 'TRUE'` |

`_permission: 'TRUE'` names a permission `TRUE`. No `browser_development.permissions.yml` exists and no role can grant it, so `PermissionAccessCheck` denies every non-superuser; only uid 1 (super-user access policy) reaches these routes. Entity routes at `/admin/browser-development/storage[...]` are separate and gated by the entity's `admin_permission = "administer site configuration"` (see [../entities/storage.md](../entities/storage.md)).

## `Controller\Api::getApi(Request $request)`

Reads the raw request body with `json_decode($request->getContent(), TRUE)`. On JSON error returns `{"api_response": "Json request was not completed"}`. Otherwise a `switch ($data)` with `case isset($data[...])` dispatches on which top-level key is present:

- **`live`** → `new LiveScssCompiler()->compiler($data)`. Compiles `$data['live']` as an SCSS string (scssphp `Compiler::compileString`, `OutputStyle::COMPRESSED`) and returns `{"live_response": <css>}`. Compile-only; nothing is written to disk or storage. Used for the editor's live preview.
- **`compiled`** → `Storage::setStorage($data)` then `new ScssCompiler()->compiler($data)`. Persists the payload as a config entity **and** writes files (see below). Returns `{"compiled_response": <css>}`.
- **`open`** → `Storage::getStorage($data)`. Loads the most recently created `browser_development_storage` entity and returns its `unserialize()`d payload (or `unserialize('{}')` when none exist).
- default → `{"api_response": "Request was not completed"}`.

All results are wrapped in a `JsonResponse`. The route has no `_csrf_token`; because it is superuser-only this is not reachable by other users.

## `ScssCompiler::compiler(array $data)` (extends `FileSystemStructure`)

1. `clearDirectory()` — `glob()`s and `unlink()`s existing files in `public://browser-development/scss/`.
2. For each entry in `$data['compiled']`: `createFilesAndAddData()` derives a filename from `$file['title']` (`strtolower`, spaces → `-`, `.scss` suffix; random 1–999 when no title), `fwrite`s `$file['code']` to `<scss_directory>/<name>`, `chmod 0755`, and records compile order.
3. `compileFiles()` writes a `main.scss` of `@import` statements, sets scssphp import paths to the scss dir, and compiles `@import "main.scss";` to compressed CSS.
4. `new SavingCssToDisk($this->compiledScss)` writes the CSS to disk and calls `cache.render` `invalidateAll()`.

## `FileSystemStructure` (paths)

`$globalFilePathArray` defaults: `base_path` `public://browser-development/`, `css_directory` `css`, `scss_directory` `scss`, `uri_path` `files/browser-development/css`, `css_name` map `default.css` / `inline.css` / `admin.css`. Constructor resolves the absolute path via `file_system->realpath()` and, on first run, `mkdir`s the public/css/scss dirs. `base_path` is overridden from the `browser_development_settings` config if present (the settings form pins it read-only to `public://browser-development/`). `getCssFilePath($file_name)` returns `DRUPAL_ROOT/<site path>/files/browser-development/css/<css_name[$file_name]>` — the path the compiled CSS is written to and that the assist submodule re-attaches.

## `SavingCssToDisk`

Constructor calls `writeToFile(print_r($data, 1))` (from `FileSystemStructure`) to the default CSS path, then invalidates the render cache so the new stylesheet is picked up.
