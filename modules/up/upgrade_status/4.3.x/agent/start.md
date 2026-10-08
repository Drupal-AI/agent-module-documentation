# upgrade_status — agent start

Read-only static-analysis tool that reports major-upgrade readiness (deprecated API, metadata,
environment). Depends on core `update`. UI: **Admin → Reports → Upgrade status**
(`/admin/reports/upgrade-status`, route `upgrade_status.report`, permission
`administer software updates`).

- Run scans + settings UI (`paths_per_scan`, routes, groups) → [configure/scan.md](configure/scan.md)
- CLI scanning for CI (`upgrade_status:analyze`, `:checkstyle`) → [drush/commands.md](drush/commands.md)
- Alter hooks (batch operations, result build) → [hooks/hooks.md](hooks/hooks.md)
- Analyzer services & export theming → [api/services.md](api/services.md)
