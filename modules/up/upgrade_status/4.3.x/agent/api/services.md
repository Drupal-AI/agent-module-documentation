# Services & export theming

Analysis services (`upgrade_status.services.yml`). Consume these to drive scans in code.

- `upgrade_status.deprecation_analyzer` (`DeprecationAnalyzer`) — orchestrates a full scan of an
  extension: runs PHPStan plus the specialized analyzers below and stores results in keyvalue.
- `upgrade_status.project_collector` (`ProjectCollector`) — enumerates custom/contrib/profile
  projects and their scan state.
- `upgrade_status.result_formatter` (`ScanResultFormatter`) — formats stored scan results for
  display/export.
- Specialized analyzers (each targets one deprecation surface):
  `upgrade_status.twig_deprecation_analyzer`, `.library_deprecation_analyzer`,
  `.theme_function_deprecation_analyzer`, `.route_deprecation_analyzer`,
  `.extension_metadata_deprecation_analyzer`, `.config_schema_deprecation_analyzer`,
  `.css_deprecation_analyzer`.
- `logger.channel.upgrade_status` — module log channel.

## Export theming
`upgrade_status_theme()` registers:
- `upgrade_status_html_export` → `templates/upgrade-status-html-export.html.twig`
- `upgrade_status_ascii_export` → `templates/upgrade-status-ascii-export.html.twig`
- `upgrade_status_summary_counter` (variables: `summary`)

Preprocess: `template_preprocess_upgrade_status_html_export()` (and the ascii variant) map project
`#title` to `name`. Override the templates in a theme to restyle exports.
