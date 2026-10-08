# Update report UI

Path `/admin/config/development/configuration/report` (route `config_update_ui.report`,
permission `view config updates report`). Choose a scope: a **config type**, an installed
**module/theme/profile**, or **all** configuration.

Report sections:
- **Missing** — defaults an extension ships that are absent from active storage. Action:
  **Import** (route `config_update_ui.import`).
- **Added** — active config no extension provides (shown for type-scoped runs). Action:
  export.
- **Changed** — active config that differs from the current shipped default. Actions:
  **Diff** (`config_update_ui.diff`), export, or **Revert** (`config_update_ui.revert`)
  which overwrites the active item with the default.

Delete a stray item via `config_update_ui.delete`. All confirm forms live under the report
path. Comparisons use base config only (no `settings.php` overrides, no translations);
install-profile defaults win over module/theme defaults for the same item.
