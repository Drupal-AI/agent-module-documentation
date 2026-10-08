<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch base: dashboard, permissions & content settings

## Install & enable

```bash
composer require drupal/arch
drush en arch -y
```

Pulls in `arch_product` + `arch_order` (and their deps `arch_price`, etc.), plus contrib
`address` and `currency`. Requires PHP `ext-bcmath`, `ext-intl`, `ext-json`.

## Permission & admin menu

- Single permission **`administer store`** (`restrict access: true`) — gates the dashboard and
  most store settings pages.
- `arch.links.menu.yml` adds the top-level **Store** menu item (`arch.store`, under
  `system.admin`) with children *Dashboard* and *Settings*; submodules attach their own settings
  under `arch.settings`.

## Routes (`arch.routing.yml`)

| Route | Path | Handler | Requires |
|---|---|---|---|
| `arch.dashboard` | `/admin/store` | `DashboardController::dashboard` | `administer store` |
| `arch.settings` | `/admin/store/settings` | `SystemController::systemAdminMenuBlockPage` | `administer store` |
| `arch.content.settings` | `/admin/store/settings/contents` | `StoreContentSettingsForm` | `administer store` |

## Dashboard rendering — `DashboardController`

`dashboard()` returns two sections: `buildTasks()` (from `hook_arch_tasks()`, each item a
`#type => link`) and `buildPanels()` (every `store_dashboard_panel` plugin's `build()`, wrapped in
`arch-dashboard-panel--<name>` containers). Cache contexts: `user.permissions`,
`languages:language_interface`, `theme`. Alter hooks fired: `arch_dashboard`, `arch_tasks`,
`arch_dashboard_panels`, plus `hook_arch_dashboard_page_alter(&$build)` (see `arch.api.php`).
`AdminRouteSubscriber` is registered but its `alterRoutes()` is currently a no-op.

## Store content settings — `StoreContentSettingsForm`

Route `/admin/store/settings/contents`. Values are stored **not** in a config object but in the
**`arch.content_settings` key/value collection** (`\Drupal::keyValue('arch.content_settings')`):

- `mode` — one of `_none`, `TC`, `PP`, `TCPP` (which acceptance links to show on checkout).
- `nodes.tc` — node id of the Terms & Conditions page (entity_autocomplete).
- `nodes.pp` — node id of the Privacy Policy page.

`validateForm()` rejects unpublished nodes; `submitForm()` nulls the tc/pp node ids not relevant
to the chosen mode. `_arch_content_settings()` (in `arch.module`) resolves these to published,
language-correct nodes and degrades `mode` gracefully if a required node is missing/unpublished.

### Checkout acceptance line

`arch_theme()` registers the `arch_terms_of_use` theme hook.
`arch_theme_suggestions_arch_terms_of_use()` adds a `arch_terms_of_use__<mode>` suggestion.
`template_preprocess_arch_terms_of_use()` builds an inline-template "I accept the {{ tc_link }}
and the {{ pp_link }}" (variants per mode) with the T&C / Privacy nodes rendered as links.

## Admin-theme toggle

`arch_form_system_themes_admin_form_alter()` adds a checkbox *"Use the administration theme when
administrating store"* to `admin/appearance`; its submit handler writes
`node.settings:use_admin_theme` and rebuilds routes. Install default
`arch.settings:use_admin_theme = true` (`config/install/arch.settings.yml`) — note this config
object is only the seed value; the live toggle reads/writes `node.settings`.

## Toolbar / assets

`arch.libraries.yml` defines `dashboard`, `toolbar`, `toolbar_themes.seven.icons`,
`toolbar_themes.admin_menu.icons` (CSS) and a bundled **Underscore.js 1.13.6**
(`underscorejs`). `arch_library_info_alter()` swaps in core's own
`/core/assets/vendor/underscore/underscore-min.js` when it exists; `arch_toolbar_alter()` attaches
the `arch/toolbar` library.
