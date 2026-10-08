# Installation

## Requirements

- **Drupal 9.3+, 10.1+, or 11** (`core_version_requirement: ^9.3 || ^10.1 || ^11`).
- Core's **Field** module (standard in Drupal).
- An **OpenWeatherMap API key** — free keys are available at
  [home.openweathermap.org/api_keys](https://home.openweathermap.org/api_keys).

There are no third-party Composer or PHP library requirements.

> **Note:** this module is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/city_weather_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/city_weather_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en city_weather_field -y
```

## Next: set the API key and add a field

The module cannot fetch weather until you supply an OpenWeatherMap API key, and it
does nothing visible until you add a **City – weather** field to a content type.
Both steps are covered in [Configuration](../configuration/index.md).

## Verify it worked

After setting the API key and adding a field, create or edit a content item, pick a
city on the field, save, and view the page. The current weather for that city
should render alongside the content. If it doesn't, re-check the API key on the
settings form.
