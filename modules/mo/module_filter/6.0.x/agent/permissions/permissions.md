# Module Filter permissions

From `module_filter.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer module_filter` | Access the Module Filter settings form (`module_filter.settings`) and configure how it behaves. |

The filter enhancements themselves appear on the standard admin pages (Extend, uninstall,
update-status report, permissions) and are shown to whoever already has access to those pages
(`administer modules`, `administer software updates`, `administer permissions` respectively). Only
changing Module Filter's own configuration requires this permission.
