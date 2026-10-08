<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Blocks (cookies_addons_blocks) — agent index

Submodule of **Cookies Addons**. Gates **placed Drupal blocks** (by block config-entity ID) behind a
COOKiES consent service. Package COOKiES. Core `^9.2 || ^10 || ^11`. Depends on `cookies:cookies`.
License GPL-2.0-or-later. Version 1.3.3.

- **Config, route, hook and mechanism** → [config/settings.md](config/settings.md)

## What it provides

- Hook `cookies_addons_blocks_preprocess_block()` (`cookies_addons_blocks.module`) — swaps a
  restricted block's `#content` for a placeholder `<div>` and attaches the JS library. Helper
  `_cookies_addons_blocks_is_restricted($block_id)` parses `cookies_addons_blocks.settings:blocks`
  (`preg_split` on newlines, `explode('|')`, exact `block_id` match) and returns the service or FALSE;
  returns FALSE on POST requests.
- Controller `CookiesAddonsBlocksController::getBlock($block_id, $service)`
  (`src/Controller/CookiesAddonsBlocksController.php`) — loads the `block` entity, renders it with the
  `block` view builder, returns an `AjaxResponse` with a `ReplaceCommand` targeting
  `.cookies-addons-blocks-placeholder[data-cookies-service][data-block-id]`.
- Form `SettingsForm` (`src/Form/SettingsForm.php`) — one textarea `blocks`, writes
  `cookies_addons_blocks.settings`.
- Routes: `cookies_addons_blocks.get_block` (POST, `access content`);
  `cookies_addons_blocks.settings` (`administer site configuration`).
- Config schema `cookies_addons_blocks.settings` (`blocks: text`). Library
  `cookies_addons_blocks/cookies-addons-blocks` (`js/cookies-addons-blocks.js`, deps
  `cookies/cookies.lib`, `core/drupal.ajax`). Menu/task links under the COOKiES config group.
- No permissions, services, plugins, Drush.

Privacy/consent gate, not access control.
