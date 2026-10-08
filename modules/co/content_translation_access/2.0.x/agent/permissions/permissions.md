<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `content_translation_access.permissions.yml` and `src/Permissions.php`
(`Permissions implements ContainerInjectionInterface`, service deps `content_translation.manager`,
`entity_type.bundle.info`). Grant at *People → Permissions* (`/admin/people/permissions`). No config UI.

## Static permission

- `show entity non translatable fields` — user sees/edits non-translatable fields on translation forms
  even when the bundle has "Hide non translatable fields on translation forms (with permission)" enabled.
  (Declared statically in the `.permissions.yml`.)

## Dynamic permissions — `Permissions::ctaPermissions()`

Registered via `permission_callbacks` in the `.permissions.yml`. For every content-translation-**enabled**
entity type + bundle (`ContentTranslationManager::getSupportedEntityTypes()` × bundle info, filtered by
`isEnabled`), `buildPermissions()` emits three permissions, plus one global permission added once:

- `cta create translation <type_id> <bundle_id>` — *Create <type> <bundle> (with assigned language)*
- `cta translate <type_id> <bundle_id>` — *Translate <type> <bundle> (with assigned language)*
- `cta delete translation <type_id> <bundle_id>` — *Delete translation <type> <bundle> (with assigned language)*
- `cta translate any entity` — *Translate any entity (with assigned language)* (global escape hatch)

Example machine names: `cta translate node article`, `cta create translation node page`,
`cta delete translation media image`.

## Resolution — `Permissions::hasPermission($operation, $entity_type_id, $bundle_id, $account)`

Static method used by `AccessControlHandler`:

1. Returns TRUE immediately if the account has `bypass node access` **or** `cta translate any entity`.
2. Maps the operation string: `update → translate`, `create → create translation`,
   `delete → delete translation` (other operations are used verbatim).
3. Returns `$account->hasPermission("cta <operation> <type_id> <bundle_id>")`.

Note both a specific `cta …` permission **and** an assigned language matching the target language are
required for `AccessControlHandler` to return `allowed()` (except the two bypass permissions in step 1,
which still require an assigned language at the handler level). Assigned languages come from LanguageProvider
plugins — see [../plugins/language-provider.md](../plugins/language-provider.md) and the
`content_translation_access_user` submodule.
