# Installation

## Requirements

- **Drupal 10.1 or newer, or Drupal 11** (`core_version_requirement:
  ^10.1 || ^11`).
- No modules outside of Drupal core are required.
- **Optional:** the [Token](https://www.drupal.org/project/token) module — when
  present, you can use a user field token (such as
  `[current-user:field_city_name]`) as a block's location input.
- Two external accounts you set up during [configuration](../configuration/index.md):
  - An **OpenWeatherMap API key (appid)** from
    [openweathermap.org](https://openweathermap.org/).
  - A **GeoNames username** from [geonames.org](https://www.geonames.org/) (used
    for timezone and sunrise/sunset lookups).

## Install with Composer

From the project root:

```bash
composer require drupal/openweather -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openweather -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openweather -y
```

To also use user-based location tokens, enable Token as well:

```bash
drush en token -y
```

## Verify it worked

Go to **Configuration → Web services → Open Weather**
(`/admin/config/services/openweather`) and confirm the settings form appears. Enter
your OpenWeatherMap appid and GeoNames username (see
[Configuration](../configuration/index.md)), then place an **Open Weather Block**
from **Structure → Block layout**, set a location, and view the page — you should
see live weather. If the weather does not appear, check the log at **Reports →
Recent log messages** (dblog): a wrong appid is reported there.
