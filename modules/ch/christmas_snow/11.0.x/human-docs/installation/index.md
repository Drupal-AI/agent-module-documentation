# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No other Drupal modules are required — it relies only on core (jQuery and the
  core Farbtastic colour picker, both provided by core).
- A working copy of the **Snowstorm** JavaScript library. The module *declares*
  Snowstorm as an external CDN asset from `cdn.rawgit.com`, which no longer
  serves files, so in practice you will need to self-host Snowstorm for the
  effect to load — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/christmas_snow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/christmas_snow -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en christmas_snow -y
```

Enabling the module does nothing visible on its own — no snow falls until you go to
the settings form and tick *Enable snow*. See [Configuration](../configuration/index.md).

## Optional submodule — scheduling

**Christmas Snow Schedule** (`christmas_snow_schedule`) adds a date range so the
effect turns itself on and off automatically via cron:

```bash
drush en christmas_snow_schedule -y
```

It requires the base Christmas Snow module, which is already present once you have
installed the above.
