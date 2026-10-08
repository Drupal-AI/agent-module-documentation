<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The example endpoints (reference walkthrough)

Reference code showing the parent API Toolkit building blocks in action. Enable with
`drush en api_toolkit_examples`; a ready-made request collection ships at `http/examples.http`.

## Request class — `Request\CreateOrUpdateExamplePageRequest`

Extends `ApiRequestBase`; three properties with attribute constraints:

- `?string $title = NULL` — `#[Assert\NotBlank(groups: ['create'])]`, `#[Assert\Length(max: 255)]`.
  Optional by default, required only in the `create` group.
- `?string $link = NULL` — `#[Assert\Length(min: 0, max: 2048)]`, `#[Assert\Url]`.
- `array $similarPages = []` — `#[Assert\All([ new EntityExists(entityTypeId: 'node', bundle: 'example_page', fieldName: 'nid') ])]`
  (every element must be an existing example_page node id).

## Controller — `Controller\ExamplePageApiController`

Injects `entity_type.manager`, `pager.manager`, `serializer` (as the normalizer), and
`api_toolkit.validator`.

- **`post(CreateOrUpdateExamplePageRequest $request)`** — manually validates with groups
  `['create', 'Default']`, throws `ApiValidationException::create($violations)` on failure, then
  `ExamplePage::create()`, applies title/link/similarPages via `updateExamplePage()`, saves, and returns
  `JsonResponse::createWithData($this->normalizer->normalize($examplePage, 'api_toolkit_examples'))`.
- **`patch(ExamplePage $examplePage, CreateOrUpdateExamplePageRequest $request)`** — same, with groups
  `['update', 'Default']` (title not required); updates and returns the normalized page.
- **`get(ExamplePage $examplePage)`** — normalizes to format `api_toolkit_examples` collecting
  cacheability into `$context['cacheability']`, returns `CacheableJsonResponse::createWithData()` with the
  cacheability attached.
- **`all()`** — loads all `example_page` nodes, normalizes the array, returns a `CacheableJsonResponse`
  with `node_list:example_page` cache tag.
- **`paged()`** — entity query with `->pager(1)->accessCheck(TRUE)`, loads the page, normalizes, and
  returns `CacheablePagedJsonResponse::createWithPager($data, $pager)` (adds `pagination` + prev/next
  `links`), with the same list cache tag.
- **`delete(ExamplePage $examplePage)`** — deletes and returns 204; **no route registered** for it.

`updateExamplePage()` sets title, similar pages (`setSimilarPages`) and link (`setLink`) only when the
corresponding request property is truthy.

## Normalizers (custom serialization formats)

- `ExamplePageNormalizer` (format `api_toolkit_examples`) → `{id, title, created, author, link, similarPages}`,
  delegating author/similarPages to the `api_toolkit_examples_simple` format and link to the same format.
- `ExamplePageSimpleNormalizer` (format `api_toolkit_examples_simple`) → `{id, title}`.
- `UserSimpleNormalizer` (format `api_toolkit_examples_simple`, targets `UserInterface`) → `{id, displayName}`.
- `LinkItemNormalizer` (format `api_toolkit_examples`, targets `LinkItemInterface`) → `{url, title}`
  (generates the URL with `getUrl()->toString(TRUE)` and adds it as a cacheable dependency).

All four collect cacheability into `$context['cacheability']`, which the controllers fold into the
response's cacheable metadata — the pattern the parent module expects.

## Bundle class — `Entity\ExamplePage extends Node`

Typed helpers: `getSimilarPages()`/`setSimilarPages()` over `field_example_page_similar`,
`getLink()`/`setLink($uri, $title)` over `field_example_page_link`. Registered by
`api_toolkit_examples_entity_bundle_info_alter()`.

## Example calls

```
GET  /api/example-pages/all            -> {"data":[ {id,title,created,author,link,similarPages}, … ]}
GET  /api/example-pages/paged?page=1   -> {"pagination":{…},"data":[…],"links":{"prev":…}}
GET  /api/example-pages/{nid}          -> {"data":{…}}
POST /api/example-pages  {"title":"x"} -> {"data":{…}}   ("" title -> {"errors":[{path,message}]})
PATCH /api/example-pages/{nid} {"link":"https://…"}
```

Note: these routes are `_access: 'TRUE'` demonstration routes — a real endpoint must add its own access
control and entity `access()` checks.
