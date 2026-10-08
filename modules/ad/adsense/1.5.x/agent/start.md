# AdSense — agent index

Displays Google AdSense ad units on a Drupal site. Everything keys off your **publisher ID**
(`ca-pub-…`) in `adsense.settings`. Ads are surfaced as **blocks**, **filter tags**, or **auto ads**.
Ad-unit types are **AdsenseAd plugins**. Configure at `/admin/config/services/adsense` (permission
`administer adsense`).

- **Global settings, publisher ID, disable/test/placeholder, auto ads, config keys** →
  [configure/settings.md](configure/settings.md)
- **The `AdsenseAd` plugin type, shipped plugins, and how `createAd()` picks one** →
  [plugins/adsense-ad.md](plugins/adsense-ad.md)
- **Blocks and the `[adsense:…]` input filter (how to place/render an ad)** →
  [api/tags-and-blocks.md](api/tags-and-blocks.md)
- **Permissions (`administer adsense`, `hide adsense`, `show adsense placeholders`)** →
  [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs): **adsense_adstxt** (auto `/ads.txt`) and **adsense_oldcode** (pre-2007 code),
nested under `modules/adsense_adstxt/` and `modules/adsense_oldcode/`.

Key facts: config object `adsense.settings`; publisher ID key `adsense_basic_id`
(`PublisherId::get()`); block plugins `adsense_managed_ad_block`, `adsense_cse_ad_block`; filter
`filter_adsense`; auto-ads switch `adsense_managed_page_level_ads_enabled`. For dev, set
`adsense_placeholder: true` so **no live Google request** is made. **Ground evals in local config /
blocks — never live ad calls.**
