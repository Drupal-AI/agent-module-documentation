# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Block** module (`block`) enabled — it is the only module dependency
  and ships with Drupal; it is enabled automatically as a dependency.
- A **WeatherAPI account and API key** (from weatherapi.com). You do not need it
  to install the module, but the widget cannot fetch weather without it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/aero_weather -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aero_weather -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

### Storing the API key as an environment variable (recommended)

Rather than committing the WeatherAPI key into configuration, keep it in an
environment variable. Under DDEV you can set one like this:

```bash
ddev dotenv set .ddev/.env --weatherapi-key=<your-key>
ddev restart
```

Keep `.ddev/.env` out of version control.

## Enable the module

```bash
drush en aero_weather -y
```

## Next step

Once enabled, provide your WeatherAPI key to the module and place its weather
block — see [How to use it](../index.md#how-to-use-it) on the overview page.
