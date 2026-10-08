# Hooks & integration points

All behavior is hook-driven (no routing/services). Hooks live in `acquia_cms_site_studio.module` and
`acquia_cms_site_studio.install`.

## Form alters

| Hook | Effect |
|---|---|
| `hook_form_install_configure_form_alter` | Injects the "Acquia Site Studio" API-key/organization-key fieldset into the core installer's site-configure form and appends `AcquiaCmsSiteStudioSiteConfigureForm::submitForm` to save them to `cohesion.settings`. |
| `hook_form_alter` | For form ids `cohesion_account_settings_form`, `acquia_cms_site_studio_core_form`, `acquia_cms_tour_installation_wizard`: appends `_acquia_cms_site_studio_init` as a submit handler **only if** `cohesion.settings` has no `api_key`+`organization_key` yet, so first-time key entry triggers the element import + UI-kit import + settings refresh. |
| `hook_library_info_alter` | Removes `collapsiblock`'s `core` CSS (it conflicts with Site Studio templates). |

## Role & permission grants

This module defines **no** `*.permissions.yml`; it grants existing Cohesion permissions to roles at
various lifecycle points, and ships the `developer` role.

| Hook | Roles affected | Permissions |
|---|---|---|
| `config/install/user.role.developer.yml` | creates `developer` ("Low Code Site Builder") | ~40 Cohesion `access *` / `administer *` element/style/template permissions. |
| `hook_content_model_role_presave_alter` | `content_administrator`, `content_editor`, `content_author`, `site_builder` (only when `cohesion.utils::usedx8Status()`) | `SiteStudioPermissionHelper::getSiteStudioPermissionsByRole()` — basic component/element/helper access, `use text format cohesion`, plus `access visual page builder` (admin/author) and `site_builder`'s admin set. |
| `hook_ENTITY_TYPE_insert` for `cohesion_helper_category` and `cohesion_component_category` (`_acquia_cms_site_studio_add_permissions`) | `content_administrator`, `content_author`, `content_editor` | Grants `access <id> <bundle> group` for the new category, gated by `SiteStudioPermissionHelper::getDynamicPermissionsByRole()`. |
| `hook_editor_insert` | `developer` | Grants `use text format <editor id>` for any newly inserted (non-syncing) editor. |
| `hook_modules_installed` | `developer`, `site_builder` | On `cohesion_style_guide` install → `administer style_guide`. On `node_revision_delete` install → seeds default revision-delete config (and page-type third-party settings when `acquia_cms_page` present) via `acquia_cms_common`'s `ConfigHandlerFacade`. |

`SiteStudioPermissionHelper` (`src/Helper`) is a static catalog: `basicComponentPermissions()`,
`additionalComponentCategoryPermissions()`, `additionalComponentHelperPermissions()`,
`basicComponentCategoryHelperPermissions()`, and the two role dispatchers above. Integrators reuse it to
mirror the same grants for custom roles.

## Install-lifecycle hooks

- `hook_install` — theme + credentials + settings + editor/filter config + installs
  `node_revision_delete`/`responsive_preview`/`cohesion_style_guide`/`sitestudio_config_management`
  (see [../configure/site-studio.md](../configure/site-studio.md)).
- `hook_module_preinstall` — forwards the module name to `acquia_cms_common.utility::setModulePreinstallTriggered()`.
- `hook_uninstall` — resets the `node.page` body field label/description.
- `hook_update_N` `8001`–`9001` — one-time migrations: image-browser config, installing
  `sitestudio_page_builder`, refactoring category permissions, re-importing missing component preview
  images (`SiteStudioSyncFilesEvent`/`SiteStudioSyncFilesSubscriber`), enforcing module dependency on
  Site Studio templates, re-saving cohesion config to recalc dependencies, deleting invalid config, and
  seeding node-revision-delete / CKEditor5 list settings.
