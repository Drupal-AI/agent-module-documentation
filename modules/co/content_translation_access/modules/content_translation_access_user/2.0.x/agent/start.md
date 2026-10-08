<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content translation access user (content_translation_access_user) — agent index

Submodule of **content_translation_access** providing the bundled per-user "assigned languages" source.
Info-yml name: *Content translation success user*. Depends on `content_translation_access`, `user`,
`language`. Core `^10.5 || ^11.0`. GPL-2.0-or-later. Version 2.0.0. No routing/config UI.

## What it provides

- User field **`field_access_languages`** (entity_reference → `configurable_language`, cardinality -1,
  label "Languages"). Config in `config/optional/field.storage.user.field_access_languages.yml` and
  `field.field.user.user.field_access_languages.yml`. `hook_install` places its widget
  (`entity_reference_autocomplete_tags`) on the default user form; `hook_uninstall` deletes both config
  objects.
- **`UserLanguageProvider`** plugin (`id user_language_provider`) → [plugins/user-language-provider.md](plugins/user-language-provider.md).
- A field-access hook and permission → see below.

## Access / permissions

- `hook_entity_field_access` (`content_translation_access_user_entity_field_access`): for field
  `field_access_languages`, returns `AccessResult::forbidden()` unless the account has
  `edit local translation access`, else `AccessResult::neutral()`. (Note: the permission name checked in
  the hook differs from the `edit user translation languages` label declared in
  `content_translation_access_user.permissions.yml`; the effect is fail-closed — the field is locked down.)
- Parent module: [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md).
