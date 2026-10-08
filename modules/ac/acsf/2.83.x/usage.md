The ACSF Connector integrates a Drupal site with the Acquia Cloud Site Factory (ACSF) platform, providing the site-side glue for site duplication, staging scrubs, factory data sync, theme events, and SSO. It only does anything useful on Acquia-hosted ACSF environments; on a normal site it is inert.

---

ACSF (Acquia Cloud Site Factory) is Acquia's hosting product for running and managing large numbers of Drupal sites from one codebase and a central Management Console ("the Factory"). This module suite is the code that lives inside each managed site and talks back to the Factory. Communication is one-directional site→Factory over a REST wrapper (`AcsfMessage` / `AcsfMessageRest`) authenticated with hosting credentials; the site keeps a local mirror of its Factory-assigned identity (`AcsfSite`, keyed by `acsf_site_id` from `sites.json`) and periodically refreshes it via cron. A custom event framework (`AcsfEvent` + `AcsfEventHandler`, registered through `hook_acsf_registry()`) runs platform lifecycle tasks: `acsf_install`, `acsf_site_data_receive`/`_save`, and most importantly `site_duplication_scrub`, which sanitizes a copied database when a production site is staged (anonymizing user emails, resetting passwords, keys and cron secrets, truncating sessions/logs, running `sql-sanitize`). A separate **standalone** `acsf-init` Drush script (not an enableable module — invoked with `drush --include=<module>/acsf_init acsf-init`) patches the codebase's `sites.php`, settings, `.htaccess` and Cloud Hooks so early bootstrap routes each request to the right site database; `acsf-init-verify` gates deployment. Several submodules ship in one shared `src/`: `acsf_duplication` (scrub handlers), `acsf_theme` + `acsf_variables` (required, provide VCS theme handling and scrubbable variable storage), plus optional `acsf_sso` (Management Console login via SAML), `acsf_sj` (Scheduled Jobs) and `acsf_meta`. The module also injects a maintenance-mode notice during platform operations. Releases track ACSF platform releases rather than normal Drupal dev cadence, so `acsf-init` must be re-run after every module update.

---

- Connect a Drupal site running on Acquia Cloud Site Factory to its Factory Management Console.
- Route each incoming request to the correct site database during early bootstrap via a patched `sites.php`.
- Patch a codebase for ACSF with `drush --include=<module>/acsf_init acsf-init` before deploying.
- Verify the codebase's ACSF files are up to date with `acsf-init-verify` (deployment is blocked if it fails).
- Re-run `acsf-init` after every ACSF module update to refresh the required codebase files.
- Scrub a staged copy of a production site (`acsf-site-scrub`): anonymize user emails, reset passwords, keys and cron secret.
- Run the batched duplication scrub (`site_duplication_scrub` event) when a site is copied in the Management Console.
- Preserve specific admin user accounts from scrubbing via `hook_acsf_staging_scrub_admin_roles_alter()`.
- Preserve specific user IDs from scrubbing via `hook_acsf_staging_scrub_preserved_users_alter()`.
- Sync a site's identity and stats with the Factory (`acsf-site-sync`), pushing or pulling site data.
- Keep local site info fresh automatically through the module's daily cron refresh.
- Register custom platform-lifecycle event handlers with `hook_acsf_registry()` (e.g. run code on `acsf_install`).
- React to factory-pushed site data by handling the `acsf_site_data_receive` event.
- Send a REST message from the site to the Factory using `new AcsfMessageRest('GET', 'site-api/v1/sync/', [...])`.
- Read the current site's Factory identity and metadata via `AcsfSite::load()`.
- Store sensitive variables in one scrubbable place using `acsf_variables` storage.
- Handle VCS-based (git) themes on the platform via `acsf_theme` and its notification table.
- Enable Management Console single sign-on (SAML) for a site with the optional `acsf_sso` submodule.
- Integrate with Site Factory Scheduled Jobs using the optional `acsf_sj` submodule.
- Add platform meta tags with the optional `acsf_meta` submodule.
- Rebuild the ACSF event/handler registry after installing modules (`acsf-build-registry`).
- Take a site offline/online for platform tasks (`go-offline` / `go-online` Drush commands).
- Fetch factory credentials for a site (`acsf-get-factory-creds`) and report the ACSF module version (`acsf-version-get`).
- Show editors an "ACSF site maintenance in progress" notice while a platform operation runs.
- Retrieve the last completed install task (`acsf-install-task-get`) for Factory install orchestration.
- Connect a local/dev site to a Factory for testing with `acsf-connect-factory`.
- Uninstall the ACSF codebase modifications from a repo with `acsf-uninstall`.
