# Varbase Core — hooks & install behavior

All hooks live in `src/Hook/VarbaseCoreHooks.php` (OOP `#[Hook(...)]` attributes), plus
`varbase_core.install`. These matter to integrators because they change other modules' config,
forms, tokens, and usernames.

## Install (`hook_install`)

`varbase_core_install()` does the heavy lifting of the "glue" module:

1. `ModuleInstallerFactory::installList('varbase_core')` — enables every module in the info.yml
   `install:` list (~60 modules: eca + eca_* set, ds/ds_extras, ultimate_cron, content_lock,
   entityqueue, rabbit_hole, project_browser, etc.).
2. Bulk-imports `config/optional/**` by regex scan (`ModuleInstallerFactory::importConfigsFromScanedDirectory`):
   `block_content.type.*`, `field.storage.*`, `field.field.*`, `core.entity_form_display.*`,
   `core.entity_view_display.*`, then anything matching `*settings.yml`.
3. Runs `EntityDefinitionUpdateManager::applyUpdates()`, clears plugin/block caches.
4. `ModuleInstallerFactory::addPermissions('varbase_core')` — applies the role grants in
   `config/permissions/` (see [permissions](../permissions/permissions.md)).
5. Rebuilds ECA subscribed events (`eca` storage `rebuildSubscribedEvents()`) if ECA is present.
6. `drupal_flush_all_caches()`.

## `hook_modules_installed` — deferred "managed" config

`modulesInstalled($modules, $is_syncing)` watches for optional modules being enabled later and
imports matching config from `config/managed/`:

| When enabled | Imports from `config/managed/` | Extra |
|---|---|---|
| `automated_cron` | `automated_cron.settings` | + `EntityDefinitionUpdateManager::applyUpdates()` |
| `editoria11y` | `editoria11y.settings` (recipe) | + `ModuleInstallerFactory::addPermissions('varbase_core', 'config/managed/editoria11y/permissions')` |
| `sitewide_alert` | `sitewide_alert.settings` | — |
| `varbase_email` | 6 ECA/modeler configs: `eca.eca.user_login`, `admin_change_role_notification`, `user_recertification` (+ their `modeler_api.data_model.*`) | — |

Import uses `ModuleInstallerFactory::importConfigsFromList(...)`. So enabling any of these modules
on a Varbase site silently pulls in Varbase's opinionated defaults for them.

## Form alters

- `#[Hook('form_node_form_alter')]` — reorders node-edit sidebar groups by `#weight` (author,
  comments, path, meta tags, simple_sitemap, DS switch view mode).
- `#[Hook('form_alter')]` — on entity subqueue forms (`base_form_id == 'entity_subqueue_form'`),
  hides the per-item **delete** checkbox (`['form']['delete']['#access'] = FALSE`).

## Username handling

`#[Hook('email_registration_name_alter')]` — when `varbase_core.general_settings:allow_custom_account_name`
is on (default), overrides the generated username with `email_registration_unique_username()` of the
account's chosen name. Turning that setting off leaves email_registration's default naming intact.

## Preprocess

`#[Hook('template_preprocess_default_variables_alter')]` — exposes
`$variables['user_settings_register_admin_only']` (1 when `user.settings:register == 'admin_only'`).

## Provided tokens (`hook_token_info` / `hook_tokens`)

| Token | Value |
|---|---|
| `[site:origin-url]` | `$request->getSchemeAndHttpHost() . $request->getBaseUrl()` — site origin (scheme + host, no language prefix). Adds cache context `url.site`. |
| `[default-active-theme:path]` | Path of the current active theme (`themeManager->getActiveTheme()->getPath()`). |
