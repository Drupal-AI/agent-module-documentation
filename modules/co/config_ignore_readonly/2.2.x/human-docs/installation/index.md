# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Config Ignore** (`drupal/config_ignore` `^3.0`) — enabled.
- **Config Readonly** (`drupal/config_readonly` `^1.0`) — enabled.

Both of those modules must be present and enabled for this bridge to do anything.
There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_ignore_readonly -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Config Ignore and
Config Readonly and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/config_ignore_readonly -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

Enable all three together if they aren't already on:

```bash
drush en config_ignore config_readonly config_ignore_readonly -y
```

## How Config Readonly is switched on

Config Readonly is typically activated by adding `$settings['config_readonly'] = TRUE;`
to your `settings.php` (often only on production). Consult the Config Readonly
documentation for the exact activation method your site uses — this bridge module only
affects which forms stay editable once Config Readonly is active.

## Next step

There is nothing to configure on this module. You decide which forms stay editable by
adding their config names to Config Ignore's ignore list — see
[How to use it](../index.md#how-to-use-it).
