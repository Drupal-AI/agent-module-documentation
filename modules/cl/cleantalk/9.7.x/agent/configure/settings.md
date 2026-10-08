# cleantalk — configure

All settings are in one config object: **`cleantalk.settings`**. There are no config
entities. Edit via the settings form (route `cleantalk.settings`, path
`/admin/config/cleantalk/cleantalk_settings_form`) or with `drush config:set`.

## The one required setting: the API key

| Key | Type | Default | Purpose |
|---|---|---|---|
| `cleantalk_authkey` | string | `''` | CleanTalk **Access key** from your cleantalk.org account. Required for any live spam verdict. |

The settings form labels this field **"Access key"**. On save the form validates the key
against the CleanTalk API (`methodNoticePaidTill`) and caches account status in Drupal
`state` (`cleantalk_authkey`, `cleantalk_api_*`). That validation and every real spam check
need outbound network access to the CleanTalk API — set the key by config alone and the
value is stored, but no remote check runs until a valid key + network are present.

```bash
drush config:set cleantalk.settings cleantalk_authkey 'YOUR_KEY' -y
```

## Which forms are protected (boolean per-form toggles)

| Key | Default | Protects |
|---|---|---|
| `cleantalk_check_comments` | `true` | Comment submissions |
| `cleantalk_check_register` | `true` | User registration |
| `cleantalk_check_webforms` | `true` | Webform submissions |
| `cleantalk_check_contact_forms` | `true` | Core Contact forms |
| `cleantalk_check_search_form` | `true` | Search form |
| `cleantalk_check_forum_topics` | `false` | Forum topic posts |
| `cleantalk_check_added_content` | `false` | Newly added node content |
| `cleantalk_check_ccf` | `false` | Custom forms (CCF) |
| `cleantalk_check_external` | `false` | External / off-site forms |
| `cleantalk_check_external__capture_buffer` | `false` | Buffer capture for external forms |
| `cleantalk_check_comments_automod` | `false` | Comment automoderation |
| `cleantalk_check_comments_min_approved` | `3` | Min approved comments before a user is trusted |

```bash
# Example: also protect forum topics, stop checking the search form
drush config:set cleantalk.settings cleantalk_check_forum_topics true -y
drush config:set cleantalk.settings cleantalk_check_search_form false -y
```

## SpamFireWall & bot detection

| Key | Default | Purpose |
|---|---|---|
| `cleantalk_sfw` | `true` | SpamFireWall — block known spam IPs/bots before render |
| `cleantalk_sfw_ac` | `false` | Anti-Crawler layer |
| `cleantalk_sfw_antiflood` | `false` | Anti-Flood layer |
| `cleantalk_sfw_antiflood_limit` | `20` | Anti-Flood request limit per IP |
| `cleantalk_bot_detector` | `true` | JavaScript bot detector |
| `cleantalk_set_cookies` | `true` | Set anti-spam cookies |
| `cleantalk_alternative_cookies_session` | `false` | Use alternative (session) cookie mechanism |

## Exclusions & misc

| Key | Default | Purpose |
|---|---|---|
| `cleantalk_url_exclusions` | `''` | Paths to skip (newline list) |
| `cleantalk_url_regexp` | `false` | Treat URL exclusions as regexp |
| `cleantalk_fields_exclusions` | `''` | Form fields never sent to the API |
| `cleantalk_fields_regexp` | `false` | Treat field exclusions as regexp |
| `cleantalk_roles_exclusions` | `''` | User roles exempt from checks (mapping) |
| `cleantalk_search_noindex` | `false` | Add `noindex` to search-result pages |
| `cleantalk_link` | `false` | Show CleanTalk backlink |
| `cleantalk_use_drupal_http_api` | `false` | Use Drupal HTTP client instead of raw cURL |
| `cleantalk_debug_enabled` | `0` | Debug logging |

## Read current config

```bash
drush config:get cleantalk.settings
drush config:get cleantalk.settings cleantalk_authkey
```

## Other admin screens (not config)

Beyond Settings, the module adds retroactive-scan tools under `/admin/config/cleantalk/`:
**Check spam users** (`cleantalk.check_users`) and **Check spam comments**
(`cleantalk.check_comments`). These call the API to find/delete existing spam and are gated
by `administer site configuration` (not the module's own permission).
