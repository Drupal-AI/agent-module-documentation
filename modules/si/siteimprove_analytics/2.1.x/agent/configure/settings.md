# Siteimprove Analytics — settings & tracker attachment

Config UI at **/admin/config/system/siteimprove-analytics** (route `siteimprove_analytics.settings`,
permission `administer siteimprove_analytics`). Config object: `siteimprove_analytics.settings`.

## Settings keys
| Key | Type | Default | Meaning |
|---|---|---|---|
| `code` | string (numeric) | `''` | Siteimprove application code. Validated as numeric on the form. Empty = tracker disabled. |
| `user_filter` | string | `anonymous` | Audience: `anonymous`, `logged_in`, or `everyone`. Schema constrains to these three. |
| `routes_filter` | string | see below | Newline-separated path patterns; matches are **excluded** from tracking. Wildcards allowed. |

Default `routes_filter` (`\r\n`-separated): `/admin`, `/admin/*`, `/batch`, `/node/add*`,
`/node/*/edit`, `/node/*/delete`, `/user/*/edit`, `/user/*/cancel`.

## How the tracker is attached
- `LibraryHooks::libraryInfoBuild()` (`hook_library_info_build`) — when `code` is set, defines
  library `siteimprove_analytics/analytics` with one external, async JS file:
  `https://siteimproveanalytics.com/js/siteanalyze_<code>.js`.
- `AnalyticsHooks::pageAttachments()` (`hook_page_attachments`) — attaches that library when:
  1. `code` is non-empty, AND
  2. the current path (resolved to its alias, lower-cased; also raw path) does **not** match
     `routes_filter` (`path.matcher`), AND
  3. the audience matches: `anonymous`+anonymous user, or `logged_in`+authenticated, or `everyone`.
- Cacheability: adds `url.path`, the config object as a cacheable dependency, and
  `user.roles:anonymous` when `user_filter !== 'everyone'`. The form invalidates the `library_info`
  cache tag on save.

## Set from settings.php (per-environment)
```php
$config['siteimprove_analytics.settings']['code'] = '1234567';
$config['siteimprove_analytics.settings']['user_filter'] = 'everyone';
$config['siteimprove_analytics.settings']['routes_filter'] = "/admin\n/admin/*\n/secret/*";
```

## Set with Drush
```bash
ddev drush cset siteimprove_analytics.settings code 1234567 -y
ddev drush cset siteimprove_analytics.settings user_filter everyone -y
```
