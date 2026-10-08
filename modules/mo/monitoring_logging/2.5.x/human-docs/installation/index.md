# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- The **Monitoring** module (`monitoring`) — this module logs Monitoring's sensor
  results, so Monitoring must be installed with sensors configured.

## Install with Composer

From the project root:

```bash
composer require drupal/monitoring_logging -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Monitoring
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monitoring_logging -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monitoring_logging -y
```

## Submodule — Nagios-readable output (optional)

If you want the log formatted so the Drupal Nagios plugin can read it, also enable
the bundled submodule:

```bash
drush en monitoring_logging_check_drupal -y
```

It requires the base Monitoring Logging module, which is already present once you
have installed it above.

## Verify it worked

With Monitoring running its sensors, sensor results will be recorded to the log
(the shipped example implementation logs to a file). Trigger or wait for a sensor
run and confirm that sensor-result entries appear in the configured log output.
