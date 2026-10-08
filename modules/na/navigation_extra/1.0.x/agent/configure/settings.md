<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Navigation Extra

Route `navigation_extra.settings` → **`/admin/config/user-interface/navigation/extra`**, permission
**`administer site configuration`**. Form `SettingsForm` (`src/Form/SettingsForm.php`) renders every
discovered `NavigationExtraPlugin` as a vertical-tab: it instantiates each plugin, calls its
`buildConfigForm()`, and auto-adds a `#states` rule hiding a plugin's options unless its `enabled`
checkbox is ticked. Writes to config object `navigation_extra.settings`.

## Config shape

```
navigation_extra.settings:
  plugins:
    <plugin_id>:
      enabled: bool
      weight: int
      icon: { target_id, settings: { class, size } }   # optional
      <plugin-specific keys...>
```

Schema: `navigation_extra.plugin` (base) + `navigation_extra.plugin.<id>` per plugin
(`config/schema/navigation_extra.schema.yml`).

## Per-plugin options (install defaults in `config/install`)

| Plugin id | Notable keys |
|---|---|
| `common` | `group_collections` (''/top/bottom), `hide_empty_collections`, `hide_add_new_content`, `generate_overview_links`, `override_max_menu_depth` (bypass core's 3-level cap). Always enabled. |
| `blocks` | `hide_core_link`, `position`, `navigation_safe_block_ids`, `hidden_navigation_safe_block_ids` |
| `content` | `recent_items` (`limit`, `link`), `collections`, `create_items` (`hide_from_navigation_create`, `show_create_new_links`, `navigation_create_collections`) |
| `files` | `hide_core_link`, `show_in_media` |
| `media` | `link_media_library`, `collections`, `create_items` |
| `taxonomies` | `collections`, `create_items` |
| `users` | `roles` (show role items), `roles_to_hide`, `people`, `add_new_user`, `collections` |
| `forms` | `webform` (`enable`, `link_to_results`), `contact` (`enable`) |
| `tools` | `navigation_extra_tools` (`position`, `group`), `devel` (`position`, `group`) |
| `local_tasks` | base keys only (adds entity local tasks to navigation) |
| `version` | `source` (`provider`, `module`, `file`, `env`, `pattern`, `format`), `output` (`title`, `description`, `url`, `updates`), `environments[]` (`name`, `color`, `background`, `source`) |

Shared sub-schemas: `navigation_extra.collections` (hierarchical `label`/`items`/nested `collections`),
`navigation_extra.create_items`, `navigation_extra.recent_items`.

## Set via Drush

```
drush cset navigation_extra.settings plugins.common.override_max_menu_depth 1 -y
drush cset navigation_extra.settings plugins.content.recent_items.limit 10 -y
drush cset navigation_extra.settings plugins.users.enabled 0 -y
```
