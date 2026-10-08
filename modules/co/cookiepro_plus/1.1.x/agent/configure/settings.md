# Configure CookiePro Plus

Config UI: `/admin/config/system/cookiepro-plus` (route `cookiepro_plus.configuration`, form
`ConfigForm`). Default settings live in the `cookiepro_plus.config` config object
(`config/install/cookiepro_plus.config.yml`, schema `cookiepro_plus.config`). Per-language override
configs are named `cookiepro_plus.config.<langcode>` (schema `cookiepro_plus.config.*`) and are only
offered when the site uses URL **domain** language negotiation with >1 domain.

## Settings keys (defaults from config/install)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `domain_script` | string | `""` | OneTrust **Script ID** (`data-domain-script`). Empty ⇒ nothing injected + a `critical` log entry. |
| `domain` | string | `domain_cookiepro` | Which CDN domain: `domain_cookiepro` (cdn.cookiepro.com) or `domain_onetrust` (cdn.cookielaw.org). |
| `auto_block` | bool | `false` | Load the Auto-Blocking™ script (`.../consent/<id>/OtAutoBlock.js`) before the main script. |
| `document_language` | bool | `true` | Set `data-document-language=true` so OneTrust reads the page `<html lang>`. |
| `category_ids` | mapping | `C0001…C0005` | The five OneTrust cookie-category IDs (Strictly Necessary, Performance, Functional, Targeting, Social Media) used to build CSS classes. |
| `enable_limit_to_paths` | bool | `false` | When on, only inject on paths listed in `limit_to_paths`. |
| `limit_to_paths` | string | `""` | Newline path patterns to limit injection to (uses core path matcher, supports `*`). |
| `exclude_paths` | string | node edit / previewer / embed preview | Newline path patterns that never receive the script. |
| `ip_whitelist` | string | `20.54.106.120/29` | IPv4 addresses/CIDR ranges that bypass CookiePro; matching requests also kill the page cache and attach `cookiepro_plus/cookiepro_plus.bypass`. |
| `gcm_enable` | bool | `false` | Emit the inline Google Consent Mode default-state script. |
| `gcm_deny_storages` | mapping | all `true` | Which GCM storages default to `denied` (ad_storage, ad_user_data, ad_personalization, analytics_storage, functionality_storage, personalization_storage, security_storage). |
| `test_cdn` | bool | `false` | Append `-test` to the Script ID to hit OneTrust's staging CDN. |
| `override_language` | string | `""` | Set on override configs to bind them to a langcode (empty = default config). |

## Pause mode

Pause is **not** stored in config — it is a State flag (`cookiepro_plus.paused`, or
`..._paused_<langcode>` for overrides) toggled via the config form. While paused, `isPaused()` short-
circuits injection; users with `administer cookiepro_plus configuration` see a warning message linking
back to the relevant config page (`CookiePro::getPauseModeMessages()`).

## Drush / programmatic edit

```php
\Drupal::configFactory()->getEditable('cookiepro_plus.config')
  ->set('domain_script', '0123abcd-4567-89ef-0123-456789abcdef')
  ->set('auto_block', TRUE)
  ->set('ip_whitelist', '')   // clear the shipped default range
  ->save();
```

## Injection gate (order, from `cookiepro_plus_page_attachments()`)

1. If paused → stop. 2. If admin route → stop. 3. If client IP whitelisted → kill page cache, attach
bypass lib, stop. 4. If `enable_limit_to_paths` and path not in `limit_to_paths` → stop. 5. If path in
`exclude_paths` → stop. 6. Else attach (GCM support script, Auto-Block script, then the main consent
script with `data-domain-script`).
