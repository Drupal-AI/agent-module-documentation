# Allowed Languages — agent index

Limits which languages a user may **manage** (edit/delete/translate) content in. Adds an
`allowed_languages` reference field to every user, plus access checks that forbid update/delete and
translation ops on content in non-allowed languages. Depends on `content_translation` + `user`.
No config page (`configure` null), no config schema, no Drush.

- **The two permissions and the bypass** → [permissions/permissions.md](permissions/permissions.md)
- **The manager service, the access model (what is and isn't enforced), the Views filter, hooks** →
  [api/manager.md](api/manager.md)

Key facts:
- Base field `allowed_languages` (unlimited `entity_reference` → `configurable_language`) added to
  `user`; edited as "Allowed languages" checkboxes on the user form.
- Permissions: `administer allowed languages` (see/set the field), `translate all languages` (bypass).
- Enforcement: `hook_entity_access()` forbids `update`/`delete` for disallowed languages;
  `ContentTranslationAccessCheck` gates `_access_content_translation_manage`; overview controller strips
  disallowed operation links; create-form language `<select>` options are pruned at pre-render.
- Service `allowed_languages.allowed_languages_manager` → `assignedLanguages()`,
  `hasPermissionForLanguage()`, `isEntityLanguageControlled()`, `accountFromProxy()`.
- Views filter `allowed_languages` ("Current users allowed languages", cannot be exposed).
