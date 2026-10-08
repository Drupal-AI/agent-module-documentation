# Install / update glue (`acquia_cms_article.install`)

The only PHP in this module is install/update glue. There are no services, controllers or plugins.

## Hooks it implements

### `hook_content_model_role_presave_alter(RoleInterface &$role)`
`acquia_cms_article_content_model_role_presave_alter()` — a **custom alter hook invoked by
`acquia_cms_common`** as it presaves the distribution's editorial roles. Switches on `$role->id()`:
- `content_author` → grants `create article content`, `edit own article content`,
  `delete own article content`.
- `content_editor` → grants `edit any article content`, `delete any article content`.

This is how the Article permissions ([../permissions/permissions.md](../permissions/permissions.md))
attach to the standard roles. If you build your own content-type feature module for an Acquia CMS site
and want its permissions on these roles, implement the same alter hook.

### `hook_module_preinstall($module)`
`acquia_cms_article_module_preinstall()` calls
`\Drupal::service('acquia_cms_common.utility')->setModulePreinstallTriggered($module)` — it flags the
`acquia_cms_common` utility service that a module preinstall is in progress (used by the common layer's
optional-config import flow). The service lives in `acquia_cms_common`; see that module's
[api/services.md](../../../../acquia_cms_common/3.3.x/agent/api/services.md).

## Update hooks

All are idempotent config migrations run by `drush updatedb`. Several are guarded on
`acquia_cms_site_studio` being enabled.

| Function | What it does |
|----------|--------------|
| `_update_8001` | If `acquia_cms_common` + `acquia_cms_site_studio` are on, sets the `article_cards` view `default` display style to `view_tpl_article_cards_slider` (via a common helper). |
| `_update_8002` | Makes `field_display_author` optional (`setRequired(FALSE)`) if it was required. |
| `_update_8003` | Rewrites `pathauto.pattern.article` selection criteria from the `node_type` condition plugin to `entity_bundle:node`. |
| `_update_8004` | Sets `field.field.node.article.field_article_media` `handler_settings.target_bundles` to `{image: image}` when null. |
| `_update_8005` | Adds `field_article_image` (per view mode) and `field_display_author` back into the `default`/`card`/`horizontal_card`/`search_results`/`teaser` view displays as `entity_reference_entity_view`, clearing them from `hidden`. |
| `_update_8006` | Adds Scheduler widgets (`publish_on`/`unpublish_on`, `publish_state`/`unpublish_state`, `scheduler_settings`) to the `node.article.default` form display. |
| `_update_8007` | When Site Studio is on, sets `dependencies.enforced.module` = `[acquia_cms_article, acquia_cms_site_studio]` on each enabled template YAML under `config/pack_acquia_cms_article`. |
| `_update_8008` | When Site Studio is on, deletes any config under `config/pack_acquia_cms_article*` that has no `uuid`/`id` (invalid leftover data); logs each deletion to the `acquia_cms_article` channel. |

There is no `hook_install`/`hook_uninstall` and no `*.post_update.php`; content-type creation/removal
is handled entirely by the optional config lifecycle.
