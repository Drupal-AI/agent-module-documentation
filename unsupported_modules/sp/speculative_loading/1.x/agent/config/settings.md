<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, injection & extension

## Install & enable

```bash
composer require drupal/speculative_loading
drush en speculative_loading -y
```

Only dependency is core **`system`**. Works immediately with defaults (`prerender` + `moderate`);
no further setup required.

## Settings form & config object

Route `speculative_loading.settings` →
**`/admin/config/development/performance/speculative-loading`**
(`SpeculativeLoadingSettingsForm`, a `ConfigFormBase`), requirement
`_permission: 'administer site configuration'`. Reachable as a menu link
(`speculative_loading.links.menu.yml`) and a local task
(`speculative_loading.links.task.yml`) under core's *Performance* settings.

Writes config object **`speculative_loading.settings`** (two keys; schema
`config/schema/speculative_loading.schema.yml`, install defaults `config/install/`):

| Key | Type | Options / default | Meaning |
|---|---|---|---|
| `mode` | string | `prefetch`, `prerender` (default `prerender`) | Prefetch = lightweight resource fetch; prerender = full background page render (faster, but risky for interactive content). Radios, required. |
| `eagerness` | string | `conservative`, `moderate` (default), `eager` | Heuristic for when speculation triggers: conservative ≈ on click, moderate ≈ on hover, eager = slightest suggestion. Radios, required. |

Config-export example:

```yaml
# speculative_loading.settings.yml
mode: prerender
eagerness: moderate
```

`hook_uninstall()` (`speculative_loading.install`) deletes this config object.

## How the markup is injected

`speculative_loading_page_attachments()` (`speculative_loading.module`) runs on every page:

1. Calls `\Drupal::service('plugin.manager.speculation_rules')->getSpeculationRules()`.
2. Attaches an inline `<script type="speculationrules">` to `#attached['html_head']`, with
   `#value = json_encode($rules)`.

Result is a single JSON document read by the browser's Speculation Rules API. Chromium browsers act
on it; others ignore it with no side effects.

## Rule assembly — `SpeculationRulesManager::getSpeculationRules()`

Builds `[$mode => [ ... ]]` where the single ruleset has:

- `source: document`
- `where.and`:
  - `href_matches` = `prefixPathPattern('/*')` → all same-site URLs under the base path.
  - `not.href_matches` = the exclusion list from `getHrefExcludePaths($mode)` (below).
  - `not.selector_matches` = `a[rel~="nofollow"]` → never speculate nofollow links.
  - **prerender only**: additionally `not.selector_matches` = `.no-prerender` → any `<a class="no-prerender">` is skipped.
- `eagerness` = the configured value.

### Exclusion list — `getHrefExcludePaths($mode)`

Base excludes (each run through `UrlPatternPrefixer`):

- `/admin/*`, `/user/login*`, `/user/logout*`, `/user/register*` (context `site`)
- `/*` in contexts `files`, `modules`, `themes` (static assets)
- `/*\?(.+)` (context `site`) — any URL carrying a query string

Then `moduleHandler->alter('speculation_rules_href_exclude_paths', $href_exclude_paths, $mode)` is
invoked, and the altered paths are prefixed and merged (deduplicated via `array_unique`).

## URL pattern prefixing — `UrlPatternPrefixer`

Service `speculative_loading.url_pattern_prefixer`
(args: `@config.factory`, `@module_handler`, `@file_url_generator`). `prefixPathPattern($pattern,
$context = 'site')` prepends the base path for one of four contexts built in
`getDefaultContexts()`:

- `site` → `base_path()`
- `files` → public files base URL (`FileUrlGeneratorInterface::generateString('public://')`)
- `modules` → `base_path().'modules'`
- `themes` → `base_path().'themes'`

All context strings are escaped with `escapePatternString()` (`addcslashes($str, '+*?:{}()\\')`);
contexts containing `:?#` are wrapped as a `{...}` URL-pattern group. Honours subdirectory installs.
An unknown context triggers an `E_USER_WARNING` and returns the pattern unchanged.

## Plugin type `speculation_rules`

Managed by `SpeculationRulesManager` (extends `DefaultPluginManager`):

- Discovery dir `Plugin/SpeculationRules`, interface
  `Plugin\SpeculationRulesInterface`, annotation `Annotation\SpeculationRules`
  (`id`, `title`, `description`), cache key `speculation_rules_plugins`.
- Interface methods: `getRules(string $mode): array` and `getExcludePaths(string $mode): array`.
- Shipped plugin `DefaultSpeculationRules` (id `default`): `getRules()` returns `[]` (adds nothing
  beyond the manager); `getExcludePaths()` returns, for **prerender** mode, `/node/add/*`,
  `/node/*/edit`, `/node/*/delete`, `/admin/*`, `/user/*/edit`, and for **all** modes
  `/user/reset/*`, `/confirm/*`. (Note: the manager's `getHrefExcludePaths()` builds its base list
  directly and does not itself iterate plugin `getExcludePaths()` — plugin exclusions are the
  extension point for custom plugins.)

To extend, add a class in `your_module/src/Plugin/SpeculationRules/` with a `@SpeculationRules`
annotation implementing `SpeculationRulesInterface`.

## Alter hook

```php
/**
 * Implements hook_speculation_rules_href_exclude_paths_alter().
 */
function mymodule_speculation_rules_href_exclude_paths_alter(array &$exclude_paths, string $mode) {
  if ($mode === 'prerender') {
    $exclude_paths[] = '/cart/*';
  }
  $exclude_paths[] = '/checkout/*';
}
```

Added patterns are prefixed with the site base path before being emitted. Use it to keep
cart/checkout/one-time-action links out of speculation. Front-end escape hatch: add the
`no-prerender` CSS class to any link to exclude it (prerender mode).
