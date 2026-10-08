<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & install/update behavior

The module's PHP is thin glue around its installed config. These are the hooks that produce side
effects an integrator should know about (`acquia_cms_page.module` + `acquia_cms_page.install`).

## Runtime / module hooks (`.module`)

- **`acquia_cms_page_modules_installed($modules, $is_syncing)`** — when
  `acquia_cms_site_studio` is installed (and not during config sync), it makes the `body` field on
  Page a search field: sets `field.field.node.page.body` `label` → "Search Description" and
  `description` → "A short description or teaser which will be displayed in search results." Rationale:
  with Site Studio the page layout is authored on Layout Canvas, so Body is repurposed for search.

## Install hooks (`.install`)

- **`acquia_cms_page_install($is_syncing)`** — if `node_revision_delete` is installed, seeds its
  third-party settings for the `page` node type via `acquia_cms_common`'s
  `ConfigHandlerFacade::processThirdPartySettings()`: keep the latest **30** revisions
  (`amount.status: TRUE`, `amount: 30`); the `created`/`drafts`/`drafts_only` policies are disabled.
  (composer.json conflicts with `node_revision_delete < 2.0.0`.)
- **`acquia_cms_page_content_model_role_presave_alter(RoleInterface &$role)`** — grants the Page node
  permissions to Acquia CMS roles; see [../permissions/permissions.md](../permissions/permissions.md).
- **`acquia_cms_page_module_preinstall($module)`** — calls
  `\Drupal::service('acquia_cms_common.utility')->setModulePreinstallTriggered($module)` (shared
  Acquia CMS install bookkeeping).

## Update hooks

| Function | What it does |
|---|---|
| `acquia_cms_page_update_8001` | Swap `pathauto.pattern.page` selection plugin `node_type` → `entity_bundle:node`. |
| `acquia_cms_page_update_8002` | No-op (stale after `node_revision_delete` 2.x schema change). |
| `acquia_cms_page_update_8003` | Add `field_page_image` to the Page view displays with the correct referenced view mode. |
| `acquia_cms_page_update_8004` | Add Scheduler widgets (`publish_on`/`unpublish_on`/`publish_state`/`unpublish_state`/`scheduler_settings`) to the default form display. |
| `acquia_cms_page_update_8005` | When Site Studio is present, set `dependencies.enforced.module` on the Cohesion templates in `config/pack_acquia_cms_page`. |
| `acquia_cms_page_update_8006` | Delete Site Studio pack config entities that have no `uuid`/`id` (invalid leftovers); logs a notice per deletion. |

The module implements no `hook_theme`, provides no services/routes/blocks/plugins of its own — all of
the above is config seeding plus a small amount of lifecycle glue tied to `acquia_cms_common` and
`acquia_cms_site_studio`.
