<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — ajax_cart_update.settings

## Install / enable

```
composer require drupal/ajax_cart_update
drush en ajax_cart_update -y
```

Requires Views + Commerce Cart (info.yml deps: `views`, `commerce`, `commerce_cart`). No
permissions are defined by this module; the settings form uses core's
`administer site configuration`.

## The single config object

`config/install/ajax_cart_update.settings.yml`:

```yaml
update_method: selectors
```

Schema `config/schema/ajax_cart_update.schema.yml` — `ajax_cart_update.settings` is a
`config_object` with one mapping key:

- **`update_method`** (`string`) — constrained by `AllowedValues` to `selectors` or `endpoint`.

That is the only stored setting. There is no per-view or per-block config.

## Settings form

- Class `Drupal\ajax_cart_update\Form\AjaxCartUpdateSettingsForm` (`ConfigFormBase`),
  form id `ajax_cart_update_settings`, editable config `ajax_cart_update.settings`.
- Route `ajax_cart_update.settings` → `/admin/config/ajax-cart-update/settings`,
  `_permission: 'administer site configuration'`. A menu link is defined in
  `ajax_cart_update.links.menu.yml`.
- One field: `update_method` radios ("Use selectors from Views" / "Use AJAX endpoint for HTML"),
  bound with `#config_target => 'ajax_cart_update.settings:update_method'` (no custom submit).
- Note: the project ships **no** `configure` key in info.yml, so the module row on
  `/admin/modules` has no "Configure" shortcut — reach the form by its path/menu link.

## What update_method changes

`Hook\AjaxCartUpdateHooks::preprocessPage()` attaches, on `/cart`, `core/once` plus:

- `ajax_cart_update/ajax_cart_selectors` when `update_method` is `selectors` (default), or
- `ajax_cart_update/ajax_cart_endpoint` when `update_method` is `endpoint`.

`preprocessViewsView()` then writes `drupalSettings.ajaxCartUpdate` (keyed `form` / `block`) with
the CSS `selectors`, the `updateMethod`, and — only in `endpoint` mode — a `customEndpoints` map
pointing at `/ajax/cart/summary-html` and `/ajax/cart/prices`. Default value if config is unset:
`selectors` (`$config->get('update_method') ?: 'selectors'`). See
[../api/endpoints.md](../api/endpoints.md) for the runtime flow.

## Export example

```yaml
# ajax_cart_update.settings.yml
update_method: endpoint
```
