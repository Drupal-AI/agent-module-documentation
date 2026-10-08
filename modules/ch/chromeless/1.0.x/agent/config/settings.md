<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chromeless — operation, parameters & internals

There is **no admin UI, no config object, no schema, no permissions, no route**. You install the
module and use it through two URL query parameters. This page documents the mechanism from source and
the only two things you can customise.

## Install / enable

```
composer require drupal/chromeless   # (already vendored on this site)
drush en chromeless -y
```

Nothing else is required. `chromeless.info.yml` declares `core_version_requirement: '^10.5 || ^11'`
and `php: 8.3`; no module dependencies.

## Using it (query parameters)

Two parameters, both read from the current request query string:

- **`chromeless`** — enable/disable chromeless mode. `?chromeless=1` (or any non-zero integer) turns
  it on; `?chromeless=0` turns it off.
- **`title`** — while chromeless is active, whether the page title is rendered. `?title=1` shows it,
  `?title=0` hides it. Ignored unless chromeless is also active.

Values are read in `ChromelessTempstore::getPersistentValue()` and coerced with `!!(int) $value`, so
any non-zero integer is TRUE and everything else (`0`, empty, non-numeric) is FALSE.

### State is sticky per session

`getPersistentValue()` only writes to the temp store **when the parameter is present** on the request;
otherwise it returns the previously stored value:

```php
if ($request?->query?->has($name)) {
  $tempstore->set($name, !!(int) $request->query->get($name));
}
return !!$tempstore->get($name);
```

So supplying `?chromeless=1` once makes subsequent requests in the same session render chromeless
without the parameter, until you pass `?chromeless=0` or the temp store entry expires. Storage is
Drupal's **private temp store** collection `chromeless.state` (`@tempstore.private`), which is
per-user/per-session and defaults to a one-week expiry. On sites hit by many distinct user agents you
may want to shorten that expiry (it is core's private temp store setting, not a module setting).

## What renders in chromeless mode

`PageDisplayVariantSubscriber::onSelectPageDisplayVariant()` subscribes to core
`RenderEvents::SELECT_PAGE_DISPLAY_VARIANT` and, when `ChromelessTempstore::$isActive` is TRUE, sets
the display variant to `chromeless_page`. `ChromelessPageVariant::build()`
(`src/Plugin/DisplayVariant/ChromelessPageVariant.php`) then returns **only**:

- `content.messages` — `#type => status_messages`, `#include_fallback => TRUE`, weight -1000 (keeps
  Drupal's JS Messages API working by always emitting a container).
- `content.page_title` — `#type => page_title`, `#access` set to `$isActiveTitle`, weight -900.
- `content.main_content` — the page's main content render array, weight -800.

No blocks from the block layout are placed. The active theme still renders, so styling is preserved.

## Caching

`chromeless_page_attachments_alter()` (in `chromeless.module`) adds the `chromeless_state` cache
context to **every** page (via `hook_page_attachments_alter`, because altering the selection event's
cacheable metadata has no effect — see the code comment). The context service
`ChromelessStateCacheContext` (id `chromeless_state`):

- `getContext()` returns `Crypt::hashBase64(json_encode(['active' => …, 'active_title' => …]))` — so
  cache entries vary by the resolved on/off state, not the raw URL.
- `getCacheableMetadata()` adds contexts `url.query_args:chromeless`, `url.query_args:title`, and
  `session` (from `ChromelessTempstore::$cacheContexts`), keeping normal and chromeless renders as
  distinct cache variations per session.

## Customising the parameter names

The two parameter names are **container parameters**, not stored config. Defaults in
`chromeless.services.yml`:

```yaml
parameters:
  chromeless.query.active: 'chromeless'
  chromeless.query.title: 'title'
```

Override them in a site-wide `sites/default/services.yml` (or environment services file) and rebuild
the container (`drush cr`). They are injected into `chromeless.tempstore` as the `$active` / `$title`
constructor args. The bundled test module `chromeless_test` demonstrates this: its
`ChromelessTestServiceProvider` replaces both with random machine names at build time.

## Boundaries

- Removing chrome does not change access: the requested route/content still runs its own access checks.
  This module has no permission and grants nothing.
- All state is per visitor (private temp store); one visitor's preference never affects another's.
