<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & script attachment — cookie_script

## Install / enable

```
composer require drupal/cookie_script
drush en cookie_script -y
```

No dependencies beyond Drupal core (`core_version_requirement: ^8 || ^9 || ^10 || ^11`). No
submodules. No libraries. `package: User interface`.

## Configure

1. Get a Cookie-Script account/domain **ID** from https://cookie-script.com/ (all banner text,
   cookie categories and blocking rules are configured in the Cookie-Script dashboard, not Drupal).
2. Visit **`/admin/config/cookie_script`** (menu: *Configuration › System › Cookie Script
   integration*).
3. Enter the ID in the required **ID** text field and save.

### Config object

- **`cookie_script.settings`** — single key **`id`** (string). No `config/install` default file and
  no `config/schema/*.yml` ships, so the value has no typed-config schema. Set it via the form or
  Drush:

```
drush config-set cookie_script.settings id YOUR_ID -y
drush config-get cookie_script.settings id
```

Clearing `id` (empty) suppresses the script entirely — the library is only built when `id` is
non-empty.

## Route & access

- Route id **`cookie_script.settings`**, path `/admin/config/cookie_script`, form
  `Drupal\cookie_script\Form\CookieScriptSettingsForm` (`cookie_script.routing.yml`).
- Requires permission **`administer cookie_script settings`** — defined in
  `cookie_script.permissions.yml` with `restrict access: true` (treat as a trusted-admin
  permission; site-wide script injection follows from it). `configure: cookie_script.settings` is
  declared in `cookie_script.info.yml`, so it appears on the module list's *Configure* link.
- Menu link defined in `cookie_script.links.menu.yml`, parent `system.admin_config_system`.

## The settings form

`src/Form/CookieScriptSettingsForm.php` — `CookieScriptSettingsForm extends ConfigFormBase`:

- `getFormId()` → `cookie_script_settings`.
- `getEditableConfigNames()` → `['cookie_script.settings']`.
- `buildForm()` adds one required `#type => textfield` element `id`, defaulting to the stored value.
- `submitForm()` writes `$form_state->getValue('id')` to `cookie_script.settings:id` and saves,
  then calls `parent::submitForm()`.

## How the script reaches the page

In `cookie_script.module`:

- `hook_library_info_build()` reads `cookie_script.settings:id`; if non-empty it registers a
  dynamic asset library **`cookie_script/base`** (version `1.x`) with one external JS asset keyed
  `//cdn.cookie-script.com/s/<id>.js` (`type: external`, `minified: true`). The host is fixed to
  `cdn.cookie-script.com`; only the `<id>` path segment comes from config. If `id` is empty, no
  library is built and nothing is attached.
- `hook_preprocess_page()` attaches `cookie_script/base` via
  `$variables['#attached']['library'][]`, so the loader is added to **every** rendered page.

Because it is a `hook_library_info_build()` result, changing the ID may require a library/cache
rebuild (`drush cr`) to take effect. The external URL is protocol-relative (`//…`), inheriting the
page's HTTP/HTTPS scheme.

## Operate

- Enable when you need the banner; **uninstall** or **clear `id`** to remove it site-wide.
- Compliance note (operational, not a bug): the banner only helps meet cookie law if the scripts
  that set cookies are actually blocked until consent — configure that blocking in the
  Cookie-Script dashboard, and disclose the third-party consent service in your privacy notice.
