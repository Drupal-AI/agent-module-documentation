<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access enforcement

How `content_translation_access` decides who may translate. Install/enable: `drush en content_translation_access`
(requires core `content_translation`). No config screens — behaviour is driven by permissions
([permissions/permissions.md](../permissions/permissions.md)) and the assigned-language set from
LanguageProvider plugins ([plugins/language-provider.md](../plugins/language-provider.md)).

## The service

`content_translation_access.access_control_handler` → `AccessControlHandler` (`src/AccessControlHandler.php`,
interface `AccessControlHandlerInterface`), constructed with `@language_manager`,
`@plugin.manager.content_translation_access_language_provider`, `@content_translation.manager`. Three methods:

- `access(EntityInterface $entity, $operation, AccountInterface $account, ?Language $language = NULL)` —
  returns `AccessResult::neutral()` when `$operation == 'view'`, when the type/bundle is not
  content-translation-enabled (`ContentTranslationManager::isEnabled`), or otherwise when the checks fail.
  Returns `AccessResult::allowed()` **only if** `hasAssignedLanguage($language)` **and**
  `Permissions::hasPermission($operation, $type, $bundle, $account)`. `$language` defaults to
  `$entity->language()` when not passed.
- `createAccess($type, $bundle, Language $language, $account, ?$source_entity = NULL)` — allowed only if
  the type/bundle is enabled, the language is assigned, and the user has the `create`
  (no source) or `update` (has source) permission; else neutral.
- `createAnyAccess($type, $bundle, $account)` — allowed if `createAccess` passes for *any* site language;
  else neutral.

`hasAssignedLanguage(Language $language)` compares the target language id against every language returned
by the LanguageProvider manager (`getLanguages()`); missing/non-array → FALSE (fail-closed).

## Hook wiring (`content_translation_access.module`)

- `hook_entity_access` and `hook_entity_translation_access` → `AccessControlHandler::access()`.
- `hook_entity_create_access` → `createAnyAccess()` when `langcode == 'x-default'`, else `createAccess()`
  for the resolved language.
- `hook_entity_translation_create_access` → `createAccess()` with the source entity (so it is treated as an
  `update`-permission check); non-language context → `AccessResultNeutral::neutral()`.
- `hook_node_access` (`content_translation_access_node_access`) → neutral for any operation other than
  `update`; for `update` it detects the translation-add route
  (`entity.node.content_translation_add`, including via the AJAX referrer) and, when matched, calls
  `access()` with the current content language, else `access()` with the entity's own language.
  `hook_module_implements_alter` moves this implementation to run **last** so it can override
  core `node_node_access`.
- `hook_entity_type_alter` swaps the node `translation` handler to `ContentTranslationAccessHandler`.
- `hook_form_language_content_settings_form_alter` adds the per-bundle "Hide non translatable fields on
  translation forms (with permission)" checkbox (only for users with `administer content translation`).

## Access idiom (why it is safe)

Every path returns only `allowed()` or `neutral()` — never a spurious `forbidden()` and never a default
`allowed()`. Because Drupal combines access hooks with "forbidden wins, else allowed wins, else neutral",
this module can only **add** translate/update grants (its purpose) on top of core, gated by both an assigned
language and a dedicated permission; it never weakens core view access (view → neutral) and cannot fail
open (unknown language / unsupported bundle / missing permission all fall through to neutral). It honours
`bypass node access` and `cta translate any entity` via `Permissions::hasPermission()`.

## Supporting classes

- `ContentTranslationAccessHandler` (`src/ContentTranslationAccessHandler.php`) extends core
  `NodeTranslationHandler`; its `hideNonTranslatableFieldsWithPermission()` process callback sets
  `#access = FALSE` on untranslatable field widgets when the bundle hides them and the user lacks
  `show entity non translatable fields`.
- `AllowedLanguagesController::overview()` (`src/Controller/...`) extends core
  `ContentTranslationController`; it re-filters the translation-overview operation links per language
  and per `cta` permission (display layer only — the hooks above are the real gate). Wired by
  `AllowedLanguagesRouteSubscriber` (event `RoutingEvents::ALTER`, priority `-230`) which repoints each
  `entity.<type>.content_translation_overview` route's `_controller` to it.
- `CTALanguageSelectWidget` (`id cta_language_select`, `field_types = {language}`) extends core
  `LanguageSelectWidget`; `formElement()` lists only languages whose create/update access resolves to
  allowed.
- `CreateInLanguage` composite validation constraint + `CreateInLanguageConstraintValidator`: on a new
  entity, if `createAccess` (owner, or user 1 as fallback) is not allowed, adds the `invalidLanguage`
  violation "Not allowed to create this entity in this language".
