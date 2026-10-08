<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `extra_recipes` Project Browser source plugin

File: `src/Plugin/ProjectBrowserSource/ExtraRecipes.php`
Class: `final class Drupal\extra_project_browser\Plugin\ProjectBrowserSource\ExtraRecipes extends ProjectBrowserSourceBase`
(base class and plugin type come from the `project_browser` module). Uses `StringTranslationTrait`.

## Plugin definition

PHP attribute `#[ProjectBrowserSource(id: 'extra_recipes', label: 'Extra recipes', description: 'Recipes prefixed
with "extra_" available in this codebase.', local_task: [])]`. This registers the plugin as one of the sources
Project Browser can enable. The module defines **no new plugin type**; it implements Project Browser's existing
one.

## Dependency injection

`create()` builds the plugin from the container with:

- `FileSystemInterface` (`file_system`) — `realpath()` resolution of scan dirs.
- `cache.project_browser` (`CacheBackendInterface`) — result cache bin.
- `ModuleExtensionList` — to locate `project_browser`'s `images/recipe-logo.svg`.
- `app.root` container parameter (string) — project root for locating `../recipes`.
- `file_url_generator` (`FileUrlGeneratorInterface`) — build the logo URL.

Constructor forwards the remaining plugin args (`...$arguments`) to `parent::__construct()`. All injected services
are core/Project Browser services, so the module needs **no `*.services.yml`**.

## Data source (local disk only — no remote fetch)

`getFinder()` builds the set of directories to scan:

1. Core Recipes source's recipes path — `CoreRecipesSource::getRecipesPath()`
   (`Drupal\project_browser\Plugin\ProjectBrowserSource\Recipes`). If its basename is the literal placeholder
   `{$name}`, the parent dir is used. `realpath()`-resolved.
2. The project-root recipes dir — `realpath($appRoot . '/../recipes')`.
3. Fallback — if neither resolves, `$appRoot` itself.

It then returns `Finder::create()->files()->in(array_unique($search_in))->depth(1)->followLinks()->name('recipe.yml')`.
There is **no HTTP client, no Guzzle, no `file_get_contents` over a URL, and no request-supplied path** — the recipe
list is discovered entirely from the local codebase (trusted). `packageName`/`homepage` likewise come from a local
`composer.json`.

## Building the project list — `getProjects(array $query)`

- **Cache**: reads/writes the full built list in `cache.project_browser` keyed by the plugin id
  (`$this->getPluginId()`). Rebuilt only on a cache miss.
- **Logo**: `project_browser`'s `images/recipe-logo.svg`, turned into a `base:`-scheme URL via the file URL
  generator.
- For each `recipe.yml` the Finder yields:
  - `machine_name = basename($file->getPath())`; **skipped unless** it `str_starts_with('extra_')`.
  - **skipped** if in `EXCLUDED_MACHINE_NAMES` (const: `extra_view_modes`, `extra_paragraphs`; `extra_service_views`
    is commented out).
  - `getPackageMetadata($path)` reads `<recipe>/composer.json` → `name` (default `extra/unknown`) and `homepage`
    (default null).
  - `Yaml::decode($file->getContents())` → `title` from `name` (fallback machine name), `description` from
    `description`.
  - Creates a `Project(logo, isCompatible: TRUE, machineName, body: ['summary' => t(description)] or [], title:
    t(title), packageName, url: t(homepage) as `Url::fromUri` or null, type: ProjectType::Recipe)`. **Every entry is
    marked compatible.**
- `usort` by `strcasecmp` on title (case-insensitive alphabetical).

### Filtering & paging (in memory, over the built list)

- `$query['machine_name']` — exact `machineName` match (`array_filter`).
- `$query['search']` — `stripos` substring match on the **title** only.
- Paging — when `page` key is present and `limit` is non-empty: `array_chunk($projects, $limit)[$page] ?? []`.
- `$total = count($projects)` (before paging); returns `$this->createResultsPage($projects, $total)`.

## Filters — `getFilterDefinitions()`

Returns one filter: `'search' => new TextFilter('', t('Search'))`, so Project Browser renders a search box for this
source.

## Install / uninstall hooks

`extra_project_browser.install`:

- `hook_install()` — loads editable `project_browser.admin_settings`, and if `enabled_sources` has no
  `extra_recipes` key, adds `'extra_recipes' => []` and saves. This **auto-enables** the source; no manual config.
- `hook_uninstall()` — removes the `extra_recipes` key from `enabled_sources` and saves.

## Operating notes

- Run `drush cr` after enabling and after adding/removing recipes — the built list is cached in
  `cache.project_browser` and directory scans are only re-run on a cache miss.
- A recipe appears only if its directory name starts with `extra_`, it is not in the exclusion list, and it lives at
  depth 1 under a scanned recipes location containing a `recipe.yml`.
- Titles/descriptions are read from `recipe.yml`; the package name/homepage from a sibling `composer.json`
  (`extra/unknown` when missing). Output is rendered through Project Browser's normal (escaped) recipe UI.
