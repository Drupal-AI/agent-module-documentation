<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Location Input plugin type

Defines **how the end user supplies the "search from here" point** in a location filter/facet.

- Plugin type id: **`location_input`** (discovery dir `Plugin/search_api_location/location_input`).
- Manager service: **`plugin.manager.search_api_location.location_input`**
  (`LocationInputPluginManager extends DefaultPluginManager`).
- Annotation: **`@LocationInput`** (`id`, `label`, `description`).
- Interface: `Drupal\search_api_location\LocationInput\LocationInputInterface`
  (extends `PluginFormInterface`).
- Base class: `Drupal\search_api_location\LocationInput\LocationInputPluginBase`
  (extends Search API's `ConfigurablePluginBase`).
- Alter hook: **`hook_search_api_location_input_info_alter(array &$infos)`** — change a plugin's
  `label`/`description`/`class`/`provider`.

## Bundled plugins
| id | Label | Provider | Behaviour |
|---|---|---|---|
| `raw` | Raw input | search_api_location | User types `lat,lon`; validated by regex. |
| `geocode_map` | Map | search_api_location | User picks a point on a Google map (radius drawing options). |
| `geocode` | Geocoded input | search_api_location_geocoder | User types an address, geocoded via geocoder providers. |

## Interface methods to implement
```php
public function hasInput(array $input, array $settings);   // is there usable input?
public function getParsedInput(array $input);              // return "lat,lon" or NULL
public function label();                                   // admin label
public function getDescription();                          // admin description
public function getForm(array $form, FormStateInterface $form_state, array $options);
// plus PluginFormInterface: buildConfigurationForm / validateConfigurationForm / submitConfigurationForm
```
`$input` contains either `value` (raw string) or `lat` + `lng` (map). `getParsedInput()` must
return a `"latitude,longitude"` string or NULL. The base class provides the radius settings
(`radius_type`, `radius_options`, `radius_units`) and default `hasInput()`.

## Implementing your own
1. Create `src/Plugin/search_api_location/location_input/MyInput.php`.
2. Annotate with `@LocationInput(id="my_input", label=@Translation("…"), description=…)`.
3. Extend `LocationInputPluginBase` (implement `ContainerFactoryPluginInterface` if you need
   services, as `geocode` does), implement `getParsedInput()` (return `"lat,lon"`), and override
   `buildConfigurationForm()`/`defaultConfiguration()` for extra settings.

## Manager helpers
```php
$m = \Drupal::service('plugin.manager.search_api_location.location_input');
$m->getInstances();          // instantiated plugins keyed by id
$m->getInstancesOptions();   // [id => label] for a select element
```
