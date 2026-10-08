# Installation

## Requirements

- **Drupal 9.1 or newer, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The **API Tools** module (`apitools`), which provides the client framework Zoom
  API registers with. It is a hard dependency and Composer pulls it in
  automatically.
- A **Zoom account** with an app that provides API credentials and lets you
  configure a webhook with an Event Secret Token.

There are no third-party Composer or PHP library requirements.

> **Compatibility caution:** `apitools` has been reported to fatal on some
> Symfony 7 / Drupal 11 combinations. Verify that the API Tools client loads on
> your setup before relying on this module in production.

## Install with Composer

From the project root:

```bash
composer require drupal/zoomapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including API Tools — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/zoomapi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with API Tools:

```bash
drush en apitools zoomapi -y
```

## Next steps

Configure the Zoom credentials and Event Secret Token on the API Tools client
form, then point your Zoom app's webhook at your site. See
[Configuration](../configuration/index.md).

There are no submodules.
