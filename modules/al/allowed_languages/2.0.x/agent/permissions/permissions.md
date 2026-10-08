# Permissions

Defined in `allowed_languages.permissions.yml` (neither is `restrict access: true`):

| Permission | Gates |
|---|---|
| `administer allowed languages` | Whether the "Allowed languages" details/checkboxes group is shown (`#access`) on the user edit form, i.e. who can view and assign a user's allowed languages. |
| `translate all languages` | **Bypass.** A holder is exempt from every restriction: `hasPermissionForLanguage()` returns TRUE immediately, the create-form language selector is not pruned, `hook_entity_access` short-circuits, and the translations overview keeps all operation links. |

Notes:
- There is no permission that *turns on* the restriction — restriction is the default for any user who
  lacks `translate all languages`. A user with **no** allowed languages assigned (and without the
  bypass) is effectively blocked from editing/deleting translatable content and managing translations.
- `administer allowed languages` only controls editing the field UI; it does not by itself grant the
  bypass. Grant `translate all languages` to trusted leads/admins who must work in every language.
- Typical setup: give editors the relevant core content_translation permissions, assign each editor a
  subset of languages, and give `translate all languages` only to super-editors/admins.
