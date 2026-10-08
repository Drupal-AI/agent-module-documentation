# Xray Audit services (programmatic use)

Declared in `xray_audit.services.yml`. The interesting ones for reuse:

| Service id | Interface / class | Use for |
|---|---|---|
| `xray_audit.plugin_repository` | `Services\PluginRepositoryInterface` | Discover/instantiate group & task plugins, get their definitions and per-operation route info; caches results in the `xray_audit` bin. Entry point for building or reusing report data. |
| `xray_audit.cache_manager` | `Services\CacheManagerInterface` | Read/write/remove the dedicated `xray_audit` cache bin (backend `cache.xray_audit`). |
| `xray_audit.entity_architecture` | `Services\EntityArchitectureInterface` | Enumerate content entity types, bundles, fields and their data types/config. |
| `xray_audit.entity_display_architecture` | `Services\EntityDisplayArchitectureInterface` | Inspect entity display/view-mode configuration and render sample displays. |
| `xray_audit.entity_use_node` | `Services\EntityUseInterface` (`EntityUseNode`) | Count/locate node usage. `initParameters($parent, $bundle)` then `countEntityUses()` / `getEntityUsePlaces()`. |
| `xray_audit.entity_use_paragraph` | `Services\EntityUseInterface` (`EntityUseParagraph`) | Same interface for paragraphs (referenced in published+unpublished entities). |
| `xray_audit.paragraph_usage_map` | `Services\ParagraphUsageMap` | Build the nested paragraph-usage hierarchy. |
| `xray_audit.navigation_architecture` | `Services\NavigationArchitectureInterface` | Render menu-link tree architecture. |
| `xray_audit.csv_download_manager` | `Services\CsvDownloadManagerInterface` | Stream a task operation's data as a CSV download. |

## EntityUse example

```php
$svc = \Drupal::service('xray_audit.entity_use_node');
$svc->initParameters('node', NULL);      // parent type, bundle (NULL = all)
$counts = $svc->countEntityUses();       // table-shaped array
```

## Discovering report data via the repository

```php
$repo = \Drupal::service('xray_audit.plugin_repository');
$taskDefs = $repo->getTaskPluginDefinitions();          // all task definitions (cached)
$task = $repo->getInstancePluginTask('queries_data_nodes');
$data = $task->getDataOperationResult('node_count_type'); // raw rows for one operation
$build = $task->buildDataRenderArray($data, 'node_count_type'); // render array
```

To add your own report, implement a task plugin instead of calling these directly — see
[../plugins/plugins.md](../plugins/plugins.md).

## Extension / alter hooks

- Plugin `alter` hooks: `hook_xray_audit_group_info(&$definitions)` and
  `hook_xray_audit_task_info(&$definitions)` (from the managers' `alterInfo()`), plus
  `hook_xray_audit_insight_info()` in the submodule.
- Theme hooks: `page__xray_audit` (template `page--xray-audit`) and `xray_audit_popup`.
