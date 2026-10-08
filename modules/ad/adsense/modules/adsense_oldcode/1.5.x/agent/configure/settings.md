<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AdSense pre-2007 code — settings & blocks

All state is the `adsense_oldcode.settings` config object, edited on two forms (both require the
parent permission **`administer adsense`**):

| Route | Path | Form |
|---|---|---|
| `adsense_oldcode.settings` | `/admin/config/services/adsense/oldcode` | Old Code Ads (the five ad styles) |
| `adsense_oldsearch.settings` | `/admin/config/services/adsense/search` | Old Search (legacy search box) |

`configure` (info.yml) = `adsense_oldcode.settings`.

## The five ad "styles"

Keys are suffixed `_1` … `_5` (one per style):

| Key (per N) | Default | Meaning |
|---|---|---|
| `adsense_group_title_N` | `''` | style name shown in the block's Style select |
| `adsense_ad_type_N` | `2` | `1` = link unit, `2` = ad (Google `ADSENSE_OLDCODE_TYPE_LINK`/`_AD`) |
| `adsense_color_text_N` | `#000000` | text colour |
| `adsense_color_border_N` | `#336699` | border colour |
| `adsense_color_bg_N` | `#FFFFFF` | background colour |
| `adsense_color_link_N` | `#0000FF` | title (link) colour |
| `adsense_color_url_N` | `#008000` | URL colour |
| `adsense_alt_N` | `0` | use an alternate URL colour |
| `adsense_alt_info_N` | `''` | alternate info |
| `adsense_ui_features_N` | `rc:0` | rounded-corners UI feature |

## Legacy search box keys (subset)

`adsense_search_button` (bool), `adsense_search_country` (default `www.google.com`),
`adsense_search_encoding` (`UTF-8`), `adsense_search_language` (`en`),
`adsense_search_logo` (`adsense_search_logo_google`), `adsense_search_safe_mode` (bool),
`adsense_search_textbox_length` (`31`), `adsense_search_frame_width` (`800`),
`adsense_search_domain_0..2`, plus a family of `adsense_search_color_*` colours.

## Blocks

| Block plugin id | Settings (schema) |
|---|---|
| `adsense_oldcode_ad_block` | `ad_format`, `ad_style` (one of the five style ids), `ad_channel`, `ad_align` |
| `adsense_oldsearch_ad_block` | `ad_channel` |

Place via `/admin/structure/block`, or as a config entity:

```php
use Drupal\block\Entity\Block;
Block::create([
  'id' => 'legacy_ad',
  'plugin' => 'adsense_oldcode_ad_block',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'content',
  'settings' => [
    'id' => 'adsense_oldcode_ad_block', 'label' => 'Legacy ad', 'label_display' => 0,
    'ad_format' => '468x60', 'ad_style' => '1', 'ad_channel' => '', 'ad_align' => 'center',
  ],
])->save();
```

## Read / set via drush

```bash
drush cget adsense_oldcode.settings
drush cset adsense_oldcode.settings adsense_group_title_1 'Sidebar Skyscraper' -y
drush cset adsense_oldcode.settings adsense_search_country 'www.google.co.uk' -y
```

## Anti ad-block interaction

`adsense_oldcode_preprocess_block()` removes "adsense" from the block's `plugin_id`/provider
when the **parent** setting `adsense.settings:adsense_unblock_ads` is TRUE, so ad-blocker rules
that match "adsense" in markup are dodged. It has no effect otherwise.

Dev safety and the publisher ID come from the parent AdSense module — keep
`adsense.settings:adsense_placeholder` on to render placeholders instead of live ads.
