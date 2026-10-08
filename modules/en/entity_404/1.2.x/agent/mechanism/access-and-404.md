<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Entity 404 turns an entity page into a 404

Goal: make a content entity's own **canonical** page respond **404 (not found)** when the
entity fails an enabled check. It never renders another entity as the 404 body — it converts
a 403 into a `NotFoundHttpException`. The mechanism is additive to core access control, so it
only ever *withholds* a page; it cannot grant access.

## 1. Attach the check to canonical routes

`src/EventSubscriber/EntityAccessSubscriber.php` (service
`entity_404.event_subscriber.entity_access`) subscribes to `RoutingEvents::ALTER` via
`onRouteAlter()`. It walks `EntityTypeManager::getDefinitions()`, keeps only definitions whose
class is a subclass of `ContentEntityInterface`, and for each looks up the
`entity.<type>.canonical` route. If that route exists **and** its `_entity_form` default is
`NULL` (skips form-as-canonical routes, e.g. some media), it adds the requirement
`_entity_404: 'TRUE'`.

## 2. The access checks answering `_entity_404`

Both are tagged `access_check` with `applies_to: _entity_404` in
`entity_404.services.yml` and extend `src/Access/Entity404Base.php`.

`Entity404Base::access(RouteMatchInterface)`:
- returns `allowed()` (cache max-age 0) if the check is toggled off (see PathValidator below);
- takes the first route parameter as the entity; if it is not a `ContentEntityInterface`,
  returns `allowed()`;
- if the check is disabled in config (`$this->enabled`, read from `entity_404.settings` in the
  constructor via a `$settings_key`), returns `allowed()` + cache tag `config:entity_404.settings`;
- otherwise runs the subclass `checkAccess($entity)`. An `AccessResultAllowed` is returned as-is;
  a forbidden result has its reason **prefixed** with `Entity 404: ` (constant
  `ACCESS_RESULT_REASON_PREFIX`) and gets the settings cache tag.

`src/Access/HasFullView.php` (`$settings_key = 'no_full_view'`): uses
`EntityDisplayRepositoryInterface::getViewModeOptionsByBundle()`; allows if a `full` view mode
exists for the type/bundle, else `forbidden('No full view')`. Adds cache tag
`config:core.entity_view_display.<type>.<bundle>.full`.

`src/Access/HasTranslation.php` (`$settings_key = 'no_translation'`): allows when the
`content_translation` `ContentLanguageSettings` class is absent, when the entity language is
`und`/`zxx` (`LANGCODE_NOT_SPECIFIED` / `NOT_APPLICABLE`), or when content translation is not
enabled for the bundle. Otherwise loops candidate langcodes and allows if
`$entity->hasTranslation($langcode)`; else `forbidden('Translation does not exist')`. Uses
`setCacheMaxAge(0)` on the translated branches because it reads the current content language and
a `debug_backtrace()` walk. `getCandidateLangcodes()` recovers the language from a `Url` option
found in the backtrace (falls back to the current content language), then adds
`LanguageManager::getFallbackCandidates()` for operation `entity_404_has_translation`; results
are cached per langcode in `$candidateLangcodes`.

## 3. Convert 403 → 404

Because the reason string carries the `Entity 404: ` prefix, the resulting
`AccessDeniedHttpException` message starts with it. `EntityAccessSubscriber::on403()`
(`HttpExceptionSubscriberBase`, priority `100`) checks
`str_starts_with($exception->getMessage(), Entity404Base::ACCESS_RESULT_REASON_PREFIX)` and, if
so, replaces the throwable with `new NotFoundHttpException($message, $exception)`. Drupal then
serves the site's normal 404. `getHandledFormats()` returns `[]` (all formats).

## 4. Supporting services / hooks

- `src/Path/PathValidator.php` (`entity_404.path.validator`) **decorates** core `path.validator`.
  `getUrlIfValid()` and `isValid()` call `toggleOff()` on the injected `HasTranslation` check
  (a shared `ToggleInterface` service, `src/ToggleInterface.php`) around the inner call, restored
  in `finally`, so path/link validation is not blocked by the translation check.
  `getUrlIfValidWithoutAccessCheck()` passes straight through.
- `src/Hook/LanguageHooks.php` implements `hook_language_fallback_candidates_alter`
  (`#[Hook(order: Order::First)]`); during the `entity_404_has_translation` operation on a
  multilingual site it intersects candidates down to the requested langcode plus
  `LANGCODE_NOT_SPECIFIED`. `entity_404.module` also raises this implementation's priority via
  `hook_module_implements_alter`.
- `src/Hook/EntityFormHooks.php` implements `hook_form_alter`: appends the **static** submit
  handler `EntityFormHooks::submitForm` to content-entity forms. After save, if the existing
  redirect is missing/inaccessible and the entity's `canonical` URL is not accessible, it
  redirects to the `edit-form` URL (so the author is not dropped on a 404). Throwables are
  swallowed. (1.2.1 made this callback static.)
