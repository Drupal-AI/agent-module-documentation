<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Toolkit Examples (api_toolkit_examples) — agent index

The **demonstration submodule** of API Toolkit — runnable reference code, **not for production**.
Package `Example`. Depends on `api_toolkit`, and core `link`, `node`, `user`. Core `^9 || ^10 || ^11`,
PHP 7.4. Part of the `api_toolkit` project (version 1.5.1). Parent index:
[../../../../agent/start.md](../../../../agent/start.md).

- **The five endpoints, request class, normalizers and how they use the parent** →
  [api/example-endpoints.md](api/example-endpoints.md)

## What it installs (from source)

- A **content type `example_page`** plus two fields (`config/install/`): `field_example_page_link`
  (core `link`) and `field_example_page_similar` (entity reference to `node:example_page`).
- Two **sample nodes** on install (`hook_install`), and it appends `api_toolkit_examples_json` to
  `api_toolkit.settings:route_formats` (removed on uninstall, which also deletes the nodes + node type).
- A **bundle class** `Entity\ExamplePage extends Node` (typed getters/setters for link + similar pages),
  wired via `api_toolkit_examples_entity_bundle_info_alter()`.
- Four **normalizers** (all tagged `normalizer`, priority 100): `ExamplePageNormalizer`
  (format `api_toolkit_examples`), `ExamplePageSimpleNormalizer` + `UserSimpleNormalizer` (format
  `api_toolkit_examples_simple`), `LinkItemNormalizer` (format `api_toolkit_examples`).
- One **request class** `Request\CreateOrUpdateExamplePageRequest` (`title`, `link`, `similarPages`;
  `create`/`update` groups; `EntityExists` on each similar-page id).
- One **controller** `Controller\ExamplePageApiController` (`get`/`all`/`paged`/`post`/`patch`;
  a `delete()` method exists but has no route).

## Routes (`api_toolkit_examples.routing.yml`)

All require `_format: 'api_toolkit_examples_json'`. These are **demonstration routes**: the module
deliberately sets `_access: 'TRUE'` on every one (its own inline comment: "Access control is not
necessary since this is an example route"). Treat them as a teaching example — do not model production
endpoints on the open access, and do not enable this submodule on a live site.

| Route | Method | Path | Controller |
|-------|--------|------|------------|
| create_example_page | POST | `/api/example-pages` | `::post` |
| update_example_page | PATCH | `/api/example-pages/{examplePage}` | `::patch` |
| get_example_page | GET | `/api/example-pages/{examplePage}` | `::get` |
| get_example_pages | GET | `/api/example-pages/all` | `::all` |
| get_paged_example_pages | GET | `/api/example-pages/paged` | `::paged` |

`{examplePage}` is upcast by the core node param converter with a `bundle: [example_page]` restriction.
