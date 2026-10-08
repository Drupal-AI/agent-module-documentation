<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Release Version — configuration, service, block & alter

Grounded in `web/modules/contrib/release_version/`. Everything the module does hangs off one config
key and one service.

## Install / enable

- `drush en release_version -y`. Requires core **`toolbar`** (`dependencies: - drupal:toolbar` in
  `release_version.info.yml`). Core `^8.8 || ^9 || ^10 || ^11`. No composer requirements (no
  `composer.json` ships), no external libraries.
- The value comes from an **environment variable** you set outside Drupal (deploy script, web-server
  config, `.ddev/.env`, container env, etc.). The module does not compute or write it.

## Configuration

- Config object: **`release_version.settings`**, single key **`environment_variable_name`** (string,
  maxlength 64). No `config/schema/*` and no `config/install/*` ship — the key is written directly by
  the form and read directly by the service, so it starts unset until you save the form (or import it
  in your own config).
- Settings form: `src/Form/ReleaseVersionSettings.php` (`ReleaseVersionSettings extends ConfigFormBase`,
  form id `release_version_settings_form`). One textfield `environment_variable_name`; `submitForm()`
  saves it to `release_version.settings`.
- Example config export (`config/sync/release_version.settings.yml`):

```yaml
environment_variable_name: CI_COMMIT_TAG
```

## Route & permissions

- Route **`release_version.settings_form`** → path **`/admin/config/release_version/settings`**
  (`release_version.routing.yml`), `_form: \Drupal\release_version\Form\ReleaseVersionSettings`,
  `options._admin_route: TRUE`.
- Requirement: `_permission: 'access administration pages, access_release_version_settings'` — the
  comma means the user needs **both** core `access administration pages` **and** the module's
  `access_release_version_settings` permission (`release_version.permissions.yml`, title *Access
  Release Version config*).
- Menu link under Configuration → System (`parent: system.admin_config_system`, weight 99) via
  `release_version.links.menu.yml`.
- `configure: release_version.settings_form` in the info file wires the "Configure" link on the
  Extend page.

## The provider service (the core logic)

- Service id **`release_version.provider`** → `Drupal\release_version\ReleaseVersionProvider`,
  args `['@config.factory', '@module_handler']` (`release_version.services.yml`).
- `getVersion(): string` (`src/ReleaseVersionProvider.php`):
  1. `$key = config('release_version.settings')->get('environment_variable_name')`.
  2. If `$key` is set and `getenv($key)` is truthy → returns `(string) getenv($key)`; otherwise
     returns the translated string **`"Version not found"`**.
  3. Runs `moduleHandler->alter('release_version', $version)` then returns the (possibly altered)
     value.
- Only reads a named environment variable — it does not run shell commands, read files, or query the
  database.

## Display surfaces

- **Toolbar** — `hook_toolbar()` in `release_version.module` adds item `version` as a `toolbar_item`
  whose tab is an `html_tag` `div` (classes `toolbar-icon toolbar-icon-help`, wrapper id
  `toolbar-tab-version`) with `#value` = `getVersion()`. Cache context **`user.permissions`**. Visible
  wherever core's toolbar is (users with core `access toolbar`).
- **Block** — plugin `release_version_version` (`src/Plugin/Block/VersionBlock.php`, admin label
  *Version*, category *System*). `build()` returns `['content' => ['#theme' => 'release_version_block',
  '#version' => $provider->getVersion()]]`. Place it via Block layout / Layout Builder like any block.
- **Theme** — `hook_theme()` registers `release_version_block`; template
  `templates/release-version-block.html.twig` is just `{{ version }}` (Twig auto-escaped).

## Extending via the alter hook

`getVersion()` invokes `hook_release_version_alter(&$version)`. Implement it to transform the string
before it is displayed:

```php
/**
 * Implements hook_release_version_alter().
 */
function mymodule_release_version_alter(&$version): void {
  // e.g. prefix the environment and shorten a commit SHA.
  $version = 'prod-' . substr($version, 0, 7);
}
```

## Operate / verify

- Set the env var (e.g. `export CI_COMMIT_TAG=1.4.2`) so PHP-FPM/CLI sees it, save the variable name
  on the settings form, then reload a page with the toolbar — the value appears in the toolbar tab.
- If it shows **"Version not found"**: the configured key is empty, or `getenv()` returns nothing in
  the PHP process serving requests (a common gotcha — the var must be exported into the web SAPI, not
  only your shell). Clear cache after changing config (`drush cr`).
