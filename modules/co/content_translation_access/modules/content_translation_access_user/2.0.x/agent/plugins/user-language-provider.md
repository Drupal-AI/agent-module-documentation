<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UserLanguageProvider plugin

`content_translation_access`'s `LanguageProvider` plugin type implementation shipped by this submodule.
It answers "which languages is the current user assigned to?" from a per-user field.

- File: `src/Plugin/ContentTranslationAccess/LanguageProvider/UserLanguageProvider.php`
  (`final class UserLanguageProvider implements LanguageProviderInterface, ContainerFactoryPluginInterface`).
- Annotation: `@LanguageProvider(id = "user_language_provider", label = "User language provider")`.
- `create()` loads the current user (`User::load(current_user->id())`) and injects it.
- `getLanguages()` returns the `Language` entities referenced by the current user's
  `field_access_languages` field (skipping empty references); caches on the instance; returns `[]` when the
  field is absent. This list is merged (union, de-duplicated) with any other providers by
  `LanguageProviderManager` and then checked by the parent module's
  `AccessControlHandler::hasAssignedLanguage()`.

## The field it reads

- `field_access_languages` — entity_reference to `configurable_language`, cardinality `-1` (unlimited),
  label "Languages", description "Languages of content the user is allowed to add or edit". Storage +
  instance config in the submodule's `config/optional/`. Added to the user form on install
  (`hook_install`), removed on uninstall (`hook_uninstall`).

Parent plugin type: [../../../../2.0.x/agent/plugins/language-provider.md](../../../../2.0.x/agent/plugins/language-provider.md).
