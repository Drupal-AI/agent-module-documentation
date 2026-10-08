<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events: altering a dynamic link's candidate targets

Both events fire from `DynamicLink::getFirstAvailable()` *before* candidate URLs are access-checked, so a subscriber can reorder, add, or remove candidates and change which target the user is sent to. Classes live in `src/Event/`.

## `DynamicLinkRoutesEvent` (`src/Event/DynamicLinkRoutesEvent.php`)
Fired when the link stores targets as routes (`getRoutes()` non-empty).
- `&getRoutes(): array` — returns the routes list by reference; each item is `['name' => string, 'parameters' => array, 'options' => array]`.
- `setRoutes(array $routes): void` — replace the list.

## `DynamicLinkRedirectsEvent` (`src/Event/DynamicLinkRedirectsEvent.php`)
Fired when the link stores targets as raw paths (`getRedirects()` non-empty).
- `&getRedirects(): array` — returns the redirect paths list by reference (strings).
- `setRedirects(array $redirects): void` — replace the list.

## Base class (`src/Event/DynamicLinkEventBase.php`)
Both extend `DynamicLinkEventBase extends Event implements RefinableCacheableDependencyInterface`, giving subscribers:
- `getDynamicLink(): DynamicLinkInterface` — the link being resolved.
- `getAccount(): AccountInterface` — the account access is being checked for.
- Cacheability mutators: `addCacheContexts()`, `addCacheTags()`, `mergeCacheMaxAge()`, `addCacheableDependency()` (and the getters) — refine the metadata that ends up on the access result / response. Add contexts/tags here if your alteration depends on request state so responses vary/invalidate correctly.
- `static buildEventName(?string $link_id = NULL): string` — the event name helper.

## Event names (dispatched twice per resolution)
`DynamicLink::dispatchEvent()` dispatches each event under two names:
1. The base name: the fully-qualified event class name (`buildEventName()` → `Drupal\dynamic_links\Event\DynamicLinkRoutesEvent` or `...RedirectsEvent`). Subscribe here to affect **all** dynamic links.
2. The per-link name: class name + `::<link_id>` (`buildEventName($id)`). Subscribe here to affect **one** specific link.

Subscribe with an `EventSubscriberInterface` returning these strings as event keys, e.g.:
```php
public static function getSubscribedEvents(): array {
  return [
    DynamicLinkRedirectsEvent::class => 'onRedirects',            // all links
    DynamicLinkRedirectsEvent::buildEventName('front') => 'onFront', // only link id "front"
  ];
}
```
There is no `.services.yml` in the module; subscribers are provided by your own module. Note the getters return by reference, but prefer `setRoutes()`/`setRedirects()` for clarity.
