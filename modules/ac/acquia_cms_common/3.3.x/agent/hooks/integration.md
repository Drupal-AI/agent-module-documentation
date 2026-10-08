<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integration hooks & facades

This is how the sibling `acquia_cms_*` content-type modules plug into the shared editorial machinery. The
mechanism is `third_party_settings` on the `node_type` config entity, consumed on insert.

## Node-type third-party settings (namespace `acquia_cms_common`)

Set these on a `node.type.*` entity (schema in `config/schema/acquia_cms_common.schema.yml`):

| Setting | Meaning |
| --- | --- |
| `workflow_id` | Content Moderation workflow to auto-add the content type to. |
| `metatag` → `tag_types` (sequence) | Metatag tag-type groups to enable for the type. |
| `sitemap_variant` | Simple Sitemap variant the type should be added to. |
| `workbench_email_templates` (sequence) | Workbench Email templates the type is added to. |
| `subtype` → `field` / `facet` | Machine names of the sub-type term-reference field and its listing-page facet. |

`acquia_cms_common_node_type_insert()` (`hook_ENTITY_TYPE_insert`) runs three facades against the new
node type:

- `WorkflowFacade::addNodeType()` — adds the bundle to the `workflow_id` Content Moderation workflow (warns if the workflow is missing or non-moderation).
- `MetatagFacade::addNodeType()` — writes `metatag.settings:entity_type_groups.node.<bundle>` from `metatag.tag_types`.
- `SitemapFacade::enableSitemap()` — enables sitemap bundle settings for `sitemap_variant`.

All three no-op during a config sync (`configInstaller->isSyncing()`). These facade classes are `@internal`;
drive them declaratively through the third-party settings rather than calling them.

Example node-type config fragment:

```yaml
third_party_settings:
  acquia_cms_common:
    workflow_id: editorial
    sitemap_variant: default
    metatag:
      tag_types: [basic, open_graph, twitter_cards]
```

## `field.storage.*` third-party settings

The schema also allows `search_index` / `search_label` on `field.storage.*.*` under the
`acquia_cms_common` namespace — a passive way to opt a field into a Search API index (consumed by
`acquia_cms_search`).

## Alter hook you can implement

`acquia_cms_common` invokes `\Drupal::moduleHandler()->alter('content_model_role_presave', $role)` when
creating/updating its roles. Implement it to adjust ACMS roles as they are built:

```php
/**
 * Implements hook_content_model_role_presave_alter().
 */
function mymodule_content_model_role_presave_alter(\Drupal\user\RoleInterface &$role) {
  if ($role->id() === 'content_editor') {
    $role->grantPermission('my custom permission');
  }
}
```

The module's own implementation (in `.install`) grants `administer shield/honeypot/CAPTCHA/recaptcha` to
`user_administrator` and `clone node entity` to the content roles, depending on which modules are enabled.

## Other notable hook implementations

- `hook_modules_installed` — builds the `content_*` roles (see permissions doc), sets ImageMagick toolkit on Acquia envs, imports Site Studio packages, rewrites `entity_clone.settings`.
- `hook_theme` — `status_report_general_info_starter_kit`, `page__system__403`, `page__system__404` templates.
- `hook_views_data` — a `main_listing_pages_view` area handler (search-aware text area).
- `hook_mail_alter` — cancels sending of `template::*` mails still using `no-reply@example.com`.
- `hook_library_info_alter` — swaps `eu_cookie_compliance` default CSS for the module's own.
- `hook_system_breadcrumb_alter` — fixes node add/edit breadcrumb text.
- `hook_config_schema_info_alter` — adds `entity_clone.settings` form-setting schema when entity_clone is present.
