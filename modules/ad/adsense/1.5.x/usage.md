AdSense displays Google AdSense ad units on a Drupal site to earn revenue, offering managed (modern) content ads, auto/page-level ads, and custom-search ads, placed as blocks, inline filter tags, or automatically.

---

The module centres on your **AdSense publisher ID** (`ca-pub-…`), stored in `adsense.settings`
(`adsense_basic_id`) and read by `PublisherId::get()`. Ad units are **AdsenseAd plugins** (a plugin
type this module defines, manager `plugin.manager.adsensead`, discovered in `Plugin/AdsenseAd`): the
core module ships the `managed` content-ad plugin plus custom-search (`cse`, `csev2`), and the
`adsense_oldcode` submodule adds deprecated `oldcode`/`oldsearch` plugins. You surface ads three ways:
(1) **blocks** — `adsense_managed_ad_block` (choose ad slot, format such as `responsive`/`custom`
`WxH`/`in-article`, shape, alignment) and `adsense_cse_ad_block`; (2) an **input filter**
(`filter_adsense`) that turns `[adsense:format:slot]`, `[adsense:format:group:channel:slot]` or
`[adsense:block:machine_name]` tags in body text into ads; and (3) **auto ads** — page-level ads
enabled with `adsense_managed_page_level_ads_enabled`, injected in `hook_page_attachments()` with
optional path visibility. Global switches in `adsense.settings` let you disable all ads
(`adsense_disable`), run in test mode (`adsense_test_mode`), and show a placeholder box instead of
real ads (`adsense_placeholder` / `adsense_placeholder_text`) — extremely useful in development so no
live Google request is made. Settings forms live under `/admin/config/services/adsense` (main,
managed, custom-search), gated by the `administer adsense` permission; the `hide adsense` and
`show adsense placeholders` permissions control per-role display. Submodules add an auto-generated
`ads.txt` file (`adsense_adstxt`) and pre-2007 ad code support (`adsense_oldcode`).

---

- Show responsive Google AdSense content ads in a sidebar or content region via the managed ad block.
- Place a fixed-size ad unit (e.g. 300x250 Medium Rectangle) by choosing the "custom" format with width/height.
- Enable Google **Auto ads** (page-level ads) site-wide without placing individual units.
- Insert an ad inline in an article body with an `[adsense:responsive:1234567890]` filter tag.
- Reference a configured ad block from body text with `[adsense:block:my_ad_block]`.
- Add an in-article or in-feed fluid ad using the managed block's `in-article`/`in-feed` formats.
- Store your publisher ID once (`adsense_basic_id`) and reuse it across every ad unit.
- Develop safely with placeholder boxes instead of real ads (`adsense_placeholder: true`).
- Turn on test mode so ad requests are flagged as tests and don't count as impressions.
- Temporarily disable all ads site-wide with a single switch (`adsense_disable`).
- Hide ads for specific roles (e.g. editors, subscribers) via the `hide adsense` permission.
- Let trusted roles see ad placeholders during layout work via `show adsense placeholders`.
- Restrict auto ads to (or exclude them from) specific paths using the access-pages visibility config.
- Serve asynchronous ad code (recommended) or switch to synchronous/deferred loading.
- Add responsive ad "shape" hints (auto/horizontal/vertical/rectangle) on a managed responsive unit.
- Align an ad left/center/right within its block.
- Add a Google Custom Search ad unit and results page (CSE / CSE v2 blocks and routes).
- Provide a site-wide `ads.txt` at `/ads.txt` automatically from your publisher ID (adsense_adstxt submodule).
- Support legacy pre-2007 ad code and styles for old inventory (adsense_oldcode submodule).
- Define custom ad-unit plugins by implementing the `AdsenseAd` plugin type.
- Deploy ad configuration between environments as exported `adsense.settings` and block config.
- Monetise a high-traffic content site with minimal theming work.
- Roll out a matched-content (autorelaxed) unit at the end of articles.
- Use a layout key for an in-feed ad matching your listing design.
- Centralise ad channels/slots so marketing can update them without touching code.
