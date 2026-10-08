<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the redirect fires (mechanism)

## Request subscriber

`ContentTranslationRedirectRequestSubscriber` (service
`content_translation_redirect.request_subscriber`) listens on `KernelEvents::REQUEST`. On each
request `onRequest()` returns early unless **all** of these hold:

1. The site is **multilingual** (`languageManager->isMultilingual()`), otherwise nothing fires.
2. The current route resolves to a **content entity** whose canonical route matches the current
   route (`getEntity()` scans route parameters).
3. The entity type is **supported** (see manager below).
4. The **current content language differs** from the entity's own language.
5. A redirect **matches** the entity (`storage->loadByEntity()`) and has a non-null status code.
6. The redirect's **mode** allows this entity (`translatableEntityOnly()` /
   `untranslatableEntityOnly()` checks against `$entity->isTranslatable()`).

If so, it builds the target URL — the redirect's `path`, or else the same entity in its
**untranslated** language — and, if it differs from the current URL, sets a
`TrustedRedirectResponse($url, $code)` with cache contexts `route` + `languages:content` and
cache tags for the possible redirect ids.

## Storage matching (most specific first)

`ContentTranslationRedirectStorage` (custom storage handler):

- `getPossibleIds($entity)` = `["<type>__<bundle>", "<type>", "default"]`.
- `loadByEntity($entity)` loads those ids and returns the **first** that exists — so a
  bundle-specific redirect beats an entity-type redirect, which beats Default.

## Manager

`content_translation_redirect.manager` (`ContentTranslationRedirectManager`):

- `isEntityTypeSupported()` — content entity, translatable, has `canonical` link template, and
  not in `UNSUPPORTED_TYPES` (`block_content`, `comment`, `contact_message`,
  `menu_link_content`, `shortcut`).
- `getSupportedEntityTypes()` — the filtered list used to populate the add-form.
- `resetCache()` — invalidates render caches for affected entity types when a redirect is saved
  or deleted (called from the entity's `postSave`/`postDelete`).
- Static `getStatusCodes()` (300,301,302,303,304,305,307) and `getTranslationModes()`
  (translatable, untranslatable, all).

## Alter event

Before returning, the subscriber dispatches
`ContentTranslationRedirectEvent` (event name constant
`ContentTranslationRedirectEvents::REDIRECT` = `'content_translation_redirect'`). Subscribe to it
to inspect/alter the `TrustedRedirectResponse`, entity, current language, redirect entity and
target `Url`:

```php
public static function getSubscribedEvents(): array {
  return [ContentTranslationRedirectEvents::REDIRECT => 'onRedirect'];
}
public function onRedirect(ContentTranslationRedirectEvent $event): void {
  $response = $event->getResponse();   // TrustedRedirectResponse
  $entity   = $event->getEntity();
  // $event->getLanguage(), $event->getRedirect(), $event->getUrl()
}
```
