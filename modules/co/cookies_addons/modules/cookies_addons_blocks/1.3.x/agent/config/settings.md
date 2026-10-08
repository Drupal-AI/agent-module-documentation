<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Blocks — configuration & mechanism

## Enable

`drush en cookies_addons_blocks`. Requires COOKiES (`cookies`) with at least one enabled
`cookies_service` entity to use as the gate.

## Configure

Route `cookies_addons_blocks.settings` → `/admin/config/system/cookies-addons-blocks` (permission
`administer site configuration`; menu link under the COOKiES config group, parent `cookies.config`).
`SettingsForm` exposes one field:

- `blocks` (textarea, config `cookies_addons_blocks.settings:blocks`) — one entry per line, format
  `block_id|cookies_service_machine_name`. `block_id` is the block **config entity** id (e.g. the
  machine name of a placed block, as in `block.block.<id>`).

Config object `cookies_addons_blocks.settings` (schema: `blocks` type `text`). No install defaults.

## Runtime mechanism

1. `cookies_addons_blocks_preprocess_block(&$variables)` reads `$variables['elements']['#id']`. It
   calls `_cookies_addons_blocks_is_restricted($id)`, which returns FALSE on `POST`, otherwise splits
   the `blocks` config on newlines, `explode('|')` each line (skips lines whose part count ≠ 2), and
   returns the service string when `block_id` matches exactly.
2. When restricted, it loads enabled `cookies_service` entities to resolve the service label (falls
   back to the machine name), then replaces `$variables['content']` with an `html_tag` `div`
   carrying classes/attributes `cookies-addons-blocks-placeholder`, `data-cookies-service`,
   `data-service-name`, `data-block-id`, `id={#id}-content`, and attaches library
   `cookies_addons_blocks/cookies-addons-blocks`.
3. `js/cookies-addons-blocks.js` (`Drupal.behaviors.cookiesAddonsBlocks`) listens for
   `cookiesjsrUserConsent`. On accept → `activate()`: for each placeholder whose
   `data-cookies-service` equals the accepted service, it marks it `request-sent` and
   `Drupal.ajax({url:'/cookies-addons-blocks/get-block/{blockId}/{service}', type:'POST'})`. On deny
   → `fallback()` calls `$(placeholder).cookiesOverlay(service)`.
4. `CookiesAddonsBlocksController::getBlock()` loads the `block` entity via the entity type manager,
   renders it with `getViewBuilder('block')->view($block)`, and returns an `AjaxResponse` with a
   `ReplaceCommand($selector, $content)` where `$selector` includes the `data-cookies-service` and
   `data-block-id` attribute matchers. Throws `\Exception` if the block can't be loaded/built.

## Notes

- Gating happens in `preprocess_block`, so it applies to any placed block regardless of theme region.
- Because `_cookies_addons_blocks_is_restricted()` returns FALSE on POST, the AJAX re-render is not
  itself re-gated.
- The route uses core permission `access content`; the settings form uses `administer site
  configuration`.
