# Configure & connect (ACSF platform only)

**This module is Acquia-ACSF-only.** Nearly everything below assumes the site runs on Acquia
Cloud Site Factory. There is **no admin config form** (`configure` route = null) and **no
permissions**. Setup is done by the platform and by a standalone Drush script, not through the UI.

## `acsf-init` — codebase patching (standalone, not a module)

`acsf_init` is **not** an enableable Drupal module; it is a self-contained Drush command run
against the codebase (works even with no database / a broken site). Run it once, and again after
**every** ACSF module update:

```
drush --include=<PATH-TO-MODULE>/acsf_init acsf-init      # patch the codebase (-y to overwrite)
drush --include=<PATH-TO-MODULE>/acsf_init acsf-init-verify  # verify; ACSF blocks deploys if this fails
```

It takes over `sites.php` so early bootstrap points each request at the correct site database +
`settings.php`, and installs Cloud Hooks (`post-db-copy`, `pre-web-activate`) and `.htaccess`
patches. Under BLT this is usually wrapped by `blt recipes:acsf:init:all`.
Connect a non-production site to a Factory for testing with `acsf-connect-factory`.

## `acsf.settings` config object

Written/managed by the platform (schema in `config/schema/acsf.schema.yml`), not by an admin form:

| Key | Default | Meaning |
|---|---|---|
| `maintenance_time` | `0` | Expected end time of a platform maintenance window; drives the "ACSF site maintenance in progress" notice on the maintenance-mode form |
| `site_owner_maintenance_mode` | `FALSE` | Site-owner maintenance flag |
| `local_user_accounts` | `FALSE` | Whether local (non-SSO) logins are allowed |

## Site identity

The site's Factory identity comes from `$GLOBALS['gardens_site_settings']['conf']['acsf_site_id']`
(set in the platform's `sites.json`), mirrored locally by `AcsfSite` and refreshed daily by
`hook_cron()`. See [api/acsf.md](../api/acsf.md).

## Submodules (shipped in this project, one shared `src/`)

- **Required by `acsf`**: `acsf_theme` (VCS/git-based theme handling), `acsf_variables`
  (single scrubbable store for sensitive variables). Do not uninstall on a live ACSF site.
- **`acsf_duplication`** (required suite member): the site-duplication scrub handlers.
- **Optional**: `acsf_sso` (Management Console SAML login; has its own `samlauth` dependency —
  `composer require drupal/acsf_sso`), `acsf_sj` (Scheduled Jobs), `acsf_meta` (meta tags).
