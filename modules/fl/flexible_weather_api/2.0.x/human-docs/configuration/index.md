# Configuration

All configuration happens on the module's weather-services settings form,
registered as `flexible_weather_api.weather_api_services` (in the **Weather API**
package). There you choose which weather service to use and supply the credentials
it needs.

## Before you start: store the API key as a secret

The weather service authenticates with an **API key**, and that key is a
credential — it must **not** be committed to your configuration export or version
control. Store it as an environment variable and reference it through a **Key**
entity.

On a DDEV site the recommended flow is:

1. Save the value into DDEV's dotenv file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --weather-api-key=YOUR_KEY_HERE
   ddev restart
   ```

   The flag `--weather-api-key` becomes the environment variable
   `WEATHER_API_KEY` inside the web container.

2. Install the Key module if it is not already enabled and confirm the variable is
   present **without printing its value**:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev exec 'test -n "$WEATHER_API_KEY"'   # exit status 0 means it is set
   ```

3. Create a Key entity backed by that environment variable:

   ```bash
   ddev drush key:save weather_api_key --label='Weather API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"WEATHER_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Then, on the settings form, point the module at that Key rather than pasting the
raw value, wherever the form offers a Key selector.

## Choose and configure a provider

On the settings form you select the weather service to use — the module ships
support for services such as **Open Weather Map**, **WeatherStack**, and **Yahoo
Weather**, and the plugin system allows more to be added. For your chosen
provider, supply:

- The **service/provider** selection.
- The **API key / credentials** for that service (via the Key entity above).
- Any provider-specific options the form exposes (for example location or units),
  which vary by service.

## Operational cautions

- **Use HTTPS.** All calls to the weather provider should go over HTTPS so the key
  and responses are not sent in the clear.
- **Respect rate limits and terms.** Each request counts against your provider's
  quota, and some plans charge per call. Cache the rendered weather output rather
  than fetching on every page request, and review the provider's terms of use.
- **The data is external content.** Weather data comes from a third party; the
  module does not gate access to it.

## Save

Save the settings form. Once a provider is selected and its Key is in place, the
module can fetch weather data for use on your site.
