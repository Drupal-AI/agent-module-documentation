# Configure Simple GSE Search (the `cx` id + how the embed works)

The module needs exactly one value: your Google **Custom Search Engine id** (`cx`, also called
the Client ID). Everything else is client-side JavaScript served by Google.

## Settings form
- Route: `simple_gse_search.admin_settings` — path `/admin/config/search/simple_gse_search`.
- Permission: `administer gse search`.
- Menu link under Configuration → Search (`system.admin_config_search`), plus a local-task tab.
- Class: `Drupal\simple_gse_search\Form\SettingsForm` (extends `ConfigFormBase`), form id `simple_gse_search_settings`, `getEditableConfigNames()` → `['simple_gse_search.settings']`.
- One field: `cx` (textfield, title "Google Custom Search Engine ID"). On submit it writes `cx` to config.

## Config object
- Name: `simple_gse_search.settings`.
- Key: `cx` — string, default `''` (config/install ships it empty).
- Schema (`simple_gse_search.settings`): `config_object`, `translatable: true`; `cx` is type `text`, label "Google Search ID". Config translation is registered via `simple_gse_search.config_translation.yml`.

### Set it with drush
```
drush config:set simple_gse_search.settings cx 'XXXXXXXXXXXXXXXXX:yyyyyyyyyyy' -y
```

### Set it in PHP
```php
\Drupal::service('config.factory')
  ->getEditable('simple_gse_search.settings')
  ->set('cx', 'XXXXXXXXXXXXXXXXX:yyyyyyyyyyy')
  ->save();
```

## Runtime: how the search actually renders
1. The results controller `SearchPage::displaySearchResults` (route `simple_gse_search.search_page`, `/search`) returns an `html_tag` render element `<gcse:searchresults-only queryParameterName="s" linktarget="_parent">` (with a "please enable javascript" fallback `#value`) and attaches the `simple_gse_search/search` library plus `drupalSettings.simple_gse_search.cx`.
2. The library `js/simple_gse_search.js` (behavior `simple_gse_search`, deps `core/jquery`, `core/drupalSettings`) injects a `<script src="https://cse.google.com/cse.js?cx=<cx>">` element over HTTPS. `cx` comes from the drupalSettings value.
3. Google's `cse.js` reads the `s` query parameter (declared by `queryParameterName="s"`) and renders the result list entirely in the browser. The server never calls Google's API and never stores a secret — `cx` is a public identifier by design.

## Notes
- There is no `configure:` key in `simple_gse_search.info.yml`, so no Configure link shows on the Extend page; reach the form via the URL or the Configuration → Search menu.
- `package: Search`. No composer requirements; core-only.
