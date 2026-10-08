<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_store_filter — agent start

Storefront **store switcher** for multi-store Drupal Commerce. Registers a
`commerce_store.store_resolver` (priority **100**) that makes the user's chosen store the
Commerce **current store** (driving pricing, availability, tax), and exposes that store id as a
**Views contextual-filter default** so cart/order views can be scoped to it. Not an
access-control boundary — Commerce store/permission access is unchanged. Depends on
`commerce`, `commerce_store`; core `^10 || ^11`. Version **2.0.3**. (composer.json says
`drupal/commerce:^3`; info.yml requires only the Commerce sub-modules.)

## How it works

- **Current-store state** — `CommerceStoreFilterStoreService` (`src/CommerceStoreFilterStoreService.php`)
  keeps the selected store id in the **private tempstore** collection `commerce_store_filter`, key
  `commerce_store_filter_store` (per-user/session). `setCommerceStore(int $id)` writes it **only if**
  `$id` is a key of `entityTypeManager->getStorage('commerce_store')->loadMultiple()` (all stores,
  no access filter) and then flashes the configured `store_set_message`. `getCommerceStore()` returns
  the stored store if still valid, else `loadDefault()`.
- **Store resolver** — `src/Resolver/StoreFilterResolver.php`, service
  `commerce_store_filter.store_change`, tagged `commerce_store.store_resolver` **priority 100** (wins
  over Commerce's defaults). `resolve()` reads the `?commerce_store_filter=<id>` query param, calls
  `setCommerceStore($id)`, removes the param, and returns the service's current store. So a bare link
  `/?commerce_store_filter=2` switches the visitor's store.
- **Switch block** — `src/Plugin/Block/StoreSwitch.php`, block id `commerce_store_filter_block`
  ("Commerce Store Switch"), `getCacheMaxAge()` = 0. Renders `StoreSelectForm`. Block settings:
  `display_store_label`, `display_store_currency`, `auto_submit_store` (validation requires at least
  one of label/currency).
- **Select form** — `src/Form/StoreSelectForm.php` (id `commerce_store_select_form`). Builds the
  dropdown from a **raw DB query** on `commerce_store_field_data` (`store_id`, `name`,
  `default_currency`); option label is `name (currency)` / `name` / `currency` per block settings.
  With `auto_submit_store` on it attaches library `commerce_store_filter/auto-submit`
  (`js/auto-submit.js`) which, on change, reloads the page with `?commerce_store_filter=<id>` (client
  redirect — the real switch happens in the resolver); otherwise a **Switch** button calls
  `setCommerceStore()` on submit.
- **Views default argument** — `src/Plugin/views/argument_default/StoreFilter.php`, id
  `commerce_store_filter` ("Store filter"). `getArgument()` returns the current store id; cache
  max-age `PERMANENT`, context `['url']`. Use it as the default for a store-id contextual filter on
  cart / order-summary views.

## Config & routes

- Settings form `CommerceStoreFilterSettingsForm` (config `commerce_store_filter.settings`, single key
  `store_set_message`, default `'Store has been switched successfully!'`). Route
  `commerce_store_filter.settings_form` → `/admin/commerce/commerce_store_filter/config`, permission
  **`administer commerce store filter configuration`**, `_admin_route`. Menu link "Commerce Store
  Filter Settings" under Configuration → System.
- Permission defined in `commerce_store_filter.permissions.yml`.

## Notes / rough edges

- It is a **display/context switch**: it changes which store's catalog and prices are the current
  ones. Which stores a user may access is governed by Commerce's own store/permission access, which
  this module leaves unchanged.
- The commented-out `//not works...` in `js/auto-submit.js` is dead code; the working path is the URL
  reload. `CommerceStoreFilterStoreService` imports `Price`/`Html` it never uses.

Single-doc module — no subdocs. usage.md and human-docs/ cover install/placement for humans.
