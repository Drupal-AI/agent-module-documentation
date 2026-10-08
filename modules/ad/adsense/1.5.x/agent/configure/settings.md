# AdSense global settings

All global state is the `adsense.settings` config object. Forms (all require **`administer adsense`**):

| Route | Path | Form |
|---|---|---|
| `adsense.main_settings` | `/admin/config/services/adsense` | general + publisher ID + placeholder/test/disable |
| `adsense_managed.settings` | `/admin/config/services/adsense/managed` | managed (async/defer, auto ads) |
| `adsense_cse.settings` | `/admin/config/services/adsense/cse` | custom search appearance |

`configure` route (info.yml) = `adsense.main_settings`.

## Key config values (`adsense.settings`, shipped defaults)

| Key | Default | Meaning |
|---|---|---|
| `adsense_basic_id` | `''` | **Publisher ID** (`ca-pub-…`, stored without/with the `ca-` prefix as entered). Read by `PublisherId::get()`. |
| `adsense_id_module` | `'adsense_basic'` | Which module supplies the publisher ID. |
| `adsense_disable` | `false` | Master off switch — suppresses all ads. |
| `adsense_test_mode` | `false` | Flags ad requests as tests (no real impressions). |
| `adsense_placeholder` | `true` | When ads are disabled/dev, render a placeholder box instead of a real ad. |
| `adsense_placeholder_text` | `'Google AdSense'` | Text shown in the placeholder. |
| `adsense_unblock_ads` | `false` | Attach the anti-adblock request library. |
| `adsense_secret_language` | `''` | Restrict ads to a language (legacy sync code). |
| `adsense_managed_page_level_ads_enabled` | `false` | **Auto ads** (page-level) on/off. |
| `adsense_access_pages` | `{}` | Path visibility for auto ads (`id`, `pages`, `negate`). |
| `adsense_managed_async` | `true` | Use asynchronous ad code (vs synchronous). |
| `adsense_managed_defer` | `false` | Defer the ad script. |
| `adsense_cse_*` | various | Custom-search appearance (logo, colours, encoding, language, country, frame width, ad location). |

## Set values with drush

```bash
drush cset adsense.settings adsense_basic_id 'ca-pub-1234567890123456' -y
drush cset adsense.settings adsense_placeholder true -y     # dev: no live Google request
drush cset adsense.settings adsense_managed_page_level_ads_enabled true -y
drush cget adsense.settings                                  # read everything back
```

In PHP:

```php
\Drupal::configFactory()->getEditable('adsense.settings')
  ->set('adsense_basic_id', 'ca-pub-1234567890123456')->save();
$id = \Drupal\adsense\PublisherId::get();   // ca-pub-1234567890123456
```

## Auto ads (page-level)

When `adsense_managed_page_level_ads_enabled` is TRUE, `adsense_page_attachments()` injects the
page-level auto-ads snippet into `<head>` for the client ID — unless the page is excluded by
`adsense_access_pages` (a `request_path` condition config: `pages` newline list + `negate`) or ads
are disabled. No block needed.

## Dev safety

Set `adsense_placeholder: true` (default) and/or `adsense_disable: true`: ad units render a
placeholder box (publisher/slot/size text) rather than calling Google. Keep this on when evaluating
locally — never trigger live ad requests.
