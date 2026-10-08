<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AdSense pre-2007 code — agent index

Submodule of **adsense** for legacy pre-2007 Google ad code (deprecated by Google; legacy use
only). Adds two AdsenseAd plugins (`oldcode`, `oldsearch`) and two blocks. Depends on `adsense`
and reuses the parent's publisher ID and placeholder/disable/test safety.

- **Config object `adsense_oldcode.settings` (the five ad styles + legacy search settings),
  the two settings forms, and the blocks** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object: `adsense_oldcode.settings` (schema provided). Configure route
  `adsense_oldcode.settings` → `/admin/config/services/adsense/oldcode`; legacy search form
  `adsense_oldsearch.settings` → `/admin/config/services/adsense/search`. Both require the
  parent permission `administer adsense`.
- Blocks: `adsense_oldcode_ad_block` (`ad_format`, `ad_style`, `ad_channel`, `ad_align`) and
  `adsense_oldsearch_ad_block` (`ad_channel`).
- Plugins: `oldcode` (`OldCodeAd`, isSearch=false, needsSlot=false) and `oldsearch`
  (`OldSearchAd`, isSearch=true).
- Five reusable ad "styles" keyed `_1`…`_5`: `adsense_group_title_N`, `adsense_ad_type_N`
  (1 = link unit, 2 = ad), colour keys, `adsense_alt_N`, `adsense_ui_features_N`.
- `hook_preprocess_block()` strips "adsense" from block id/classes when the parent's
  `adsense.settings:adsense_unblock_ads` is on (anti ad-block).
- Dev-safe when the parent's `adsense_placeholder` is on.
