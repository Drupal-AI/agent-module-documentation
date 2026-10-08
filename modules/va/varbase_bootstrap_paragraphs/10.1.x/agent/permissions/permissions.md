# Permissions

Defined in `varbase_bootstrap_paragraphs.permissions.yml`:

| Permission | Grants |
|---|---|
| `administer varbase bootstrap paragraphs settings` | Access the settings form at `/admin/config/varbase/varbase-bootstrap-paragraphs` (route `varbase_bootstrap_paragraphs.settings`) to edit the `background_colors` style list. |

This is the module's only own permission; it is the sole requirement on the settings route. It is a
restricted/administrative permission (should be given only to trusted site administrators, since the
form rewrites field-storage `allowed_values`).

## Role grants shipped at install

`hook_install()` calls `ModuleInstallerFactory::addPermissions('varbase_bootstrap_paragraphs')`,
which reads the `config/permissions/user.permissions.*.yml` files and grants the listed permissions
to matching Varbase roles (`site_admin`, `content_admin`, `editor`, `seo_admin`, `authenticated`,
`anonymous`). These files assign **existing** Paragraphs/Paragraphs-Library permissions — e.g.
`view unpublished paragraphs`, `view any paragraphs previewer`,
`access paragraphs_library_items entity browser pages`, and (for content roles) `create/edit
paragraph library item` — they do not define new permissions. Creating/editing paragraph content
itself is governed by the standard Paragraphs module permissions, not by this module.
