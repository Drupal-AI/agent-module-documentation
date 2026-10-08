<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Example/test submodule for Decoupled Pages that ships two working decoupled-page routes and a custom dynamic data provider demonstrating the module's full API.

---

`decoupled_pages_test` lives under `decoupled_pages/examples/` and depends on `decoupled_pages`. Enabling it exposes two demo routes: `red_example` at `/decoupled_pages/examples/red` (main library `example_main`, extra asset `red_text`, a static `data-foo="bar"` attribute, and the `decoupled_pages_test.data_provider` dynamic provider) and `blue_example` at `/decoupled_pages/examples/blue` (extra asset `blue_text` and an `_decoupled_page_paths` alternate URL at `/decoupled_pages/examples/blue/alternate`). Its `DataProvider` service reads the `dynamic_value` query parameter into a `data-dynamic` attribute with a `url.query_args:dynamic_value` cache context. It is a reference implementation and test fixture — both routes use `_access: 'TRUE'`, so enable it only in development.

---

- Study a complete, working `_decoupled_page_main` route definition.
- See how `_decoupled_page_assets` attaches an extra CSS library (`red_text` / `blue_text`).
- See how a static `_decoupled_page_data` attribute (`foo: bar`) reaches the root element as `data-foo`.
- See how `_decoupled_page_paths` clones a route to an alternate URL serving the same shell.
- See a real `DataProviderInterface` implementation tagged `decoupled_pages_data_provider`.
- Learn to derive a `data-*` attribute from a request query parameter with correct cacheability.
- Verify a Decoupled Pages install by visiting `/decoupled_pages/examples/red` or `/blue`.
- Read `data-dynamic` in JS after visiting `/decoupled_pages/examples/red?dynamic_value=hello`.
- Copy the routing YAML as a starting template for your own decoupled routes.
- Copy the `DataProvider` class as a template for your own dynamic providers.
- Provide the fixture used by the module's Nightwatch browser test.
- Confirm the module's route rewrite, asset attachment, and data-attribute injection end to end.
- Demonstrate multiple asset libraries loading on one page.
- Inspect the rendered `<div id="decoupled-page-root">` markup produced by the module.
- Use as a teaching example when onboarding developers to progressive decoupling.
