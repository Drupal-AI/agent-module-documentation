# Service, hooks and asset wiring (API)

## Discovery service — `component.discovery`

`Drupal\component\ComponentDiscovery` (implements `ComponentDiscoveryInterface`). Constructor args:
`%app.root%`, `@module_handler`, `@theme_handler`, `@logger.channel.component`. The **only public
method** is `getComponents()`.

```php
$components = \Drupal::service('component.discovery')->getComponents();
// => ['block' => [...], 'library' => [...], 'plugin' => [...]]
// Each entry is keyed by machine name; values are the parsed yml merged over
// ComponentDiscovery::$defaults, plus added keys: machine_name, path (absolute,
// trailing slash), subpath (path relative to app root, leading+trailing slash).
```

`getComponents()` (`ComponentDiscovery.php:126`) scans `components/` folders (see
[component-yml.md](component-yml.md) for discovery rules), parses each file, groups by `type`, then
invokes `hook_component_info_alter()`.

> **Service tag caveat (verified, D11, this site).** The service is tagged
> `plugin_manager_cache_clear` in `component.services.yml`, but `ComponentDiscovery` has no
> `clearCachedDefinitions()` method and does not implement `CachedDiscoveryInterface`. Core's
> `Drupal\Core\Plugin\CachedDiscoveryClearer::clearCachedDefinitions()` (core.inc path
> `CachedDiscoveryClearer.php:55-56`) calls that method on every tagged service, so it fatals:
> `Error: Call to undefined method Drupal\component\ComponentDiscovery::clearCachedDefinitions()`.
> That runtime path is invoked by `ModuleInstaller::install()`/`uninstall()` and
> `ThemeInstaller::install()`. **Net effect: installing/uninstalling any module or theme while
> `component` is enabled fatals mid-operation** (can leave extensions half-installed). `drush cr` and
> the admin cache-clear button rebuild the container and do NOT hit this path. Upstream fix would be
> to implement `CachedDiscoveryInterface` or drop the tag.

## Alter hook — `hook_component_info_alter(array &$components)`

Invoked at the end of `getComponents()` (`ComponentDiscovery.php:155`). Receives the full
type→machine_name→data array; add, remove, or mutate components here.

```php
function mymodule_component_info_alter(array &$components) {
  // e.g. force a cache max-age on every block component.
  foreach ($components['block'] as &$c) {
    $c['cache'] = ['max-age' => 3600];
  }
}
```

## Module hooks implemented (`component.module`)

- `component_theme()` — registers theme hook `component_html` (variables `html_template`,
  `content_attributes`; template `component-html.html.twig`).
- `component_library_info_build()` — builds one Drupal library per component named
  `component/<machine_name>` from the yml `js`/`css`/`dependencies`. External assets (`type: external`)
  keep their absolute path; others are prefixed with the component `subpath`
  (`_component_build_library()`). It then rewrites dependencies for any `plugin` selection stored in
  `component.admin`: `unset($libraries[$key]['dependencies']); $libraries[$key]['dependencies'][] =
  'component/' . $value;` (`component.module:63-68`).
- `component_page_attachments(&$attachments)` — copies the entire `component.admin` config into
  `drupalSettings.component.plugins` on every page (only the plugin-selection map; no secrets).
- `component_help()` — help text on `help.page.component`.

## Block deriver quirk

`ComponentBlockDeriver::getDerivativeDefinitions()` initialises `$this->derivatives` only inside the
`foreach ($components['block'] …)` loop, so when there are **no** `block`-type components it returns
`NULL` and core logs `getDerivativeDefinitions() does not return an array for plugin "component"`.
On this site `component_example` (which supplies the sample block components) is not enabled, so that
warning is present. Details of the block build path: [../plugins/block.md](../plugins/block.md).
