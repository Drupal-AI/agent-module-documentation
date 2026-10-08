<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Sharerich

## Button sets (config entity `sharerich`)
Manage at `/admin/structure/sharerich` (perm `administer sharerich`). Each set is a `sharerich` config entity (`config_prefix: set`, exported keys `id`, `label`, `services`). For every enabled service the set stores:
- `id`, `enabled` (bool), `weight` (int), and HTML `markup` (a `text` field) containing `[sharerich:*]` tokens and usually an inline SVG icon.

Default service markups ship as `.inc` files under the module's `services/` directory and are scanned by `sharerich_get_default_services()`; `sharerich_load_default_service()` loads a default on demand (the set form also exposes a hidden "default markup" field and a **Reset** button, wired in `js/sharerich.js`). Fifteen services ship: email, facebook, github, hackernews, instagram, linkedin, pinterest, pocket, print, reddit, tumblr, twitter, vk, whatsapp, youtube. Only email, facebook, tumblr and twitter are enabled in the default set. The `twitter` button renders as **X** (label and icon) but keeps the `twitter` machine name.

The add/edit form is `SharerichForm` (an `EntityForm`); delete is `SharerichDeleteForm`. On save it keeps only the schema keys (`id`, `enabled`, `weight`, `markup`) and sorts by weight.

## Global settings
`/admin/config/sharerich/settings` → `AdminSettingsForm` (a `ConfigFormBase`) writes `sharerich.settings`:
- `allowed_html` — space-separated list of tags permitted in button markup; parsed by `sharerich_allowed_tags()` and used as `#allowed_tags`. Default: `<a> <b> <br> <dd> <dl> <dt> <em> <i> <li> <ol> <p> <strong> <u> <ul> <span> <div> <path> <svg>`.
- `facebook_app_id`, `facebook_site_url`, `youtube_username`, `github_username`, `instagram_username`, `twitter_user` — surfaced as the matching settings-backed tokens.

## Tokens
Registered by `SharerichTokensHooks` (token type `sharerich`):
- `[sharerich:url]` — page URL, falls back through `[node:url]` → `[term:url]` → `[current-page:url]` → `[site:url]`, then `rawurlencode`d.
- `[sharerich:title]` — page title, same fallback chain against title/name, `PlainTextOutput`-flattened and `rawurlencode`d.
- `[sharerich:summary]` / `[sharerich:description]` — node summary → term description → current-page title → site slogan, `rawurlencode`d.
- `[sharerich:fb_app_id]`, `[sharerich:fb_site_url]`, `[sharerich:youtube_username]`, `[sharerich:github_username]`, `[sharerich:instagram_username]`, `[sharerich:twitter_user]` — from `sharerich.settings`, `Html::escape`d.

Route context for the page tokens comes from `_sharerich_get_token_data()`, which supplies the `node`, `taxonomy_term` or `user` of the canonical route (else no entity).

## Placement
Place the **Sharerich** block (`/admin/structure/block`, plugin id `sharerich`): choose a set (`sharerich_set`), `orientation` (horizontal/vertical) and `sticky` (only meaningful for vertical). On install the module auto-places one Sharerich block in the content region of the default theme, showing the `default` set, vertical and sticky.

Render pipeline in `SharerichBlock::build()`:
1. Load the chosen set; build one `#markup` element per service with `#allowed_tags = sharerich_allowed_tags()`.
2. `hook_sharerich_buttons_alter($buttons, $context)` (context = route entity data).
3. `\Drupal::token()->replace()` each button's markup.
4. Wrap in an `item_list`, then the `sharerich` theme hook (`templates/sharerich.html.twig`), attaching the `sharerich/sharerich` library. Wrapper classes carry the set name, orientation and sticky flag. Cache context `url.path`; the block merges the set's cache tags so saving a set invalidates only that block.

## Protocols and JavaScript
The `print` button uses a `javascript:window.print()` href and `whatsapp` uses a `whatsapp:` href — both protocols Drupal's filters strip. The module restores them on the client in `js/sharerich.js` (`restoreProtocol()` runs only on `.rrssb-print` / `.rrssb-whatsapp` links), so those two buttons work without changing the site's protocol filtering. They require JavaScript; with JS off the other buttons still work and these two do nothing. `js/sharerich.js` also opens `.popup` share links in a centred popup and handles vertical sticky positioning; it sets only the `href` attribute and never assigns page content to `innerHTML`.

## Diff 2.0.x → 3.0.x
Major release — note the behavioural and BC changes:
- **Print/WhatsApp protocols now handled client-side (BC).** 2.0.x registered the `javascript:`/`whatsapp:` schemes through a global `filter_protocols` container-parameter override so those buttons kept their hrefs server-side. 3.0.x drops that override — `sharerich.services.yml` declares no `parameters:` — and re-adds the two schemes per-link in `js/sharerich.js` instead. Consequence: the `print` and `whatsapp` buttons now **require JavaScript** to function; the other buttons are unaffected.
- **Google+ button removed.** Google+ closed in 2019; update hook `sharerich_update_8301()` drops `googleplus` from existing sets.
- **Twitter rebranded to X.** The `twitter` button now ships the X icon and an "X" label; the machine name stays `twitter` so existing config keeps working. `sharerich_update_8301()` swaps the old bird icon/label in place (leaving customised icons and hrefs alone).
- **Hooks moved to OOP.** Hook implementations now live in `src/Hook/SharerichHooks` and `src/Hook/SharerichTokensHooks` with `#[Hook]` attributes (D11 hook system), bridged by `#[LegacyHook]` thin wrappers in `sharerich.module`. The former procedural `sharerich.tokens.inc` is gone.
- **New token.** `[sharerich:description]` is registered alongside `[sharerich:summary]` (same value).
- **Token hardening.** Page tokens are consistently `rawurlencode`d (URL) or `PlainTextOutput`-flattened + `rawurlencode`d (title/summary/description); settings tokens are `Html::escape`d.
- **Block rendering fixes.** Orientation and sticky classes are now emitted on the wrapper the `sharerich` template renders (previously passed where core's template ignored them, so the settings had no effect). `getCacheTags()` merges the set's cache tags instead of invalidating `block_view` for every block on save.
- **Core support.** `core_version_requirement` moves from `^8 || ^9 || ^10 || ^11` to `^9 || ^10 || ^11 || ^12`.
- **No bundled library.** No third-party RRSSB library and no jQuery; layout is flexbox/CSS and the JS depends only on `core/drupal`, `core/drupalSettings`, `core/once`.
