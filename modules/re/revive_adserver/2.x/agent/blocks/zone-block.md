<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revive Adserver Zone Block

`src/Plugin/Block/ReviveAdserverZoneBlock.php` — `@Block(id = "revive_adserver_zone_block",
admin_label = "Revive Adserver Zone Block")`, extends `BlockBase`, injects
`plugin.manager.revive_adserver.invocation_method_service`.

## Placing it

*Structure → Block layout → Place block* → "Revive Adserver Zone Block" into a region (needs core
`block` UI, `administer blocks`). Config schema `block.settings.revive_adserver_zone_block`.

## Block config form (`blockForm()`)

| Field | Element | Notes |
|---|---|---|
| `zone_id` | `number`, `#required` | Becomes a **`select`** of synced zones (`getZonesOptionList()`) when zones exist; otherwise a numeric input. |
| `invocation_method` | `select`, `#required` | Options from `getInvocationMethodOptionList()`; default `async_javascript`. |
| `block_banner` | checkbox | Only visible for async/JS methods (`#states`). "Do not show the banner again on the same page." |
| `block_banner_campaign` | checkbox | Same visibility. "Do not show a banner from the same campaign again on the same page." |

`blockSubmit()` saves those four values into block config.

## Render (`build()`)

1. Reads `invocation_method` from config; if empty, falls back to
   `$this->invocationMethodManager->getGlobalDefaultInvocationMethod()`.
2. `loadInvocationMethodFromInput($method)` → the plugin.
3. `setZoneId($config['zone_id'])`, `setBlockBanner(...)`, `setBlockBannerCampaign(...)`,
   `prepare()`, then returns `render()`.

**Caveat (bug):** `getGlobalDefaultInvocationMethod()` is **not defined** on
`InvocationMethodServiceManager`, so the empty-method fallback path would fatal. In practice
`invocation_method` is `#required` with a default, so a saved block always has a method and the
fallback branch isn't hit — but a block whose config somehow has an empty method (e.g. hand-built
config) would error. Always set the invocation method.
