<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The language access check

## Where it is wired

`RouteSubscriber::alterRoutes()` (`src/Routing/RouteSubscriber.php`) runs on route rebuild. For every
entity type where `getRouteNamesToAlter()` returns a route name it calls
`$route->setRequirement('_entity_language_access', 'true')`. A type qualifies when it is a
`ContentEntityTypeInterface`, `hasLinkTemplate('canonical')`, and `isTranslatable()`; the route name is
`'entity.' . $entity_type->id() . '.canonical'`. So the check is attached to the canonical route of each
translatable content entity type only.

The requirement `_entity_language_access` is served by the tagged access check
`entity_language_access.language_access` → class `EntityLanguageAccess`
(`src/Access/EntityLanguageAccess.php`, `applies_to: _entity_language_access` in
`entity_language_access.services.yml`). Its only dependency is `@language_manager`.

## How `EntityLanguageAccess::access()` decides

Signature: `access(AccountInterface $account, Route $route, RouteMatch $route_match)`.

1. **Bypass:** if `$account->hasPermission('bypass entity_language_access')` → `AccessResult::allowed()->cachePerPermissions()`.
2. **Find the target entity:** iterate `$route_match->getParameters()`; take the parameter that is a
   `ContentEntityInterface`, is translatable (`isEntityTranslatable()` = `instanceof TranslatableInterface`
   **and** `->isTranslatable()`), and whose type matches the current route
   (`$route_name === 'entity.' . $parameter->getEntityTypeId() . '.canonical'`). Non-translatable
   parameters are skipped.
3. **No matching entity** → `AccessResult::allowed()->cachePerPermissions()` (the check is neutral/allow
   when it has nothing to guard).
4. **Language comparison:** `$current = languageManager->getCurrentLanguage(LanguageInterface::TYPE_CONTENT)->getId()`
   compared against `$entity->language()->getId()`. Because core's entity-route upcasting loads the
   translation for the negotiated content language when it exists (otherwise the original/fallback
   translation), a mismatch means "no translation in the requested language."
   - **Mismatch** → `AccessResult::forbidden()->cachePerPermissions()->addCacheableDependency($entity)->setReason(self::REASON)`.
   - **Match** → `AccessResult::allowed()->cachePerPermissions()->addCacheableDependency($entity)`.

`self::REASON` is the constant string `'Entity has no translation for current language.'`; it is reused
by the fallback subscriber (see below) to recognise 403s produced by this module.

## Coverage / behaviour notes (from source and the functional test)

- Only the **canonical view** is guarded. Edit/delete/other operations and non-canonical routes keep
  core access.
- **Listings are not filtered** — Views/EntityQuery/collection endpoints do not run this route check, so
  untranslated entities still appear there unless you add a language filter.
- Non-translatable entity types (e.g. an `article` bundle not marked translatable in the test) are always
  accessible in every language.
- Publishing/access still applies first: `tests/src/Functional/EntityLanguageAccessTest.php` shows an
  unpublished node returns 403 in every language via core access, independent of this module.
- The module only recognises canonical routes named `entity.<type>.canonical`.

## Cache metadata

The entity-bound branches add `addCacheableDependency($entity)`, so adding or removing a translation
invalidates the decision via the entity's cache tags. See `config/settings.md` for the fallback
behaviour that consumes the forbidden result.
