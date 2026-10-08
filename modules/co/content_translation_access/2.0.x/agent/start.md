<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content translation access (content_translation_access) — agent index

Adds **per-entity-type + per-bundle + per-operation translation permissions**, gated by the set of
**languages assigned to the current user**, to Drupal core Content Translation. Replaces core's coarse
`translate any entity` with granular `cta …` permissions. Grant-only, fail-closed access idiom.

- Depends on core **`content_translation`**. Core `^10.5 || ^11.0`. GPL-2.0-or-later. Version 2.0.0.
- Ships submodule **`content_translation_access_user`** (per-user `field_access_languages` provider) —
  see [../modules/content_translation_access_user/2.0.x/agent/start.md](../../modules/content_translation_access_user/2.0.x/agent/start.md).
- No routing.yml, no config forms, no config schema, no Drush. Configured entirely at
  *People → Permissions* plus the user submodule's field.

## What it provides

- **Access enforcement** (hooks + `AccessControlHandler`, `service content_translation_access.access_control_handler`)
  → [access/access-control.md](access/access-control.md)
- **Dynamic permissions** (`Permissions::ctaPermissions`, `Permissions::hasPermission`)
  → [permissions/permissions.md](permissions/permissions.md)
- **`LanguageProvider` plugin type** (the "assigned languages" source; manager
  `plugin.manager.content_translation_access_language_provider`) → [plugins/language-provider.md](plugins/language-provider.md)

## Key facts (from source)

- Enforced from `content_translation_access.module`: `hook_entity_access`, `hook_entity_create_access`,
  `hook_entity_translation_create_access`, `hook_entity_translation_access`, and `hook_node_access`
  (reordered last via `hook_module_implements_alter` so it can override `node_node_access`).
- `AccessControlHandler` (`src/AccessControlHandler.php`) returns `AccessResult::allowed()` only when
  `hasAssignedLanguage($language)` **and** `Permissions::hasPermission(...)` both hold; otherwise
  `AccessResult::neutral()`. `view` → always neutral. Unsupported entity type/bundle → neutral.
- `Permissions::hasPermission()` short-circuits to TRUE for `bypass node access` or `cta translate any entity`;
  maps operation update→`translate`, create→`create translation`, delete→`delete translation`.
- Extra pieces: `ContentTranslationAccessHandler` (node translation handler that can hide non-translatable
  fields), `AllowedLanguagesController` + `AllowedLanguagesRouteSubscriber` (overview link filtering),
  `CTALanguageSelectWidget` (`id cta_language_select`), `CreateInLanguage` validation constraint.
