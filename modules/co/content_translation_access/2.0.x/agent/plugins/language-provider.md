<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LanguageProvider plugin type

The module defines a plugin type whose job is to answer "which languages is the current user assigned to?".
The union of all providers' languages is the "assigned languages" set that
`AccessControlHandler::hasAssignedLanguage()` checks against.

## Definition

- Manager service: `plugin.manager.content_translation_access_language_provider` →
  `LanguageProviderManager` (`src/LanguageProviderManager.php`), a `DefaultPluginManager` that also
  implements `LanguageProviderInterface`. Discovery subdir `Plugin/ContentTranslationAccess/LanguageProvider`;
  interface `Drupal\content_translation_access\Plugin\LanguageProviderInterface`; annotation
  `Drupal\content_translation_access\Annotation\LanguageProvider`. Alter hook
  `content_translation_access_info`; cache tag/key `content_translation_access`.
- Annotation `@LanguageProvider` (`src/Annotation/LanguageProvider.php`): properties `id`, `label`.
- Interface `LanguageProviderInterface` — one method `getLanguages()` returning an array of
  `\Drupal\Core\Language\Language` (or a single Language / null; non-arrays are coerced to `[]`).

## Aggregation

`LanguageProviderManager::getLanguages()` instantiates every discovered plugin, merges their
`getLanguages()` results, de-duplicates by language id, caches the result on the instance, and returns it.
This aggregated manager is what is injected into `AccessControlHandler` as the "language provider", so
adding a provider plugin widens (never narrows) the assigned-language set.

## Providing your own

Create `src/Plugin/ContentTranslationAccess/LanguageProvider/MyProvider.php` in your module implementing
`LanguageProviderInterface` (optionally `ContainerFactoryPluginInterface` for DI) with the
`@LanguageProvider(id = "...", label = "...")` annotation, returning the `Language` objects the current
user should be allowed to translate into.

## Bundled provider

The `content_translation_access_user` submodule ships `UserLanguageProvider`
(`id user_language_provider`) which reads the current user's `field_access_languages` entity-reference
field. See
[../../../modules/content_translation_access_user/2.0.x/agent/plugins/user-language-provider.md](../../../modules/content_translation_access_user/2.0.x/agent/plugins/user-language-provider.md).
