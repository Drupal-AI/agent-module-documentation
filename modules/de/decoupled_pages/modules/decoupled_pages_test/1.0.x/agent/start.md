<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Pages Test Module (decoupled_pages_test) — agent index

Example/test submodule of **decoupled_pages** (ships in `decoupled_pages/examples/`). Package
**Testing**. Depends on **decoupled_pages**. Core `^8 || ^9 || ^10 || ^11`. GPL-2.0-or-later. No
permissions, no config, no Drush. Enable in development only — its routes are open (`_access: 'TRUE'`).

- **The two demo routes, the libraries, and the dynamic data provider** →
  [examples/routes-and-provider.md](examples/routes-and-provider.md)

## What it provides (from source)

- **Routes** (`decoupled_pages_test.routing.yml`):
  - `decoupled_pages_test.red_example` — `/decoupled_pages/examples/red`; `_decoupled_page_main:
    decoupled_pages_test/example_main`; static `_decoupled_page_data: { foo: bar }`;
    `_decoupled_page_data_provider: decoupled_pages_test.data_provider`; option
    `_decoupled_page_assets: [decoupled_pages_test/red_text]`.
  - `decoupled_pages_test.blue_example` — `/decoupled_pages/examples/blue`;
    `_decoupled_page_assets: [decoupled_pages_test/blue_text]`; `_decoupled_page_paths: { alternate:
    /decoupled_pages/examples/blue/alternate }` (cloned into `decoupled_pages_test.blue_example.alternate`).
  - Both use `requirements: { _access: 'TRUE' }` — everyone, incl. anonymous. Demo only.
- **Libraries** (`decoupled_pages_test.libraries.yml`): `example_main` (`dist/main.js` + `dist/main.css`),
  `red_text` (`dist/red_text.css`), `blue_text` (`dist/blue_text.css`).
- **Service** (`decoupled_pages_test.services.yml`): `decoupled_pages_test.data_provider` →
  `Drupal\decoupled_pages_test\DataProvider`, tagged `decoupled_pages_data_provider`.
- **`src/DataProvider.php`** implements `DataProviderInterface::getData()`: returns
  `['dynamic' => <dynamic_value query param>]` when the `dynamic_value` query parameter is present, else
  `[]`, via `Dataset::cacheVariable()` with cache context `url.query_args:dynamic_value`.
- Tests: `tests/src/Nightwatch/Tests/decoupled-page-test.js`, `tests/src/NightwatchTestSetupFile.php`.
