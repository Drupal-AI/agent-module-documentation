<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Sharerich

## Button sets (config entity `sharerich`)
Manage at `/admin/structure/sharerich` (perm `administer sharerich`). Each set (`id`, `label`, `services`) stores per-service:
- `enabled`, `weight`, `id`, and raw HTML `markup` containing `[sharerich:*]` tokens.

Default service markups ship as `.inc` files under the module's `services/` dir (scanned by `sharerich_get_default_services()`). Available tokens include `[sharerich:url]`, `[sharerich:title]`, `[sharerich:summary]`, `[sharerich:twitter_user]`, `[sharerich:fb_app_id]`, `[sharerich:fb_site_url]`.

## Global settings
`/admin/config/sharerich/settings` (`sharerich.settings`): `allowed_html` (tags permitted in button markup, used as `#allowed_tags`), `facebook_app_id`, `facebook_site_url`, `youtube_username`, `github_username`, `instagram_username`, `twitter_user`.

## Placement
Place the **Sharerich** block (`/admin/structure/block`), choose a set, orientation (horizontal/vertical) and sticky. Rendering: markup → `#allowed_tags` filter → `hook_sharerich_buttons_alter($buttons, $context)` → token replace with route context (node/term/user).
