Webform Config Ignore registers a Config Filter that excludes webform and webform-options configuration from configuration import and export, so webforms edited in the live/active site are not overwritten by `drush config:import` (or captured by `config:export`).

---

The module implements a single `@ConfigFilter` plugin (`config_webform_ignore`, weight 100) provided through the required `config_filter` module. During any config sync operation, the filter intercepts config names beginning with `webform.webform.` (webform entities) and `webform.webform_options.` (reusable options lists). For those names it reads from the site's active configuration storage instead of the sync/export storage, so import leaves existing webforms untouched and export omits them. New webforms that exist only in the sync directory are still importable, because the filter falls back to the incoming data when no active version exists. There is no admin UI, no config object (`webform_config_ignore.settings` does not exist), no permissions, and no Drush commands — behavior is entirely automatic once the module is enabled. The only tunable is a settings.php kill-switch: `$settings['webform_config_ignore_disabled'] = TRUE;` disables the filter entirely (useful on development environments where you *do* want webforms to sync). The filter operates across all config collections (e.g. language overrides), not just the default collection.

---

- Prevent `drush config:import` from reverting webforms that content editors changed on production.
- Let non-technical editors build and tweak webforms in production without a developer deploying each change.
- Keep webform submission handlers, emails, and confirmation settings that live on the production site out of the deployment pipeline.
- Exclude reusable webform options lists (`webform.webform_options.*`) from config sync so editors can maintain dropdown/checkbox option sets freely.
- Stop `drush config:export` from writing webform config into the sync directory / Git repo, keeping VCS free of editor-managed form churn.
- Avoid config-import conflicts when the same webform diverges between environments.
- Deploy code and structural config changes while treating webforms as content-like, environment-specific data.
- Still allow importing brand-new webforms that only exist in the sync directory (fallback-to-incoming behavior).
- Disable the filter on a dev/staging box via `$settings['webform_config_ignore_disabled'] = TRUE;` so you can pull production webforms down for testing.
- Re-enable webform syncing temporarily to migrate a specific webform between environments (toggle the settings flag, sync, toggle back).
- Protect webforms during a full site config import as part of a CI/CD deploy job.
- Coexist with the config_ignore module: use config_filter-based ignoring specifically scoped to webforms.
- Keep GDPR/data-collection form definitions managed by site staff rather than by developers.
- Ensure webform edits made through the admin UI survive automated nightly config imports.
- Avoid accidental deletion of a production webform when it is absent from the sync directory (the filter reports it as existing via active storage).
- Combine with a normal config workflow: everything except webforms is deployed the usual way.
- Support multilingual sites — webform config in language collections is also ignored.
- Use as a lightweight alternative to hand-maintaining `config_ignore` patterns for the common "ignore all webforms" case.
