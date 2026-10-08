<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Layouts — settings form & core-layout suppression

## Config object

`basic_layouts.settings` (config_object). One key:

| Key | Type | Default (install) | Meaning |
|-----|------|-------------------|---------|
| `unset_core_layouts` | boolean | `TRUE` | When true, hide core's default section layouts from Layout Builder. |

Schema: `config/schema/basic_layouts.schema.yml`. Install default: `config/install/basic_layouts.settings.yml`
(`unset_core_layouts: TRUE`).

## Settings form

- Route: `basic_layouts.basic_layouts_config`, path `/admin/config/content/basic-layouts-config`
  (`basic_layouts.routing.yml`).
- Permission: `administer site configuration` (core permission; not module-provided).
- Form class: `Drupal\basic_layouts\Form\BasicLayoutsConfig` (`src/Form/BasicLayoutsConfig.php`), a
  `ConfigFormBase`. Editable config: `basic_layouts.settings`. Renders a single checkbox
  "Unset core layouts?" (`unset_core_layouts`, default reads config `?? TRUE`) and saves it.
- Menu link: `basic_layouts.links.menu.yml` places it under `system.admin_config_content`
  (Configuration > Content Authoring), weight 10.

## Core-layout suppression hook

`basic_layouts.module` implements
`hook_plugin_filter_layout__layout_builder_alter($definitions, $extra)`:

```
if (\Drupal::config('basic_layouts.settings')->get('unset_core_layouts')) {
  unset($definitions['layout_onecol']);
  unset($definitions['layout_twocol_section']);
  unset($definitions['layout_threecol_section']);
  unset($definitions['layout_fourcol_section']);
}
```

So with the flag on (the default), core's four section layouts disappear from the Layout Builder picker,
leaving only the Basic Layouts variants. Uncheck the box on the settings form to restore them. The filter
runs only for the `layout_builder` consumer, so other layout consumers still see core layouts.

## Notes for agents

- Programmatic toggle:
  `drush config:set basic_layouts.settings unset_core_layouts 0` (or `1`), then rebuild caches so the
  layout plugin filter re-runs.
- No permissions, services, Drush commands, entities, or `hook_update_N` are provided by this module.
