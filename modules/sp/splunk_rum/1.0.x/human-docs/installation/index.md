# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A running **Splunk Observability** environment to receive the data, and a Splunk
  RUM **access token** for it.
- No module dependencies. The **OpenTelemetry** module is recommended as a
  companion but is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/splunk_rum -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/splunk_rum -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en splunk_rum -y
```

## After installing

Go to `/admin/config/splunk-rum` and add the required parameters — your access
token, application name and environment — then save. See
[Configuration](../configuration/index.md) for the details. The RUM script is only
added once these are set.

> **A note if you use OpenTelemetry:** if you see an "Unhandled export error" from
> OpenTelemetry, check the fix referenced on the module's Drupal.org project page.
