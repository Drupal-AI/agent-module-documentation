# The `AdsenseAd` plugin type

AdSense defines its own plugin type for ad units.

- **Manager**: `plugin.manager.adsensead` (`AdsenseAdManager extends DefaultPluginManager`),
  discovers plugins in `Plugin/AdsenseAd`, interface `AdsenseAdInterface`, base `AdsenseAdBase`
  (content ads extend `ContentAdBase`; search ads extend `SearchAdBase`).
- **Annotation**: `@AdsenseAd` with fields `id`, `name`, `isSearch` (bool), `needsSlot` (bool),
  `version` (int, default 1).
- **Alter hook**: `hook_adsense_ad_info_alter()`; cache bin `adsense_ad`.

## Shipped plugins

| Plugin id | Class | isSearch | needsSlot | version | Provided by |
|---|---|---|---|---|---|
| `managed` | `ManagedAd` | false | true | 1 | adsense (modern content ads) |
| `cse` | `CustomSearchAd` | true | ? | 1 | adsense (custom search) |
| `csev2` | `CustomSearchV2Ad` | true | ? | 2 | adsense (custom search v2) |
| `oldcode` | `OldCodeAd` | false | false | 1 | **adsense_oldcode** submodule |
| `oldsearch` | `OldSearchAd` | true | — | 1 | **adsense_oldcode** submodule |

## How an ad is created (`AdsenseAdBase::createAd($args)`)

Rather than referencing a plugin id directly, callers pass `$args` (with `format`, optional `slot`,
`group`, `channel`) and the base class **selects** the matching plugin by three flags:

- `isSearch` — TRUE when `format` starts with `"Search Box"` (v2 for `"Search Box v2"`).
- `needsSlot` — TRUE when `$args['slot']` is non-empty.
- `version` — 1, or 2 for `"Search Box v2"`.

It iterates `plugin.manager.adsensead` definitions and instantiates the first whose
`isSearch`/`needsSlot`/`version` all match, e.g. a `format` + `slot` with no "Search Box" prefix
resolves to `managed`. This is why block/filter code just supplies `format`+`slot` and gets the right
unit.

## Implement a custom ad plugin

```php
namespace Drupal\mymodule\Plugin\AdsenseAd;

use Drupal\adsense\ContentAdBase;

/**
 * @AdsenseAd(
 *   id = "mymodule_special",
 *   name = @Translation("Special ad"),
 *   isSearch = FALSE,
 *   needsSlot = TRUE
 * )
 */
class SpecialAd extends ContentAdBase {
  public function getAdPlaceholder() { /* return dev placeholder render array */ }
  public function getAdContent() { /* return the real ad render array */ }
}
```

`AdsenseAdBase::display()` chooses `getAdPlaceholder()` vs `getAdContent()` based on
`adsense.settings` (disable/test/placeholder) and the current user's `hide adsense` /
`show adsense placeholders` permissions — so a correctly written plugin is dev-safe automatically.
