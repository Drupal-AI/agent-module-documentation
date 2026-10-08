API Toolkit Examples is the demonstration submodule of API Toolkit, shipping working CRUD endpoints under `/api/example-pages` that show how to use its request classes, standardised responses and normalizers.

---

This is reference code, not a production feature. Enabling it creates an `example_page` node type (with a `field_example_page_link` link field and a `field_example_page_similar` self-referencing node reference), inserts two sample pages, and adds five routes that demonstrate the parent module's building blocks: a POST create and PATCH update driven by a `CreateOrUpdateExamplePageRequest` request class (with `create`/`update` validation groups and the `EntityExists` constraint), a single GET and a list GET returning `CacheableJsonResponse`, and a paged GET returning `CacheablePagedJsonResponse`. Four tagged normalizers convert the node, its author and its link field into clean JSON. Its install hook also appends the `api_toolkit_examples_json` format to `api_toolkit.settings:route_formats` so the parent's standardised error/maintenance JSON applies to these routes. The example routes intentionally use `_access: 'TRUE'` (the module's own comments state access control is out of scope for examples), so do not enable this submodule on a production site.

---

- Study a complete, runnable example of building custom API endpoints with API Toolkit.
- See how a request class (`CreateOrUpdateExamplePageRequest`) declares typed, constraint-annotated properties fed into a controller.
- Learn how to run manual validation with named groups (`$validator->validate($request, NULL, ['create', 'Default'])`).
- See the `EntityExists` constraint used with `#[Assert\All]` to validate an array of referenced node IDs.
- Inspect how `CacheableJsonResponse::createWithData()` is used for single-item and list responses.
- Inspect how `CacheablePagedJsonResponse::createWithPager()` builds a paged response with `pagination`/`links`.
- Follow how cacheability metadata is collected via `$context['cacheability']` and attached to the response.
- See how tagged normalizers (`ExamplePageNormalizer`, `ExamplePageSimpleNormalizer`, `LinkItemNormalizer`, `UserSimpleNormalizer`) target custom formats.
- Learn how a normalizer delegates to `$this->serializer->normalize()` for nested author/link/similar-page data.
- See a bundle class (`ExamplePage extends Node`) registered via `hook_entity_bundle_info_alter()` with typed getters/setters.
- Test `GET /api/example-pages/all` to retrieve all example pages under a `data` key.
- Test `GET /api/example-pages/paged?page=N` to retrieve a paged list with prev/next links.
- Test `GET /api/example-pages/{examplePage}` for a single page (node param converter + bundle filter).
- Test `POST /api/example-pages` to create a page (validates `title` required via the `create` group).
- Test `PATCH /api/example-pages/{examplePage}` to update title/link/similar pages.
- Trigger a validation error (empty title on create) to see the standardised `{"errors":[...]}` JSON response.
- Use the shipped `http/examples.http` request collection as a ready-made client for all endpoints.
- Copy the request/controller/normalizer patterns into your own module as a starting scaffold.
- Uninstall cleanly: the uninstall hook deletes the example nodes, the node type, and removes the format from `route_formats`.
