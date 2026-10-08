<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# adopt_io — configuration & script attachment

## Install / enable
`composer require drupal/adopt_io` then `drush en adopt_io`. No dependencies, no composer requirements, no libraries. Core `^8 || ^9 || ^10 || ^11`.

## Configuration
- **Route/form**: `adopt_io.configure` → `/admin/config/services/adopt_io`, title "Adopt.io Integration Settings", form `\Drupal\adopt_io\Form\AdoptIoSettingsForm`.
- **Config object**: `adopt_io.settings`, single key `adopt_io_website_code` (string). No `config/install` default (key is `null`/absent until first save) and no `config/schema` file ships, so the value is untyped in config.
- **Form** (`AdoptIoSettingsForm`): `getEditableConfigNames()` → `['adopt_io.settings']`; form id `adopt_io_settings_form`; one `#type => textfield` `adopt_io_website_code` ("Adopt.io Website Code"). `submitForm()` saves the submitted value with `->set('adopt_io_website_code', $values['adopt_io_website_code'])->save()`. Extends `ConfigFormBase` (adds the standard Save configuration button and cache invalidation).
- Get the website code from GoAdOpt (https://goadopt.io/).

### Route permission caveat (operational, not a bug you fix in config)
`adopt_io.routing.yml` gates the settings route with `_permission: 'administer recurring paypal donations'` — a permission string this module does **not** define (leftover from the project the code was copied from; the menu link key is likewise `ows_recurring_donation.configure` in `adopt_io.links.menu.yml`). Because no module declares that permission, no role is granted it, so in practice only **user 1** (who bypasses access checks) can open `/admin/config/services/adopt_io`. If a non-uid-1 admin needs access, the route requirement must be patched to a real permission such as `administer site configuration`.

## What it does at runtime
`adopt_io_page_attachments_alter(array &$attachments)` (`adopt_io.module`, implements `hook_page_attachments_alter()`):
1. Reads `\Drupal::config('adopt_io.settings')->get('adopt_io_website_code')`.
2. If empty → returns without attaching anything (banner off).
3. If non-empty → appends to `$attachments['#attached']['html_head']` a render array:
   - `#type => 'html_tag'`, `#tag => 'script'`,
   - `#attributes => ['src' => '//tag.goadopt.io/injector.js?website_code=' . $website_code, 'class' => 'adopt-injector']`,
   - keyed `'adopt_io_injector'`.

The GoAdOpt `injector.js` (protocol-relative, from `tag.goadopt.io`) then renders and manages the consent/CMP banner in the browser. The module makes **no** server-side HTTP call to GoAdOpt and stores no secret — the website code is a public site identifier that appears in the emitted page HTML for every visitor.

## Uninstall / turn off
Clear the website code (empty value emits no script) or uninstall the module. Uninstalling removes `adopt_io.settings`.

## Not provided
No permissions.yml, services.yml, config schema, install hooks, entities, plugins, blocks, drush commands, tests, or submodules. `adopt_io.module` contains only the one page-attachment hook.
