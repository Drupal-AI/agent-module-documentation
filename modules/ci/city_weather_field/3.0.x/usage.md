City Weather Field adds a "City - weather" field type that lets an editor pick a US city and renders that city's current weather from OpenWeatherMap on the entity display.

---

The module provides a complete Drupal field trio — a field type (`weather_field_type`), a select-list widget (`weather_widget`, labelled "US Cities") sourced from a bundled list of 1000 US cities in `cities.json`, and a formatter (`weather_formatter`) — plus a single admin settings form that stores the OpenWeatherMap API key in the `city_weather_field.weathersettings` config object. When the field is displayed, the formatter passes the selected city and the configured API key to `WeatherService::getWeatherInformation()`, which calls the OpenWeatherMap `/data/2.5/weather` endpoint via Guzzle and themes the result (city name, description, min/max temperature in °C, humidity, wind speed and an icon) through the `city_weather_field` Twig template. Only core `field` is required; the module ships no permissions, no Drush commands and no config schema. It targets Drupal 9.3, 10.1 and 11.

---

- Add a "weather for a city" element to a content type by attaching a single field, without writing code.
- Let editors choose the city from a curated dropdown of 1000 US cities instead of typing free text.
- Display live current temperature (min/max in °C) for a location on a node, term, user or any fieldable entity.
- Show a short weather description (e.g. "Clear Sky", "Light Rain") next to the temperature.
- Surface humidity percentage and wind speed for the selected city.
- Render an OpenWeatherMap weather icon alongside the reading.
- Build a "local weather" block-like display driven purely by an editor-selected city field.
- Add a weather badge to office/branch/store location pages that reference a US city.
- Give a city landing page a live weather panel keyed off a single field value.
- Attach weather to event pages so visitors see current conditions at the event's US city.
- Populate a directory of US city profiles, each showing its own current weather.
- Provide a weather column in a listing by exposing the field's formatter per view mode.
- Centrally manage the OpenWeatherMap API key once at /admin/config/city_weather_field/settings for all weather fields.
- Reuse the same field across multiple bundles, all sharing the one configured API key.
- Prototype a weather-aware content type quickly for a demo or proof of concept.
- Teach or demonstrate Drupal's field type/widget/formatter plugin pattern with a small, real example.
- Show weather on a US-focused travel or tourism site next to each destination city.
- Add conditions to real-estate listings that name a US city.
- Drive an editorial "what's the weather where our reporter is" widget from a city field.
- Let site builders switch a weather field's display on or off per view mode via Manage display.
- Store just the selected city per entity (a 2-character index) while fetching weather fresh at display time.
