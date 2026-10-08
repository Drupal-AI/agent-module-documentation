# Configure Site Studio (credentials, theme, install behavior)

There is **no admin settings page in this module** (`configure` is null). Site Studio credentials live
in the `cohesion.settings` config object (owned by the `cohesion` module). This module only *populates*
that object and triggers the import/rebuild. Three surfaces set the keys:

| Surface | Where | What it writes |
|---|---|---|
| Site installer | `hook_form_install_configure_form_alter` adds an "Acquia Site Studio" fieldset (form id `acquia_cms_site_studio_site_installer_form`) | `cohesion.settings`: `api_url`, `api_key`, `organization_key` (only if both keys entered) |
| Acquia CMS Tour dashboard | `SiteStudioCoreForm` plugin (`@AcquiaCmsTour` id `cohesion`, form id `acquia_cms_site_studio_core_form`) | `cohesion.settings`: `api_key`, `organization_key` (the "Agency key" field maps to `organization_key`) |
| Cohesion's own page | route `cohesion.configuration.account_settings` (provided by `cohesion`, linked as "Advanced" from the Tour form) | `cohesion.settings` directly |

The installer and Tour fields pre-fill their default from the environment
(`getenv('SITESTUDIO_API_KEY')` / `getenv('SITESTUDIO_ORG_KEY')`) or the existing `cohesion.settings`
value, and both keys are stored as plain text in `cohesion.settings` — this is Cohesion's standard
storage model, not something this module encrypts or logs.

## On install (`hook_install`, `!$is_syncing`)

1. Installs and sets `cohesion_theme` as the default theme (`_acquia_cms_site_studio_set_theme`).
2. Applies `cohesion.settings` image-browser / dx8 defaults (`_acquia_cms_site_studio_update_settings`):
   `use_dx8 => 'enable'`, `sidebar_view_style => 'titles'`, and an IMCE/media-library `image_browser`.
3. If run standalone (not during profile install) and both `SITESTUDIO_API_KEY` + `SITESTUDIO_ORG_KEY`
   are present, writes them to `cohesion.settings` (`_acquia_cms_site_studio_set_credentials`) and, on
   CLI, runs Cohesion's initial import batch (`AdministrationController::batchAction(TRUE)`).
4. Rewrites `editor.editor.cohesion` and `filter.format.cohesion` from `config/optional`, and disables the
   `black_list_html_tags` filter on `filtered_html`.
5. Installs `node_revision_delete`, `responsive_preview`, `cohesion_style_guide`,
   `sitestudio_config_management`.
6. Grants `use text format <id>` (`cohesion`, `filtered_html`, `full_html`) to the `developer` role.

Uninstall (`hook_uninstall`) resets the `node.page` body field label/description to defaults.

## Setting keys with drush / PHP

The keys are plain `cohesion.settings` values, so any of these work:

```bash
ddev drush config:set cohesion.settings api_key 'xxx-xxx-xxx' -y
ddev drush config:set cohesion.settings organization_key 'yyy-yyy-yyy' -y
```

```php
\Drupal::configFactory()->getEditable('cohesion.settings')
  ->set('api_key', getenv('SITESTUDIO_API_KEY'))
  ->set('organization_key', getenv('SITESTUDIO_ORG_KEY'))
  ->save(TRUE);
```

Prefer supplying the values through the `SITESTUDIO_API_KEY` / `SITESTUDIO_ORG_KEY` environment
variables so they are not committed to exported config.

## Triggering import + rebuild

Saving `cohesion_account_settings_form`, `acquia_cms_site_studio_core_form`, or
`acquia_cms_tour_installation_wizard` runs `_acquia_cms_site_studio_init` **only when the keys were not
already set** (`hook_form_alter`). That helper runs Cohesion's element/asset import batch
(`_acquia_cms_site_studio_install_initialize`), imports the shipped UI-kit packages
(`_acquia_cms_site_studio_import_ui_kit` → `CohesionFacade::importSiteStudioPackages()`; skipped when the
`COHESION_ARTIFACT` env var is set, e.g. in CI), and re-applies the `cohesion.settings` defaults. See
[../api/site-studio-packages.md](../api/site-studio-packages.md).

## Config schema

This module ships **no** `config/schema/` and does not define `cohesion.settings` — that schema comes
from the `cohesion` module. It does ship `config/install/user.role.developer.yml` and the
`config/optional/*` editor/filter/block config.
