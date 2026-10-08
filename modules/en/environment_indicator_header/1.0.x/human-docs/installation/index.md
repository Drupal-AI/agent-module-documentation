# Installation

## Requirements

- **Drupal 9.3, 10, 11, or 12** (`core_version_requirement: ^9.3 || ^10 || ^11 || ^12`).
- The **Environment Indicator** module (`environment_indicator`) — this is a hard
  dependency. Composer pulls it in automatically with the command below, and Drupal
  enables it as a dependency when you turn this module on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/environment_indicator_header -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in Environment Indicator alongside this
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/environment_indicator_header -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en environment_indicator_header -y
```

Drupal will enable Environment Indicator too if it isn't already on.

## Verify it worked

First set the release value for this environment:

```bash
drush state:set environment_indicator.current_release v1.2.44
```

Then request any page and inspect the **response HTTP headers** — for example:

```bash
curl -sI https://your-site.example | grep -i '^Release:'
```

You should see a `Release` header carrying the value you set. If nothing appears,
confirm the `environment_indicator.current_release` state value is not empty
(`drush state:get environment_indicator.current_release`).
