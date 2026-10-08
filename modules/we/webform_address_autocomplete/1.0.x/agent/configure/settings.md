<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: active provider and provider credentials

Two-step configuration: pick the active provider on the main settings form, then open that
provider's own sub-page to enter its credentials/options.

## Routes and access

| Route | Path | Access | Form |
|---|---|---|---|
| `webform_address_autocomplete.settings` | `/admin/config/webform-address-autocomplete` | `administer site configuration` | `Form\SettingsForm` |
| `webform_address_autocomplete.webform_address_provider.<id>` | `/admin/config/webform-address-autocomplete/<id-with-dashes>` | `access administration pages` | `Form\ProviderSettingsForm` |

The per-provider routes are generated dynamically for every discovered provider by
`Routing\WebformAddressProviderRoutes::routes()` (route callback registered in
`webform_address_autocomplete.routing.yml`). The plugin id's underscores become dashes in the
path (e.g. `google_maps` → `.../google-maps`). Reach them from the main form's per-row
**Settings** operation link.

## Config object

Single config object **`webform_address_autocomplete.settings`** (`SettingsForm::$configName`).
There is **no `config/schema`** and no `config/install` default, so the object does not exist
until the form is saved.

| Key | Written by | Value |
|---|---|---|
| `active_plugin` | `SettingsForm::submitForm()` | the active provider plugin id, e.g. `google_maps` (a `tableselect`, single-select) |
| `<plugin_id>` (e.g. `google_maps`) | `ProviderSettingsForm::submitForm()` | `serialize()` of that provider's configuration array |

Provider settings are stored as a **PHP-serialized string**, not a nested array. On read,
`WebformAddressProviderBase::create()` does
`unserialize($configObject->get($plugin_id), ['allowed_classes' => FALSE])` and merges it over
the plugin's `defaultConfiguration()`.

## Set it via Drush/PHP

Because the per-provider value is a serialized string, set it with PHP rather than
`drush config:set`:

```php
$config = \Drupal::configFactory()->getEditable('webform_address_autocomplete.settings');
// Choose the active provider.
$config->set('active_plugin', 'google_maps');
// Provider config is a SERIALIZED array keyed by plugin id.
$config->set('google_maps', serialize([
  'plugin_id' => 'google_maps',
  'api_key'   => 'YOUR_GOOGLE_GEOCODING_KEY',
]));
$config->save();
```

The exact per-provider keys are documented in [../plugins/address-providers.md](../plugins/address-providers.md)
(`api_key` for Google, `token` for Mapbox, `endpoint`/`username`/`password` for Post CH, and
`endpoint`/`type`/`postcode`/`citycode`/`lat`/`lon`/`limit` for France).

## Runtime

`Element\WebformAddressAutocomplete::processAutocomplete()` reads `active_plugin`; if it is
empty the element renders a warning message linking to the settings form and no lookups happen.
`Controller\WebformAddressAutocomplete::getProviderResults()` instantiates
`active_plugin` via the manager and calls its `processQuery()` — the provider id is taken from
config, never from the request.
