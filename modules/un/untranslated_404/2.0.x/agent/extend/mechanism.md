<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How untranslated_404 works, its exact scope, and how to change it

The module has **no config, no routes, no permissions, no hooks**. It is two services wired to core
plumbing (`untranslated_404.services.yml`). Nothing runs until a bundle has content translation
enabled.

## The three-step mechanism

1. **Route alter — add an access requirement to every content entity's canonical route.**
   `NotFoundIfNoTranslationSubscriber::onRouteAlter()` listens on `RoutingEvents::ALTER`. It walks
   every entity type definition whose class is a subclass of `ContentEntityInterface`, and on the
   route `entity.{entity_type_id}.canonical` sets the requirement
   `_untranslated_404_has_translation: 'TRUE'`. The set is null-safe
   (`->get(...)?->setRequirement(...)`), so entity types with no canonical route are skipped.
   File: `src/EventSubscriber/NotFoundIfNoTranslationSubscriber.php:52`.

2. **Access check — deny (403) when the requested translation is missing.**
   The requirement maps (via `applies_to: _untranslated_404_has_translation` in services.yml) to the
   access check `HasTranslation::access($route_match)`. It takes the **first** route parameter as the
   entity and short-circuits to `AccessResult::allowed()` unless ALL of these hold:
   - the parameter is a `TranslatableInterface`;
   - the entity's own language is a real language (not `und` `LANGCODE_NOT_SPECIFIED` nor `zxx`
     `LANGCODE_NOT_APPLICABLE`);
   - content translation is enabled for that entity type + bundle
     (`ContentLanguageSettings::loadByEntityTypeBundle(...)->getThirdPartySettings('content_translation')['enabled']`).

   When all hold, it compares the **current content language**
   (`languageManager->getCurrentLanguage(LanguageInterface::TYPE_CONTENT)`) against
   `$entity->hasTranslation($langcode)`. Present → `allowed()`; absent →
   `AccessResult::forbidden('Entity has no translation')` (the constant
   `HasTranslation::ACCESS_RESULT_REASON`). Cacheability: `languages:language_content` context plus
   the `ContentLanguageSettings` config as a cacheable dependency.
   File: `src/Access/HasTranslation.php:50`.

3. **Exception rewrite — turn that specific 403 into a 404.**
   `NotFoundIfNoTranslationSubscriber` extends core `HttpExceptionSubscriberBase` and implements
   `on403()`. On any 403, it checks `$exception->getMessage() === HasTranslation::ACCESS_RESULT_REASON`
   and, on match, calls `$event->setThrowable(new NotFoundHttpException(...))` — swapping the
   exception so downstream handlers render the site's normal 404 page. Priority **100**
   (`getPriority()`), `getHandledFormats()` returns `[]` which core treats as **all request formats**
   (HTML, JSON, etc.). File: `src/EventSubscriber/NotFoundIfNoTranslationSubscriber.php:70`.

## Exact scope — what actually 404s

- **Only the `entity.*.canonical` route** of content entity types (e.g. `/node/12`,
  `/taxonomy/term/5`, `/media/9`, `/user/3`). Edit forms, delete forms, views listings, REST/JSON:API
  collections and admin routes are untouched — the requirement is added to the canonical route only.
- **Only bundles with content translation enabled.** A node type without translation enabled always
  passes (step 2 short-circuits). This is the sole lever for scoping the module: enable/disable
  content translation per entity type + bundle at
  `/admin/config/regional/content-language`.
- **Only when a real translation is genuinely missing** in the current *content* language. Entities
  in `und`/`zxx` are always allowed.

## No access bypass — this can only add restriction

The requirement adds an **additional** access check that core ANDs with the canonical route's normal
access (e.g. node `view`). It returns only `allowed()` or `forbidden()` — never overrides a core
`forbidden`, so it cannot grant access a user did not already have. A visitor who lacks view access
still gets a normal 403 (different message, not rewritten). The 403→404 rewrite fires only for the
exact reason string `'Entity has no translation'`.

## Changing the behavior

- **Disable it for a bundle:** turn off content translation for that entity type + bundle; the check
  short-circuits to allowed. **Disable it entirely:** uninstall the module (route requirements go
  away on the next route rebuild).
- **Restrict it to fewer entity types** (e.g. nodes only): there is no config for this. Provide your
  own event subscriber on `RoutingEvents::ALTER` at a later priority that removes the requirement from
  the canonical routes you want to exempt, or decorate/replace
  `untranslated_404.access_check.has_translation` with `class HasTranslationOverride extends HasTranslation`
  (constructor arg `@language_manager`) that returns `AccessResult::allowed()` for the entity types
  you want to skip.
- **Serve a different response than the 404 page** (e.g. a redirect to the language switcher or the
  default-language version): register your own exception subscriber on `KernelEvents::EXCEPTION` at a
  priority **above 100** that matches the same reason string and calls `$event->setResponse(...)`
  before this module's `on403()` runs.

## Version note

2.0.0 (2025-04-09) reimplemented the module: it **removed** the 1.x approach (an exception thrown from
a view hook, plus a `untranslated_404.settings` config and an `administer untranslated 404
configuration` permission) in favor of the route access check + exception subscriber above. Update
hook `untranslated_404_update_10201` deletes the old config and revokes the old permission. There is
no settings form in 2.x.
