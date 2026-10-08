<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `WebformAddressProvider`

The lookup backend is a plugin, so the address source is swappable and extendable. The active
provider is chosen in config (`active_plugin`); its `processQuery()` is what the JSON endpoint
calls.

## Plugin type wiring

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.webform_address_provider` (`Plugin\WebformAddressProviderManager`, extends `DefaultPluginManager`) |
| Discovery dir | `src/Plugin/WebformAddressProvider` |
| Annotation | `@WebformAddressProvider(id, label)` — `src/Annotation/WebformAddressProvider.php` |
| Interface | `Plugin\WebformAddressProviderInterface` — extends `PluginFormInterface`, `ConfigurableInterface`, `ContainerFactoryPluginInterface`; adds `processQuery($string)` |
| Base class | `Plugin\WebformAddressProviderBase` (abstract) |
| Alter hook | `hook_webform_address_autocomplete_address_provider_info_alter(&$defs)` |
| Plugin cache | key `webform_address_autocomplete_address_provider_plugins` |

`WebformAddressProviderBase` injects Guzzle `http_client` and `language_manager`, and in
`create()` loads this plugin's saved configuration from
`webform_address_autocomplete.settings` (the serialized value keyed by plugin id),
`unserialize(..., ['allowed_classes' => FALSE])`, merged over `defaultConfiguration()`. Its
constructor is `final`. Subclasses implement `processQuery()`, `defaultConfiguration()`,
`buildConfigurationForm()`, `submitConfigurationForm()` (and optionally
`validateConfigurationForm()`).

`processQuery($string)` receives `"<query>||<country>"` (country only when the element passed a
`country_code`); providers `explode('||', …)` to separate them. It must return an array of
associative arrays using keys `street_name`, `town_name`, `zip_code`, `administrative_area`,
`label`, and optionally `location` => `['longitude'=>…, 'latitude'=>…]`.

## Bundled providers

| Plugin id | Label | External host (fixed unless noted) | Config keys | Credential |
|---|---|---|---|---|
| `france_address` | France Address | `endpoint` (default `https://api-adresse.data.gouv.fr/search/`) | `endpoint`, `type`, `postcode`, `citycode`, `lat`, `lon`, `limit` | none (open API) |
| `google_maps` | Google Maps | `https://maps.googleapis.com/maps/api/geocode/json` | `api_key` | `api_key` (required) |
| `mapbox_geocoding` | Mapbox Geocoding | `https://api.mapbox.com/geocoding/v5/mapbox.places/` | `token` | `token` (required) |
| `post_ch` | Post CH (Swiss Post) | `endpoint` (admin-entered) | `endpoint`, `username`, `password` | HTTP Basic (`username`/`password`) |

Notes:
- **France** requires ≥3 chars starting alphanumeric; sends `autocomplete=0`, `limit`, `q` and
  optional filters (`type`, `postcode`, `citycode`, `lat`+`lon`) as query params to `endpoint`.
- **Google** GETs the Geocoding API with `key`, `address`, `language=en`; assembles street from
  `street_number` + `route`, maps `locality`/`administrative_area_level_1`/`postal_code`.
- **Mapbox** GETs `.../mapbox.places/<query>.json` with `access_token`, `types=address`,
  `limit=10`, current UI language, optional `country`; has per-country street-number ordering.
- **Post CH** POSTs a JSON `QueryAutoComplete4` request with Guzzle `auth` (Basic); guesses a
  trailing numeric token as the house number; caps results at 10; runs each returned field
  through `Xss::filter()`.

All four call the injected Guzzle client with default options (TLS verification on).

## Writing a new provider

```php
namespace Drupal\my_module\Plugin\WebformAddressProvider;

use Drupal\Core\Form\FormStateInterface;
use Drupal\webform_address_autocomplete\Plugin\WebformAddressProviderBase;

/**
 * @WebformAddressProvider(
 *   id = "my_provider",
 *   label = @Translation("My provider"),
 * )
 */
class MyProvider extends WebformAddressProviderBase {

  public function defaultConfiguration() {
    return parent::defaultConfiguration() + ['api_key' => ''];
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $form['api_key'] = ['#type' => 'textfield', '#title' => $this->t('API Key'),
      '#default_value' => $this->configuration['api_key'], '#required' => TRUE];
    return $form;
  }

  public function submitConfigurationForm(array &$form, FormStateInterface $form_state) {
    $configuration = $this->getConfiguration();
    $configuration['api_key'] = $form_state->getValue('api_key');
    $this->setConfiguration($configuration);
  }

  public function processQuery($string) {
    [$q] = explode('||', $string);
    $response = $this->client->request('GET', 'https://api.example.com/geocode', [
      'query' => ['key' => $this->configuration['api_key'], 'q' => trim($q)],
    ]);
    // Map the response to rows keyed street_name/town_name/zip_code/label/...
    return [];
  }
}
```

Drop it in your module's `src/Plugin/WebformAddressProvider/`; it appears on the settings form's
provider table automatically. `defaultConfiguration()` must include `plugin_id` (the base adds
it). Existing providers can be altered/removed via
`hook_webform_address_autocomplete_address_provider_info_alter()`.
