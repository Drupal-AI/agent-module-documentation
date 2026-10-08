<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AdSense pre-2007 code is a submodule of AdSense that renders ad units and a search box using Google's pre-2007 ("old") ad code and styling. Google deprecated this code in 2007, so it exists for legacy inventory only and is not recommended for new sites.

---

The submodule adds two AdsenseAd plugins to the parent module — `oldcode` (`OldCodeAd`) and `oldsearch` (`OldSearchAd`) — and two blocks, `adsense_oldcode_ad_block` (`OldCodeAdBlock`) and `adsense_oldsearch_ad_block` (`OldSearchAdBlock`). Its configuration lives in `adsense_oldcode.settings` and is edited on two forms, both requiring the parent's `administer adsense` permission: Old Code Ads (`adsense_oldcode.settings`, `/admin/config/services/adsense/oldcode`) and Old Search (`adsense_oldsearch.settings`, `/admin/config/services/adsense/search`). The old-code settings define up to **five reusable ad "styles"** (`adsense_group_title_1`…`_5`), each with an ad type (`adsense_ad_type_N`: 1 = link unit, 2 = ad), text/border/background/link/URL colours, an alternate-URL option and rounded-corners UI feature; the search settings configure the legacy Google search box (colours, country/Google domain, encoding, language, logo, safe mode, text box length, up to three specific search domains). The `adsense_oldcode_ad_block` block chooses an `ad_format`, one of those `ad_style`s, an `ad_channel` and an `ad_align`; the search block just takes an `ad_channel`. It also implements `hook_preprocess_block()` so that when the parent's `adsense_unblock_ads` option is on, the word "adsense" is stripped from the block id/classes to dodge ad-blocker rules. Like the rest of AdSense it honours the parent's placeholder/disable/test settings, so it is dev-safe when `adsense_placeholder` is on.

---

- Keep serving legacy pre-2007 Google AdSense ad units on an old site that still uses them.
- Define up to five reusable ad "styles" (colours, type, corners) and reference them from blocks.
- Place a legacy ad unit with the `adsense_oldcode_ad_block` block, choosing style, format, channel and alignment.
- Add a legacy Google search box with the `adsense_oldsearch_ad_block` block.
- Configure a link unit (ad type 1) versus a standard ad (ad type 2) per style.
- Set per-style text, border, background, title (link) and URL colours to match a theme.
- Use an alternate URL colour for a style via `adsense_alt_N` / `adsense_alt_info_N`.
- Enable rounded corners on a legacy unit through `adsense_ui_features_N`.
- Track performance by assigning an AdSense channel to a legacy block.
- Configure the old search box's Google country domain (e.g. `www.google.co.uk`).
- Set the search box encoding, language and text-box length.
- Restrict legacy search to up to three specific domains.
- Toggle SafeSearch on the legacy search box.
- Reuse a single publisher ID (from the parent AdSense module) across legacy units.
- Migrate legacy D7 old-code settings via the shipped migration.
- Bypass ad-blocker class rules by enabling the parent's `adsense_unblock_ads` (strips "adsense" from block markup).
- Preview legacy units safely in development using the parent's placeholder mode.
- Align a legacy ad left/center/right within its block via `ad_align`.
- Provide legacy ad formats/sizes not covered by the modern managed unit.
- Gradually retire old-code inventory while the rest of the site uses modern managed ads.
- Export legacy ad configuration as `adsense_oldcode.settings` for deployment.
