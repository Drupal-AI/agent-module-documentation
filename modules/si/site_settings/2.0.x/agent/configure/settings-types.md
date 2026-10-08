<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Define settings types, groups and module config

## Module config — `site_settings.config`

Route `site_settings.site_settings_config_form` → `/admin/config/site-settings/config`
(permission `administer site setting entities`). Defaults from `config/install`:

| Key | Default | Meaning |
|---|---|---|
| `template_key` | `site_settings` | Template variable the **flattened** loader auto-loads into. |
| `loader_plugin` | `full` | Active `site_settings_loader` plugin id. |
| `disable_auto_loading` | **`true` after install** (`config/install` ships `false`, but `site_settings_install()` overwrites it with TRUE) | Skip `hook_preprocess()` auto-loading entirely. |
| `hide_description` | `true` | Hide the `description` field on settings forms **and forbid field access to it**. |
| `hide_advanced` | `true` | Hide the `advanced` (revision) section on settings forms. |
| `hide_group` | `true` | Hide the per-entity `group` element on settings forms. |
| `simple_summary` | `true` | Replace the `teaser` view mode build with `site_settings.simple_teaser` output. |
| `show_groups_in_menu` | `true` | Derive admin menu links per group. |
| `edit_form_on_canonical_route` | `true` | Show the edit form on the entity's canonical route. |

```bash
drush cget site_settings.config
drush cset site_settings.config loader_plugin flattened -y
drush cset site_settings.config template_key my_settings -y
```

Switching the loader from code:

```php
\Drupal::service('plugin.manager.site_settings_loader')->setActiveLoaderPlugin('flattened');
```

## Settings **types** (bundles) — `site_settings.site_setting_entity_type.*`

Config entity `site_setting_entity_type`, `bundle_of: site_setting_entity`,
`config_export: id, label, group, multiple`.

```yaml
# site_settings.site_setting_entity_type.phone_number
id: phone_number
label: 'Phone number'
group: contact_details      # a site_setting_group_entity_type id (or a plain string)
multiple: false             # true => editors may create several entities of this type
```

```php
use Drupal\site_settings\Entity\SiteSettingEntityType;
SiteSettingEntityType::create([
  'id' => 'phone_number',
  'label' => 'Phone number',
  'group' => 'contact_details',
  'multiple' => FALSE,
])->save();
```

Admin routes: collection `/admin/structure/site_setting_entity_type`, add
`/admin/structure/site_setting_entity_type/add`, edit
`/admin/structure/site_setting_entity_type/{id}`, delete `…/delete`, replicate
`…/{setting}/replicate`. `field_ui_base_route` is the **edit form**, so *Manage fields* /
*Manage form display* / *Manage display* hang off `/admin/structure/site_setting_entity_type/{id}`.

Add fields exactly as for any bundle:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_number', 'entity_type' => 'site_setting_entity', 'type' => 'string',
])->save();
FieldConfig::create([
  'field_name' => 'field_number', 'entity_type' => 'site_setting_entity',
  'bundle' => 'phone_number', 'label' => 'Number',
])->save();
```

## Settings **groups** — `site_settings.site_setting_group_entity_type.*`

Config entity with just `id` + `label` (+ `uuid`), `admin_permission`
`access site settings overview`. Routes live under
`/admin/structure/site_setting_group_entity_types`.

```php
use Drupal\site_settings\Entity\SiteSettingGroupEntityType;
SiteSettingGroupEntityType::create(['id' => 'contact_details', 'label' => 'Contact details'])->save();
```

## The **values** — `site_setting_entity` content entities

Bundle key `type`, label key `name`, plus `group`, `langcode`, `status` (published) and full
revision support (`show_revision_ui: TRUE`).

```php
use Drupal\site_settings\Entity\SiteSettingEntity;
SiteSettingEntity::create([
  'type' => 'phone_number',
  'name' => 'Phone number',
  'group' => 'contact_details',
  'status' => 1,
  'field_number' => '+44 20 1234 5678',
])->save();
```

Editors manage them at `/admin/content/site-settings` — route
`entity.site_setting_entity.collection`, an `_entity_list` rendered by
`SiteSettingEntityListBuilder`, permission `access site settings overview`. (The module *also*
ships `views.view.site_settings`, a Views listing of the same entities, which the
`site_settings_type_permissions` submodule filters in `hook_views_pre_render()`.)
`hook_entity_operation()` adds an **Add another** operation for types whose `multiple` is TRUE.

```bash
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("site_setting_entity")->loadMultiple() as $e) {
  print $e->id() . " " . $e->bundle() . " " . $e->label() . " group=" . $e->get("group")->value . "\n";
}'
drush cget site_settings.site_setting_entity_type.phone_number
```

## Replicate

Route `site_settings.site_setting_replicate_form`
(`/admin/structure/site_setting_entity_type/{setting}/replicate`, permission
`administer site setting entities`), reachable from the type listing's *Replicate* operation.
Add rows of machine name / label / group to mass-create similar types; the batch runs through
`site_settings.replicator` (`SiteSettingsReplicator::processBatch()` /
`finishBatch()`).

## Related hooks the module implements

- `hook_form_alter()` — hides `description`, `advanced` and `group` on
  `site_setting_entity_*_form` forms according to the config flags.
- `hook_entity_field_access_alter()` — forbids the `description` field when `hide_description`.
- `hook_entity_type_alter()` — swaps `field_config`'s list builder for
  `SiteSettingsFieldUiListBuilder` (adds Twig-function help to the Manage fields table).
- `hook_page_attachments()` — attaches `site_settings/navigation_icon` when the core
  **navigation** module is on and the user has `access navigation`.
- `hook_site_settings_no_setting_token_alter(&$string)` (`site_settings.api.php`) — override the
  "Setting not found" string tokens emit when a setting is missing.
