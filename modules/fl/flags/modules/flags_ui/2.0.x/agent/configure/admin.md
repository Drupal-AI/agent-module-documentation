# Flags UI admin

All pages require the **`administer flag mapping`** permission (defined by the base `flags` module).

## Routes (`flags_ui.routing.yml`)
Root menu: `flags.menu` → `/admin/config/regional/flags` (systemAdminMenuBlockPage; the `configure`
route).

Country mappings (`country_flag_mapping` entity):
- `entity.country_flag_mapping.list` → `/admin/config/regional/flags/countries`
- `.add_form` → `/admin/config/regional/flags/countries/add`
- `.edit_form` → `/admin/config/regional/flags/countries/{country_flag_mapping}`
- `.delete_form` → `…/{country_flag_mapping}/delete`

Language mappings (`language_flag_mapping` entity):
- `entity.language_flag_mapping.list` → `/admin/config/regional/flags/languages`
- `.add_form` → `/admin/config/regional/flags/languages/manage/add`
- `.edit_form` → `/admin/config/regional/flags/languages/manage/{language_flag_mapping}`
- `.delete_form` → `…/{language_flag_mapping}/delete`

List routes use `_permission: 'administer flag mapping'`; add/edit/delete use
`_entity_create_access` / `_entity_access`, resolved by `FlagMappingAccessController` which also
requires `administer flag mapping`.

## What you edit
Each mapping entity has two fields:
- `source` — the input code (country or language code); also the entity id.
- `flag` — the flag/territory code to render for that source.

Saving a mapping makes `BaseMapping::map($source)` return `flag` instead of `source`, so the base
module's theme hook renders `flag flag-<flag>`. Forms live in `flags_ui/src/Form/`.
