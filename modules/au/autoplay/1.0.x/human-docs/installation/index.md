# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Webform** module (`webform:webform`) — this is a required dependency;
  AutoPlay works by attaching a handler to Webforms.
- PHP's **SOAP** extension, since leads are delivered to AutoPlay over SOAP.
- Network access to AutoPlay's Lead API endpoint (sandbox or production).

## Install with Composer

From the project root:

```bash
composer require drupal/autoplay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autoplay -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autoplay -y
```

Enabling AutoPlay also enables Webform if it isn't already on. The module ships no
submodules. Once enabled, continue to [Configuration](../configuration/index.md) to
set your DealershipId and endpoint and to attach the handler to a form.
