<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sharerich (sharerich) — agent index

**Configurable responsive social-share button sets (RRSSB class names) rendered as a block, with `[sharerich:*]` token substitution. No bundled JS library, no jQuery.**

- **Version:** 3.0.x  •  core `^9 || ^10 || ^11 || ^12`  •  package Sharing  •  deps: token, block
- **Config entity:** `sharerich` (button sets), `config_prefix: set`, `admin_permission: administer sharerich`. Exports `id`, `label`, `services`.
- **Routes:** `sharerich.admin_settings_form` (`/admin/config/sharerich/settings`), `entity.sharerich.collection` (`/admin/structure/sharerich`) + add/edit/canonical/delete — every route gated by the restricted `administer sharerich` permission.
- **Block:** `sharerich` plugin (pick a set, `orientation` horizontal/vertical, `sticky`). Placed automatically in the content region on install.
- **Hooks:** implemented OOP under `src/Hook/` with `#[Hook]` attributes (`SharerichHooks`: help/theme/block_view_alter/sharerich_buttons_alter; `SharerichTokensHooks`: token_info/tokens), bridged by `#[LegacyHook]` wrappers in `sharerich.module`.
- **Alter hook:** `hook_sharerich_buttons_alter(&$buttons, $context)` — see `sharerich.api.php`.
- **Tokens:** `[sharerich:url]`, `[sharerich:title]`, `[sharerich:summary]`, `[sharerich:description]`, plus settings-backed `[sharerich:fb_app_id]`, `[sharerich:fb_site_url]`, `[sharerich:youtube_username]`, `[sharerich:github_username]`, `[sharerich:instagram_username]`, `[sharerich:twitter_user]`.
- **Rendering:** each service's stored `markup` becomes a `#markup` render element with `#allowed_tags` from the admin `allowed_html` setting; buttons are altered, then tokens are replaced. Page tokens (`url`/`title`/`summary`/`description`) are `rawurlencode`d; settings tokens are `Html::escape`d.
- **Protocols:** the `print` (`javascript:`) and `whatsapp` (`whatsapp:`) buttons need protocols that Drupal filters strip; the module restores them client-side in `js/sharerich.js` (per-link, on `.rrssb-print`/`.rrssb-whatsapp`) rather than altering site-wide filtering. Those two buttons therefore require JavaScript.

See [configure/sets.md](configure/sets.md) for the config model, tokens and block placement, and the "Diff 2.0.x → 3.0.x" section for the major-release changes.
