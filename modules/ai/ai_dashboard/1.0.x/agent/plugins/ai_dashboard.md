<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins provided by AI Dashboard

## `ai_documentation` — a YAML documentation-link plugin type

The module defines a lightweight **YAML plugin type** so any module can contribute a link to
the dashboard's **Documentation** block without writing PHP.

- Manager: `plugin.manager.ai_documentation` → `Drupal\ai_dashboard\AiDocumentationManager`
  (a `DefaultPluginManager` using `YamlDiscovery` on the discovery key **`ai_documentation`**,
  scanning every module directory).
- Plugin class/interface: `src/Plugin/AiDocumentation/AiDocumentation.php` (+ `…Interface.php`).
- Cache tag: `ai_documentation`.

### How to add a link

Drop a file named **`{module}.ai_documentation.yml`** in your module root. Each top-level key
is a plugin id; `label` and `url` are **required** (`processDefinition()` throws a
`PluginException` if either is missing). The final plugin id is prefixed with the providing
module (`{provider}_{key}`). Example, from ai_dashboard itself:

```yaml
# my_module.ai_documentation.yml
drupal_ai_general:
  label: 'Official Drupal AI page'
  url: 'https://www.drupal.org/ai'
  description: 'General information about AI in Drupal'   # optional
```

`label` is translatable (`addTranslatableProperty('label', 'label_context')`). Read them all:

```php
$defs = \Drupal::service('plugin.manager.ai_documentation')->getDefinitions();
// each: ['id' => 'my_module_drupal_ai_general', 'label' => ..., 'url' => ..., 'description' => ...]
```

The **Documentation** block (`ai_documentation`) renders these, showing `soft_limit` before a
"show more" toggle (JS library `ai_dashboard/ai_documentation_expand`).

## `ai_dashboard_recommended` — a Project Browser source

`src/Plugin/ProjectBrowserSource/AiDashboardRecommended.php` implements project_browser's
`#[ProjectBrowserSource(id: 'ai_dashboard_recommended')]` (label "Recommended AI Recipes"). It
reads a curated **YAML list** of projects (local file or remote URL) and returns them as
`Project` objects, filtering by `core` semver compatibility. Its feed URL + cache TTL come from
the `enabled_sources.ai_dashboard_recommended` config the module installs (see
[../configure/ai_dashboard.md](../configure/ai_dashboard.md)). This is a *consumer* of
project_browser's plugin type — you configure it, you don't implement it.

## Block plugins (category "AI Dashboard")

Placeable on any dashboard/layout: `ai_setup_ai_provider` (Setup form),
`ai_operations_status` (provider capability status), `module_list_packages` (filtered module
list), `admin_menu_links` (AI admin menu), `ai_documentation` (doc links). To add your own
dashboard tile, write a normal `#[Block]` plugin and place it on the `ai_dashboard` dashboard.
