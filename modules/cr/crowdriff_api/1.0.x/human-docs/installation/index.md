# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Key** module (`key`) — stores the CrowdRiff API token securely.
- A **CrowdRiff API key** — required to access the API service.

There are no third-party PHP library requirements. Remember this module only
provides the integration; to actually display CrowdRiff assets you'll pair it with a
consumer such as
[Media Library Crowdriff](https://www.drupal.org/project/media_library_extend_crowdriff),
or your own code.

## Install with Composer

From the project root:

```bash
composer require drupal/crowdriff_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crowdriff_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crowdriff_api -y
```

The Key module will be enabled alongside it if it isn't already.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → Crowdriff**
(`/admin/config/services/crowdriff`). You should see the settings form. To make the
integration functional, store your API key and select it there — see
[Configuration](../configuration/index.md).
