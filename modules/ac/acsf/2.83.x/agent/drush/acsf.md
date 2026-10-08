# Drush commands (ACSF platform only)

These are the site-side commands the Factory (and operators) invoke. Most only do useful work on
Acquia-hosted ACSF environments. Commands come from three places: `AcsfInitCommands` (the
**standalone** `acsf_init` dir, run with `--include`), `AcsfCommands` (`src/Commands`, registered
in `acsf.services.yml` + `drush.services.yml`), and `AcsfExtraCommands` (`acsf_commands` dir).

## Codebase setup — standalone (`acsf_init`, run with `--include=<module>/acsf_init`)

| Command | Purpose |
|---|---|
| `acsf-init` | Patch the codebase (`sites.php`, Cloud Hooks, `.htaccess`) for ACSF. Re-run after every module update. `-y` overwrites without prompting. |
| `acsf-init-verify` | Verify the patched files are present/current. ACSF **denies deployment** if this fails. |
| `acsf-connect-factory` | Connect a (non-production) site to a Factory for testing. |
| `acsf-uninstall` | Remove the ACSF codebase modifications. |

## Site lifecycle (`src/Commands/AcsfCommands.php`)

| Command | Purpose |
|---|---|
| `acsf-site-sync` | Sync the site with the Factory. With `--data=<base64 php array>` it consumes pushed data (`acsf_site_data_receive` event) and saves it; without data it requests a refresh. Also gathers stats via an `acsf_stats` event. |
| `acsf-site-scrub` | Scrub a staged/duplicated database: anonymize non-preserved user emails/init (SHA2), reset `system.cron_key` and the private key, truncate `sessions`/`watchdog`/`acsf_theme_notifications`, clear caches + form key-value, then run `sql-sanitize`. Preserves the anonymous user + users matched by the scrub alter hooks. Called by the `db-copy` hosting task. |
| `acsf-build-registry` | Rebuild the ACSF event/handler registry (`acsf_get_registry()`); runs automatically on `hook_modules_installed`. |
| `acsf-install-task-get` | Return the last completed install task (JSON) — used during Factory install orchestration. |

## Extra ops (`acsf_commands/src/Commands/AcsfExtraCommands.php`)

| Command | Purpose |
|---|---|
| `acsf-get-factory-creds` | Fetch the site's Factory credentials. |
| `acsf-version-get <path>` | Report the installed ACSF module version. |
| `go-offline` / `go-online` | Take the site offline/online around platform tasks. |
| `report-complete-async-process` | Report completion of an async platform process (`--data`). |

Duplication-scrub batch (`acsf_duplication`): the `site_duplication_scrub` event is driven by
`drush acsf-duplication-scrub-batch`, whose context can be tuned via
`hook_acsf_duplication_scrub_context_alter()` (`--exact-copy`, `--retain-users`,
`--retain-content`, `--batch*`). See [hooks/acsf.md](../hooks/acsf.md).
