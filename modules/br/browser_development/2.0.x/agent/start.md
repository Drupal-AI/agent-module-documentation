<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Browser Development (browser_development) — agent index

In-browser SCSS editor: author SCSS, live-compile it to CSS with **scssphp/scssphp**, apply it to the current theme, write the CSS to the public filesystem, and store the SCSS source as a portable **config entity**. Package `Browser Development`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 2.0.0-beta13. Composer requires `scssphp/scssphp:*` (no Drupal module deps).

- **Routes, the POST `api` command dispatch, SCSS compilation and file writes** → [api/api.md](api/api.md)
- **Settings form + the `browser_development.settings` config object** → [config/settings.md](config/settings.md)
- **The `browser_development_storage` config entity, list builder and forms** → [entities/storage.md](entities/storage.md)
- **Submodule `browser_development_assist`** (re-attaches the compiled CSS) → [modules/browser_development_assist/2.0.x/agent/start.md](modules/browser_development_assist/2.0.x/agent/start.md)

## What it actually is (from source)

- Four routes in `browser_development.routing.yml`, all with `_permission: 'TRUE'`:
  `browser_development.home` (`/admin/browser-development`, `Controller\Home::getContent`),
  `.settings` (`/admin/browser-development/settings`, `Form\Settings`),
  `.editor` (`/admin/browser-development/editor`, `Controller\Editor::getContent`),
  `.api` (`/admin/browser-development/api`, POST, `Controller\Api::getApi`).
- **`_permission: 'TRUE'` requires a permission literally named `TRUE`.** No `*.permissions.yml` exists and no role defines it, so every route fails closed — only the superuser (uid 1, via the super-user access policy) can reach them. This is a functional over-restriction, not an open door.
- `Controller\Api::getApi()` decodes the raw JSON POST body and switches on which key is set: `live` → `LiveScssCompiler::compiler()` (compile only, returns `live_response`); `compiled` → `Storage::setStorage()` (saves a `browser_development_storage` entity with `serialize()`d payload) then `ScssCompiler::compiler()` (writes `.scss` files, compiles, writes CSS to disk); `open` → `Storage::getStorage()` (returns the last saved snippet, `unserialize()`d).
- `Controller\Editor` renders `templates/bd-editor.html.twig` directly through the Twig service — a React/ACE single-page app whose JS/CSS are the prebuilt assets under `assets/dist/`. `browser_development_page_attachments()` attaches library `browser_development/browser-development` (`assets/js/browser-development.js`, a no-op Drupal behavior) only on the editor path.
- **Config entity** `BrowserDevelopmentStorage` (`@ConfigEntityType` id `browser_development_storage`, `admin_permission = "administer site configuration"`): stores `id`, `label` (creation date), `json_obj` (serialized SCSS payload). Handlers: `BrowserDevelopmentStorageListBuilder`, add/edit `BrowserDevelopmentStorageForm`, delete `BrowserDevelopmentStorageDeleteForm`, `BrowserDevelopmentStorageHtmlRouteProvider`. Routes at `/admin/browser-development/storage[...]`. Schema in `config/schema/browser_development_storage.schema.yml`.
- **Processing classes** (`src/Processing/`): `FileSystemStructure` (paths under `public://browser-development/`, dir/file creation), `ScssCompiler` / `LiveScssCompiler` (scssphp wrappers), `SavingCssToDisk` (writes compiled CSS + invalidates render cache), `Storage` (config-entity CRUD for snippets), `FormsStorage` (reads/writes the `browser_development.settings` config object).
- Hooks: `hook_help`, `hook_page_attachments`, `hook_module_implements_alter` (orders `page_attachments`), `hook_theme_suggestions_table_alter`. Menu link `entity.browser_development_storage.collection` under *Structure*.
- No Drush commands, no custom permissions, no plugin types. `provides_config_schema: true`.
