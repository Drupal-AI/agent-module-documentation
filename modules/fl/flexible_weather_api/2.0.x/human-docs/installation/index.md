# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An account and **API key** with a supported weather service (for example Open
  Weather Map or WeatherStack). You provide that key during configuration.
- Outbound HTTPS network access from your server to the weather provider.

No third-party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/flexible_weather_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flexible_weather_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flexible_weather_api -y
```

## Submodules

Flexible Weather API ships two optional submodules — enable only what you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Weather API Entity** | `weather_api_entity` | Entity-based handling of weather data. |
| **Weather API Plugin** | `weather_api_plugin` | The plugin-based extension surface for weather providers. |

```bash
drush en weather_api_plugin -y
```

## Verify it worked

Go to the module's settings form (`flexible_weather_api.weather_api_services`,
under the **Weather API** area). If you can select a weather provider and enter its
credentials, the module is installed correctly. Continue to
[Configuration](../configuration/index.md) to connect a service and store the key
securely.
