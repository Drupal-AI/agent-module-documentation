<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, events & hooks

## Install / enable

```bash
composer require drupal/eca_breadcrumbs
drush en eca_breadcrumbs -y
```

Pulls in `eca` and `token`. No settings form, no post-install config; the breadcrumb builder
is active immediately. Clear cache after adding/changing ECA models.

## Service: `eca_breadcrumbs.breadcrumb_builder`

`Drupal\eca_breadcrumbs\EcaBreadcrumbBuilder` (implements core
`BreadcrumbBuilderInterface`). Registered in `eca_breadcrumbs.services.yml` with tag
`breadcrumb_builder`, **priority 1005** (runs before most default builders). Constructor args:
`@event_dispatcher`, `@token`.

- `applies(RouteMatchInterface)` — creates a `Breadcrumb` (cache context `route`), wraps it in
  a `BreadcrumbBuildEvent`, dispatches `BreadcrumbBuildEvent::EVENT_NAME`, stores the event,
  and returns `$event->hasCustomItems()`. So the builder only claims the route if an ECA
  action added items.
- `build(RouteMatchInterface)` — returns `NULL` if no custom items (letting other builders
  run). Otherwise iterates `getCustomItems()`: skips empty titles; `url === NULL` →
  `Link::createFromRoute($title, '<nolink>')` (non-linked current page); else resolves the URL
  by prefix — `http://`/`https://` → `Url::fromUri()`, leading `/` → `Url::fromUserInput()`,
  otherwise `Url::fromRoute()` — and adds `Link::fromTextAndUrl()`. A URL that throws is
  skipped (`catch (\Exception)`). Links are added to the breadcrumb and returned.

## Service: `eca_breadcrumbs.token_data_helper`

`Drupal\eca_breadcrumbs\TokenDataHelper`. Constructor arg `@eca.token_services`
(`TokenInterface`). `addRouteParametersToTokenData(RouteMatchInterface)` loops route
parameters: an object with `getEntityTypeId()` is registered via
`tokenService->addTokenData($entityTypeId, $value)` (so a node param becomes the `node` token
namespace); any other non-null value is registered under its parameter name. Called from
`BreadcrumbActionBase::prepareTokenData()` before each action replaces tokens.

## Events (`src/Event/`)

- `BreadcrumbBuildEvent` (`eca_breadcrumbs.build`) — holds the `Breadcrumb`, the
  `RouteMatchInterface`, and a `customItems` array. Methods: `getBreadcrumb()`,
  `getRouteMatch()`, `addItem($title, $url = NULL)`, `setItems(array)`, `getCustomItems()`,
  `hasCustomItems()`. This is the event actions and the condition operate on.
- `BreadcrumbAppliesEvent` (`eca_breadcrumbs.applies`) — holds the route match, an `applies`
  bool, and `activeIdentifiers`. Methods include `setApplies($applies, $identifier = NULL)`,
  `getApplies()`, `hasAppliesValue()`, `getActiveIdentifiers()`, `hasActiveIdentifiers()`.
  Consumed by the `set_applies` action; not dispatched by the core builder in 1.0.0.

## Hooks (`eca_breadcrumbs.module`)

- `hook_help()` — help text on `help.page.eca_breadcrumbs`.
- `hook_token_info()` — defines token type `breadcrumb` with token `route-name`.
- `hook_tokens()` — implements `[breadcrumb:route-name]`, returning
  `\Drupal::routeMatch()->getRouteName()`.
