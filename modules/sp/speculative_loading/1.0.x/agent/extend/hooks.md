<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending the exclude rules

## Alter hook (the working extension point)

`hook_speculation_rules_href_exclude_paths_alter(array &$exclude_paths, string $mode)`
— add or remove path patterns that browsers must not prefetch/prerender. Called from
`SpeculationRulesManager::getHrefExcludePaths()` before the list is normalized; each
added path is base-path–prefixed for you, so pass site-root-relative patterns
(e.g. `/cart/*`). `$mode` is `'prefetch'` or `'prerender'`, so exclusions can differ
per mode.

```php
function mymodule_speculation_rules_href_exclude_paths_alter(array &$exclude_paths, string $mode) {
  if ($mode === 'prerender') {
    $exclude_paths[] = '/cart/*';       // don't prerender the cart
  }
  $exclude_paths[] = '/checkout/*';     // exclude from both modes
}
```

## Markup opt-outs (no code needed)

- Add `rel="nofollow"` to any `<a>` — excluded in both modes (`a[rel~="nofollow"]`).
- Add the CSS class `no-prerender` to an `<a>` — excluded in **prerender** mode only.

## SpeculationRules plugin type — defined but inert

The module ships an annotation-based plugin type: annotation
`Drupal\speculative_loading\Annotation\SpeculationRules`, interface
`SpeculationRulesInterface` (`getRules($mode)`, `getExcludePaths($mode)`), manager
service `plugin.manager.speculation_rules`, and one plugin `default`
(`DefaultSpeculationRules`). **The manager does not call any plugin's `getRules()` or
`getExcludePaths()`** — `getSpeculationRules()` builds the rule JSON directly and only
invokes the alter hook. So implementing a `SpeculationRules` plugin has no effect on
output today; use the alter hook instead. (`DefaultSpeculationRules::getExcludePaths`
lists extra prerender exclusions such as `/node/*/edit`, `/node/*/delete`, `/user/*/edit`,
`/user/reset/*`, `/confirm/*`, but that method is never called.)
