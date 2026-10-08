<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MaintainersFetcher plugins & the fetch → merge → render pipeline

## Plugin type
- Manager: `MaintainersFetcherManager` (`src/Plugin/MaintainersFetcher/MaintainersFetcherManager.php`), a `DefaultPluginManager`. Discovery dir `Plugin/MaintainersFetcher`, interface `MaintainersFetcherInterface`, annotation `Drupal\extend_help_maintainers\Annotation\MaintainersFetcher`. Cache bin key `extend_help_maintainers_fetchers`; alter hook `extend_help_maintainers_fetcher_info`. Service id `extend_help_maintainers.maintainers_fetcher_manager` (tagged `default_plugin_manager`).
- `getSortedDefinitions(bool $descending = TRUE)` — `uasort` by annotation `priority` (missing = 0), highest first by default.
- Annotation fields (`@MaintainersFetcher`): `id`, `label`, `description`, `priority` (int, higher = higher precedence).
- Interface contract: `fetchMaintainers(string $module_name): array` returns `Maintainer[]`.

## Shipped plugins
### `info_maintainers` — `InfoMaintainersFetcher` (priority 100)
- Reads `$this->extensionList->getExtensionInfo($module_name)` then `['extra']['extend_help_maintainers']['maintainers'] ?? ['maintainers'] ?? []`.
- For each entry with a non-empty `name`, builds a `Maintainer(name, drupal_org, avatar)`. If no `avatar` but a `drupal_org` username exists, calls `fetchAvatarFromDrupalOrg()`.
- `fetchAvatarFromDrupalOrg($drupalOrg)` — GET `https://www.drupal.org/u/<user>/` (Guzzle, 5s timeout), regex-extracts the `user-picture` `<img src>`; errors are logged and return `null`.
- Deps (via `create()`): `extension.list.module`, `http_client`, `logger.channel.extend_help_maintainers`.

### `drupal_org` — `DrupalOrgMaintainersFetcher` (priority 10)
- Cache-first: key `extend_help_maintainers:drupal_org:<module>` in `cache.default`; on hit returns cached `Maintainer[]`.
- Sanitises the module name (`preg_replace('/[^a-z0-9_]/','',strtolower(...))`), GETs `https://www.drupal.org/project/<module>` (5s timeout), and `parseMaintainersFromHtml()` uses `DOMDocument`/`DOMXPath` to read `//div[@id="block-drupalorg-project-maintainers"]//div[contains(@class,"maintainer")]` — pulling name + `href` (deriving the drupal.org username from `/u/<name>`) + `<img src>` avatar.
- Results cached 24h with tag `project:<module>`; fetch failures are logged and yield `[]`.
- Deps: `http_client`, `cache.default`, `logger.channel.extend_help_maintainers`.

## Pipeline (`MaintainersService::buildMaintainersBlock`)
1. Validate `module_name` against `/^[a-z0-9_]+$/` (returns NULL otherwise).
2. Load `selected_plugins` and `plugin_priorities` from `extend_help_maintainers.settings`.
3. For each definition from `getSortedDefinitions()` that is in `selected_plugins`: instantiate, resolve priority (`custom ?? definition ?? 0`), and collect each returned `Maintainer` as `['maintainer' => $m, 'priority' => $p]`. Exceptions are logged and skipped.
4. `MaintainersMerger::merge($collected)` — dedupes by `Maintainer::getIdentifier()` (lowercased drupal.org username, else name). Equal priority → prefer non-empty field values; higher priority wins as the base and fills gaps from the other. Returns `Maintainer[]`.
5. `array_map(fn($m) => $m->toArray(), ...)` then `MaintainersHelpBuilder::build()`.

## Rendering (`MaintainersHelpBuilder::build`)
- Returns NULL if there are no maintainers (or none with a `name`).
- Placeholder avatar = `base:<module_path>/images/user-placeholder.svg` (absolute URL).
- Each maintainer array → `name`, `drupal_org`, `avatar`, `profile` (`https://www.drupal.org/u/<drupal_org>` when a username is present).
- Render array: `#theme => 'extend_help_maintainers'`, `#title => t('Maintainers')`, `#maintainers`, `#placeholder`, `#weight => 100`, `#attached` library `extend_help_maintainers/extend_help_maintainers.maintainers`.
- Cacheable metadata: max-age 86400, contexts `url.path`, `user.permissions`, `languages:language_interface`, tag `module:<module>`.
- Template `templates/extend-help-maintainers.html.twig` renders each entry as an `<a>`/`<img>` card; all dynamic values pass through Twig `|escape`, avatar/profile fall back to the placeholder / `#`.
