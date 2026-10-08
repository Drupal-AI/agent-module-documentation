# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A free **OpenWeatherMap API key** — register at
  [OpenWeatherMap.org](https://openweathermap.org/) to create one. The module
  cannot fetch weather without it.
- No dependent modules and no third-party PHP library requirements. The module
  calls the GeoPlugin and OpenWeatherMap web services over HTTP.

## Install with Composer

From the project root:

```bash
composer require drupal/smartweather -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smartweather -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smartweather -y
```

## Next step

Smart Weather needs your OpenWeatherMap API key before it can display anything.
Continue to [Configuration](../configuration/index.md).
