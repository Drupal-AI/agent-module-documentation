# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other modules are required — Robots DTAP has no dependencies.

There are no third-party Composer or PHP library requirements. Note this module is
currently **seeking a new maintainer** and is not covered by Drupal's security
advisory policy, so review it before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/robots_dtap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/robots_dtap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en robots_dtap -y
```

> **Heads-up: the default is "noindex everywhere".** Until you add your production
> domain(s) to the settings form, the production-domain list is empty and the
> module adds no tag. Once you add domains, every host *not* on the list gets the
> `noindex, nofollow` tag — so double-check your production domain is spelled
> correctly (see [Configuration](../configuration/index.md)) before relying on it.

## Verify it worked

Log in as an administrator and open **Configuration → System → Robots DTAP**
(`/admin/config/system/robots_dtap/settings`). If the settings form loads, the
module is installed. Configure your production domains next, then view the page
source on a non-production host and confirm the
`<meta name="robots" content="noindex, nofollow">` tag is present in the `<head>`.
