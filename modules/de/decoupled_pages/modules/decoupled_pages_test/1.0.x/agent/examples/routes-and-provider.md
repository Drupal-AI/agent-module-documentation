<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Demo routes, libraries, and the dynamic data provider

Source: `decoupled_pages_test.routing.yml`, `decoupled_pages_test.libraries.yml`,
`decoupled_pages_test.services.yml`, `src/DataProvider.php`.

## Enable

`ddev drush en decoupled_pages_test -y` (pulls in `decoupled_pages`). Development only — both routes are
world-readable. Then visit `/decoupled_pages/examples/red` and `/decoupled_pages/examples/blue`.

## `red_example` — all features on one route

```yaml
decoupled_pages_test.red_example:
  path: /decoupled_pages/examples/red
  defaults:
    _decoupled_page_main: decoupled_pages_test/example_main
    _decoupled_page_data: { foo: 'bar' }
    _decoupled_page_data_provider: decoupled_pages_test.data_provider
  requirements: { _access: 'TRUE' }
  options:
    _decoupled_page_assets: [ decoupled_pages_test/red_text ]
```

Renders `<div id="decoupled-page-root" data-foo="bar" ...>` with libraries `example_main` + `red_text`
attached. Because a non-default provider is named, the parent module merges the static `foo` attribute with
the provider's output (provider wins on key clash). Visiting `?dynamic_value=hello` adds `data-dynamic="hello"`.

## `blue_example` — extra assets + an alternate path

```yaml
decoupled_pages_test.blue_example:
  path: /decoupled_pages/examples/blue
  defaults: { _decoupled_page_main: decoupled_pages_test/example_main }
  requirements: { _access: 'TRUE' }
  options:
    _decoupled_page_assets: [ decoupled_pages_test/blue_text ]
    _decoupled_page_paths: { alternate: /decoupled_pages/examples/blue/alternate }
```

The parent module clones this into a second route `decoupled_pages_test.blue_example.alternate` serving the
identical shell at `/decoupled_pages/examples/blue/alternate` (the alternate path must, and does, start with
the parent path). Libraries `example_main` + `blue_text`.

## Libraries

`example_main` = `dist/main.js` + `dist/main.css`; `red_text` = `dist/red_text.css`; `blue_text` =
`dist/blue_text.css` (all `component` CSS). These are prebuilt demo assets under `dist/`.

## The dynamic data provider

`src/DataProvider.php` (`Drupal\decoupled_pages_test\DataProvider implements DataProviderInterface`),
registered as service `decoupled_pages_test.data_provider` tagged `decoupled_pages_data_provider`:

```php
const QUERY_PARAMETER_NAME = 'dynamic_value';
protected static $cacheContexts = ['url.query_args:dynamic_value'];

public function getData(Route $route, Request $request): Dataset {
  $cacheability = new CacheableMetadata();
  $cacheability->addCacheContexts(static::$cacheContexts);
  return Dataset::cacheVariable($cacheability, $request->query->has('dynamic_value')
    ? ['dynamic' => $request->query->get('dynamic_value')]
    : []);
}
```

Canonical pattern for a request-derived `data-*` attribute: read the parameter, return a `Dataset` via
`cacheVariable()` with a **matching cache context** so page cache varies on that query arg. The parent
module escapes the value into the `data-dynamic` HTML attribute; the attribute name is fixed and `[a-z-]`-valid.
See the parent module's `agent/api/data-provider.md`.

## Tests

`tests/src/Nightwatch/Tests/decoupled-page-test.js` (+ `NightwatchTestSetupFile.php`) drive these routes in a
browser to assert the shell, attributes, and libraries render as configured.
