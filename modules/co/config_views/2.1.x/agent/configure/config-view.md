<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build a View of configuration entities

The module has **no settings page** (`configure: null`). You use it by creating Views on the
config-entity base tables it exposes, or by enabling the default Views it ships.

## Base tables

For every config-entity type with a list builder and a config prefix, config_views adds a
base table named `config_` + the config prefix with dots replaced by underscores:

| Config entity type | Config prefix | Views base table | base_field |
|---|---|---|---|
| Content type | `node.type` | `config_node_type` | `type` |
| User role | `user.role` | `config_user_role` | `id` |
| Image style | `image.style` | `config_image_style` | `name` |
| Menu | `system.menu` | `config_system_menu` | `id` |
| Taxonomy vocabulary | `taxonomy.vocabulary` | `config_taxonomy_vocabulary` | `vid` |
| Text format | `filter.format` | `config_filter_format` | `format` |
| View | `views.view` | `config_views_view` | `id` |

Exposed fields/filters/sorts come from each type's config **schema** (label, description,
booleans, integers, strings), plus an **Operations** field.

## Create a View via the UI

1. Go to *Structure » Views » Add view* (`/admin/structure/views/add`).
2. In **View settings → Show**, the dropdown is grouped into **Content** and **Configuration**.
   Pick the config entity you want (e.g. *User role*, *Content type*).
3. Choose a display (page/block), add fields/filters, and save. The View's `base_table` will
   be the matching `config_<type>` table and it uses the `views_config_entity_query` query.

## The shipped default Views

config_views installs ~14 Views. Several are **enabled** and take over core admin lists;
others ship **disabled** — enable them at *Structure » Views* to have them take over:

- Enabled by default: `comment_types`, `content_types` (`admin/structure/types`),
  `custom_block_types`, `date_formats`, `image_styles`, `menus`, `shortcuts`, `taxonomy`.
- Disabled by default (opt in): `contact_forms`, `form_modes`, `text_formats`, `user_roles`,
  `view_modes`, `views_list`.

```bash
drush views:enable user_roles      # opt into the roles listing View
drush cget views.view.content_types base_table   # -> config_node_type
```

## Create a View in config (scriptable)

Minimum viable View on a config base table (add fields/displays as needed):

```php
\Drupal\views\Entity\View::create([
  'id' => 'cv_roles',
  'label' => 'Roles',
  'base_table' => 'config_user_role',
  'base_field' => 'id',
  'display' => [
    'default' => [
      'display_plugin' => 'default', 'id' => 'default', 'display_title' => 'Master',
      'position' => 0,
      'display_options' => [
        'query' => ['type' => 'views_config_entity_query'],
        'fields' => [
          'id' => ['id' => 'id', 'table' => 'config_user_role', 'field' => 'id', 'plugin_id' => 'standard'],
        ],
      ],
    ],
  ],
])->save();
```

Read it back: `drush cget views.view.cv_roles base_table` → `config_user_role`.
