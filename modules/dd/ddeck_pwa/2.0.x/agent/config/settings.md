<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DDECK PWA — settings, config object & permission

## Install / enable

Requires the **PWA** module (`pwa:pwa`) and core **SDC** (`drupal:sdc`) — both are listed in
`ddeck_pwa.info.yml` `dependencies`, so Drupal enables them with it. `composer.json` `require` is
empty; there is nothing to `composer require` beyond the module itself. Enable with
`drush en ddeck_pwa -y`. The theme is expected to provide **Bootstrap 6** utility classes.

## Route, form & permission

- Route `ddeck_pwa.settings` → path **`/admin/config/services/ddeck-pwa`**, `_form:
  \Drupal\ddeck_pwa\Form\SettingsForm`, title *"DDECK PWA"*, requirement
  `_permission: 'administer ddeck pwa'` (`ddeck_pwa.routing.yml`).
- Menu link `ddeck_pwa.settings` under `system.admin_config_services` (Configuration → Web services),
  weight 10 (`ddeck_pwa.links.menu.yml`).
- Permission **`administer ddeck pwa`** — *"Administer DDECK PWA"* (`ddeck_pwa.permissions.yml`). This
  is the only access gate the module adds and it protects only this settings form.

## The form — `src/Form/SettingsForm.php`

`SettingsForm extends ConfigFormBase`. `getFormId()` = `ddeck_pwa_settings_form`;
`getEditableConfigNames()` = `['ddeck_pwa.settings']`. Fields:

- A read-only `#markup` note that manifest / service worker / theme colors are managed by the PWA
  module, linking to route `pwa.config_manifest`.
- `apple_app_title` — textfield, default from config; help text says it falls back to the PWA
  application name when empty.
- `enable_navigation` — checkbox, default from config.

`submitForm()` saves `apple_app_title` (raw string) and `enable_navigation` (cast to bool) into
`ddeck_pwa.settings`, then calls `parent::submitForm()`.

## Config object `ddeck_pwa.settings`

Schema (`config/schema/ddeck_pwa.schema.yml`), type `config_object`:

| key | type | meaning |
|-----|------|---------|
| `apple_app_title` | `label` | Apple mobile web app title (iOS home-screen meta). |
| `enable_navigation` | `boolean` | Whether the bottom navigation bar is rendered. |

Install defaults (`config/install/ddeck_pwa.settings.yml`):

```yaml
apple_app_title: 'Market Activations Platform'
enable_navigation: true
```

## The `PwaContext` service — `src/PwaContext.php`

Service id `ddeck_pwa.context`, constructed with `@config.factory` (`ddeck_pwa.services.yml`).
`final class PwaContext`:

- `shouldShowNavigation(): bool` → `(bool) ddeck_pwa.settings.enable_navigation`. Consumed by
  `hook_preprocess_html()` to decide whether to attach the nav block.
- `getAppleAppTitle(): string` → returns `ddeck_pwa.settings.apple_app_title` if non-empty, else
  falls back to `configFactory->get('pwa.config')->get('name')` (the PWA module's app name).
- `getConfig()` (private) → the immutable `ddeck_pwa.settings`.

Both settings are trusted, admin-only config (gated by `administer ddeck pwa`); the values feed the
rendering hooks documented in [../theming/rendering.md](../theming/rendering.md).
