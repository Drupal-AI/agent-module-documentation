<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The computed `breadcrumbs` field

## Install & enable

```bash
composer require drupal/computed_breadcrumbs
drush en computed_breadcrumbs -y
```

Only dependency is core **`link`** (`dependencies: - drupal:link` in the info file). Nothing else
to configure — the field appears on every content entity automatically. No submodules, no Drush.

## Where the field comes from

`computed_breadcrumbs_entity_base_field_info(EntityTypeInterface $entity_type)` in
`computed_breadcrumbs.module` runs for each content entity type
(`$entity_type instanceof ContentEntityTypeInterface`) and defines one base field:

- name/label: `breadcrumbs` / *Breadcrumbs*
- type: **`computed_breadcrumbs`** (the field type below)
- `setComputed(TRUE)`, cardinality **UNLIMITED**
- item-list class `Field\ComputedBreadcrumbsItemList`
- `setDisplayConfigurable('view', TRUE)` and shipped **hidden** (`region => hidden`, `weight -5`,
  `label hidden`) — so it exists everywhere but shows nowhere until you place it.

Because it is a base field, it is present on nodes, taxonomy terms, comments, media, users… any
content entity. It is **not** a field you add per bundle; you only choose where to *display* or
*expose* it.

## The field type — `ComputedBreadcrumbsLinkItem`

`Plugin/Field/FieldType/ComputedBreadcrumbsLinkItem` is a one-line subclass of core `link`'s
`LinkItem`:

- `id = "computed_breadcrumbs"`, label *Breadcrumbs*
- `default_widget = "link_default"`, `default_formatter = "link"`
- inherits the Link constraints (`LinkType`, `LinkAccess`, `LinkExternalProtocols`,
  `LinkNotExistingInternal`)

So each item is an ordinary link value with `uri` + `title`, serialised and rendered exactly like a
core Link field. This is the reason for the `link` module dependency.

## How a value is computed (read time)

`Field\ComputedBreadcrumbsItemList::computeValue()` — the trail is built lazily the first time the
field is read:

1. Gets the entity; **returns nothing** if it `isNew()` or has no `canonical` link template (so
   unsaved entities and non-routable ones yield an empty trail).
2. Takes `$entity->toUrl()` and builds an internal **`Request::create($url->getInternalPath(), …)`**
   copying the current request's query, cookies, files, server and session.
3. Sets a request attribute `computed_breadcrumbs = TRUE` and dispatches it through
   `http_kernel->handle($request, HttpKernelInterface::SUB_REQUEST)`.
4. `EventListener::onKernelRequest()` sees that attribute and overrides the request's `_controller`
   with `Controller\BreadcrumbsExtractor::extract`.
5. `BreadcrumbsExtractor::extract()` calls `breadcrumb` (the breadcrumb manager)
   `->build($routeMatch)->getLinks()` for the entity's route and stuffs the `Link[]` into a
   `Routing\BreadcrumbsResponse` (a bare `Symfony Response` subclass with
   `setBreadcrumbs()`/`getBreadcrumbs()`).
6. Back in `computeValue()`, the request stack is popped back to the real request (a documented
   work-around for core issue node/2613044), the `menu.active_trail` is cleared, and each link is
   turned into an item **inside a `RenderContext`**:
   - `uri = $link->getUrl()->setAbsolute($absolute)->toString()` — `$absolute` is TRUE unless
     `computed_breadcrumbs.settings:use_relative_urls` is set; empty URIs fall back to
     `internal:#`.
   - `title = $link->getText()`; if the text is a render array it is `renderer->render()`-ed to a
     string.
   - stored as a link item `['uri' => …, 'title' => …]` via `createItem()`.

The upshot: the trail is exactly what Drupal's breadcrumb builders produce for that entity's
canonical route, evaluated **as the current user / current request context**, returned as link
data.

## Reading it

```php
// Array of ['uri' => …, 'title' => …]
$trail = $entity->get('breadcrumbs')->getValue();

// Or iterate as link items
foreach ($entity->get('breadcrumbs') as $item) {
  $uri   = $item->uri;    // e.g. 'https://example.com/section'
  $title = $item->title;  // e.g. 'Section'
}
```

Over **JSON:API/REST** the field appears as a normal link-field relationship/attribute on the
resource. In **Views** add the *Breadcrumbs* field and format it with the Link formatter.

## Operating notes

- **Per-read cost.** Every read is a full internal sub-request through the kernel. A collection of
  N entities builds N trails — size API collections accordingly and cache responses where you can.
- **Which trail.** Breadcrumbs are context-dependent in core; this field always builds the trail
  for the **canonical route**. An entity reachable by several paths still gets that one trail.
- **Hidden by default.** The field ships hidden on the view display; place it on *Manage display*
  or expose it explicitly (JSON:API includes base fields unless excluded).
- **Absolute vs relative URLs.** Controlled by the single setting — see
  [../config/settings.md](../config/settings.md).
- **Coverage.** Kernel tests in `tests/src/Kernel/ComputedBreadcrumbsKernelTest.php` assert the
  field on nodes and (nested) taxonomy terms and the absolute/relative URL behaviour.
