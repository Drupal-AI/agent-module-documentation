# Configure Country Path

No dedicated settings form (`configure` is null). Configuration is (1) per Domain record and (2) the core
language negotiation UI.

## 1. Give a domain a country prefix

On the Domain add/edit form (`/admin/config/domain`), the module alters the **Canonical hostname** field:
enter the country prefix appended to the host, e.g. `example.com/usa`. On save,
`country_path_save_domain_configs()` (entity builder) splits the trailing segment off and stores it as the
domain third-party setting `country_path.domain_path` (`= 'usa'`); the hostname stays `example.com`. Clear
the prefix to remove it (`unsetThirdPartySetting`).

Set it directly with Drush instead of the UI:

```php
// drush php:eval
$d = \Drupal::entityTypeManager()->getStorage('domain')->load('example_com');
$d->setThirdPartySetting('country_path', 'domain_path', 'usa');
$d->save();
```

Because the module overrides the Domain entity `preSave` (`src/Entity/CountryPathDomain.php`) to relax the
unique-hostname constraint, several domain records may share hostname `example.com` while differing only by
their `domain_path`.

## 2. Domain aliases (optional, needs `domain_alias`)

On the domain-alias form the pattern description is altered to allow `example.com/usa`. A request is
matched against `loadByHostname("$hostname/$prefix")` first, then `loadByHostname($hostname)`, so an alias
can capture a country prefix or an alias redirect can forward it.

## 3. Language negotiation (needs core `language`)

On install (or when `language` is later enabled) the module runs
`country_path_activate_plugin_for_language_url_negotiator()`, adding the **`country-path-language-url`**
plugin to the `language_url` negotiators at weight `-1` (ahead of core's URL plugin). It also injects
itself into the fixed URL negotiators list. You can reorder/disable it at
*Configuration → Regional and language → Detection and selection* (`/admin/config/regional/language/detection`).
The plugin (a subclass of core `LanguageNegotiationUrl`) resolves language from either the path prefix
(after the country segment) or a per-language domain, per the standard URL-negotiation `source` setting.

On uninstall (`country_path_uninstall`) the plugin is removed from the `language_url`,
`language_interface`, and `language_content` negotiator configs.
