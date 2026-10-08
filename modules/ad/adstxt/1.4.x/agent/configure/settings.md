# ads.txt — configuration

## Config object `adstxt.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `content` | string | `''` | Full body of `/ads.txt`. |
| `app_content` | string | `''` | Full body of `/app-ads.txt`. |

Schema: `config/schema/adstxt.schema.yml` (`config_object`). Set programmatically:

```php
\Drupal::configFactory()->getEditable('adstxt.settings')
  ->set('content', "greenadexchange.com, 12345, DIRECT, AEC242\n")
  ->save();
```

## Admin form

- Route `adstxt.admin_settings_form` → `/admin/config/system/adstxt`
  (`Drupal\adstxt\Form\AdsTxtAdminSettingsForm`, extends `ConfigFormBase`).
- Permission: **`administer ads.txt`** (the module's only permission).
- Two textareas map to `content` and `app_content`. On submit, CRLF/CR are normalized to `\n`
  before saving.

## Output routes (public)

- `adstxt.content` → `/ads.txt` → `AdsTxtController::build()`.
- `adstxt.app_content` → `/app-ads.txt` → `AdsTxtController::buildAppAds()`.
- Both require `_access: 'TRUE'` (deliberately open — these files must be crawlable). Response
  is a `text/plain` `CacheableResponse`; the response's cacheability is derived from the config
  object plus any hook-contributed cacheable metadata. If, after merging hook additions and
  filtering empty lines, the content is empty, a `CacheableNotFoundHttpException` (404) is thrown.

## Install & requirements

- `hook_install()` seeds `content`/`app_content` from the first readable of:
  `DRUPAL_ROOT/ads.txt`, `sites/default/default.ads.txt`, module `ads.txt` (and the app-ads
  equivalents).
- `hook_requirements('runtime')`:
  - **ERROR** if Clean URLs are not enabled (the routes cannot resolve without them).
  - **WARNING** if a physical `ads.txt` exists in the docroot — most webservers serve the file
    from disk and bypass the module route, so it should be removed.
