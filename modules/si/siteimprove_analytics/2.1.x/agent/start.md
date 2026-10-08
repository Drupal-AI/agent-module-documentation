# Siteimprove Analytics — agent index

Injects the Siteimprove Analytics JS tracker on every page, gated by an audience filter and an
excluded-routes list. One config object, one settings form, one permission. No Drush, no plugins.

- **The `siteimprove_analytics.settings` config, the settings form, filters, and how the tracker is attached** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config `siteimprove_analytics.settings`: `code` (numeric app code, validated), `user_filter` (`anonymous`|`logged_in`|`everyone`), `routes_filter` (newline-separated path patterns, wildcards; matches are EXCLUDED).
- Settings route `siteimprove_analytics.settings` at `/admin/config/system/siteimprove-analytics`, permission `administer siteimprove_analytics` (NOT restrict-access).
- `LibraryHooks::libraryInfoBuild` defines external library `siteimprove_analytics/analytics` → `https://siteimproveanalytics.com/js/siteanalyze_<code>.js` (async). Only when `code` is set.
- `AnalyticsHooks::pageAttachments` attaches it when the audience matches and the current path (alias-resolved) is NOT in `routes_filter`. Cache: `url.path` + config + `user.roles:anonymous` (unless everyone).
- Overridable from `settings.php`: `$config['siteimprove_analytics.settings']['code'|'user_filter'|'routes_filter']`.
