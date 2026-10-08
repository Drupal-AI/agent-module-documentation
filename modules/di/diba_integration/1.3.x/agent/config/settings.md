<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# diba_integration base module — behavior & operations

The base module has no settings form, routes, permissions or config objects. It ships hook logic and one maintenance service. Source: `diba_integration.module` (empty stub), `src/Hook/DibaIntegrationHooks.php`, `src/Service/DibaIntegrationMaintenanceService.php`, `diba_integration.install`, `diba_integration.services.yml`.

## Install / enable
`ddev drush en diba_integration -y`. Because the info.yml lists 14 dependencies, this enables the full bundle (admin_toolbar, antibot, backup_migrate, honeypot, masquerade, pathauto, reroute_email, role_delegation, simple_sitemap, yasm, no_404_log, plus core automated_cron, locale, syslog). Submodules are enabled separately.

## Cron maintenance — `DibaIntegrationMaintenanceService`
`#[Hook('cron')]` → `cron()`:
- Returns early unless `temporary://` is a directory; reads `TimeInterface::getRequestTime()`.
- `cleanBamFiles($path, $now)` — throttled to once per week via state key `diba_integration.cron_bam_tmp_check`; iterates `temporary://`, deletes entries whose name starts with `bam` (Backup and Migrate scratch files) via `FileSystemInterface::delete()`; logs a count to channel `diba_integration`.
- `cleanTempFiles($path, $now)` — throttled to once per 3 months via state key `diba_integration.cron_tmp_check`; calls `deleteFolderContent()` which `deleteRecursive()`s every entry in `temporary://` except `.` `..` `.htaccess`.
- `shouldRun($last, $now, $interval)` — TRUE when never run or `last < strtotime($interval, $now)`.
- Helper methods `deleteFile()`, `deleteFolder()`, `deleteFolderContent()` wrap core `FileSystem` and swallow `FileException` so one bad file does not abort the run.

Operational note: `cleanTempFiles` wipes the *entire* temporary directory quarterly — do not rely on `temporary://` for anything meant to persist.

## Generator meta removal
`#[Hook('page_attachments_alter')]` → `removeGeneratorMeta(&$attachments)`: scans `#attached[html_head]`, unsets the item whose key `[1]` equals `system_meta_generator`, then re-indexes. Removes `<meta name="generator" content="Drupal N (https://www.drupal.org)">` from all pages.

## Health checks — `hook_requirements($phase='runtime')`
Adds these rows to `/admin/reports/status` (severity OK/WARNING via `RequirementSeverity` with a `DeprecationHelper` back-compat shim):
- `diba_integration_unused_files` — warns unless `file.settings:make_unused_managed_files_temporary` is TRUE.
- `diba_integration_roles` — warns if fewer than 4 user roles exist.
- `diba_integration_users` — warns if fewer than 3 users (anonymous excluded from the displayed count).
- `diba_integration_site_mail` — warns unless `system.site:mail` ends with `@diba.cat`.
- `diba_integration_missing_modules` — warns if any `system.schema` key (other than `system`) has no matching installed module.
- `diba_integration_filename_sanitization` — warns unless all of `file.settings:filename_sanitization` (`transliterate`, `replace_whitespace`, `lowercase`, `replace_non_alphanumeric`) are TRUE.

## Library
`status_card` (`diba_integration.libraries.yml`) → `css/status-card.css`; attached by the SAML and VUS settings forms as `diba_integration/status_card` to style their enabled/disabled banner.
