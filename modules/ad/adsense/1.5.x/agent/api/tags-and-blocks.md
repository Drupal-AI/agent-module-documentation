# Placing ads: blocks and the `[adsense:…]` filter

Two everyday ways to output an ad (a third, auto ads, is in [../configure/settings.md](../configure/settings.md)).

## Blocks

| Block plugin id | Class | Category | Purpose |
|---|---|---|---|
| `adsense_managed_ad_block` | `ManagedAdBlock` | Adsense | Modern content ad unit |
| `adsense_cse_ad_block` | `CustomSearchAdBlock` | Adsense | Custom Search ad unit |
| `adsense_oldcode_ad_block` / `adsense_oldsearch_ad_block` | (oldcode submodule) | Adsense | Legacy units |

`adsense_managed_ad_block` settings (schema `block.settings.adsense_managed_ad_block`):

| Setting | Notes |
|---|---|
| `ad_slot` | **required** — the Ad ID (data-ad-slot), e.g. `1234567890` |
| `ad_format` | `responsive` (default), `custom`, `autorelaxed`, `in-article`, `in-feed`, `link`, or a size key like `300x250`, `728x90` (see `ManagedAd::adsenseAdFormats()`) |
| `ad_width` / `ad_height` | only used when `ad_format` = `custom` |
| `ad_shape` | for responsive: any of `auto`, `horizontal`, `vertical`, `rectangle` (multi) |
| `ad_layout_key` | for `in-feed` (data-ad-layout-key) |
| `ad_align` | `''`, `left`, `center` (default), `right` |

Place via UI at `/admin/structure/block`, or as a config entity:

```php
use Drupal\block\Entity\Block;
$b = Block::create([
  'id' => 'sidebar_ad',
  'plugin' => 'adsense_managed_ad_block',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'content',
  'settings' => [
    'id' => 'adsense_managed_ad_block', 'label' => 'Sidebar ad', 'label_display' => 0,
    'ad_slot' => '1234567890', 'ad_format' => 'responsive', 'ad_shape' => 'auto', 'ad_align' => 'center',
  ],
]);
$b->save();
```

The block's `createAd()` builds a `ManagedAd` and `display()` renders a placeholder or the real unit
depending on `adsense.settings` and permissions (dev-safe when `adsense_placeholder` is on).

## Input filter — `filter_adsense`

Enable the **"AdSense tag"** filter (`filter_adsense`, a reversible transform) on a text format
(below "Limit allowed HTML tags"). Then editors write tags in body text:

| Tag | Meaning |
|---|---|
| `[adsense:format:slot]` | e.g. `[adsense:responsive:1234567890]` — resolves to a managed ad |
| `[adsense:format:group:channel:slot]` | legacy 4-part form (oldcode) |
| `[adsense:block:machine_name]` | render an existing AdSense **block** by its config id |

The filter matches these patterns, builds the ad via `AdsenseAdBase::createAd()` /
`$block->getPlugin()->createAd()`, and replaces the tag with the rendered ad. Tips text is shown on
the format's filter settings.
