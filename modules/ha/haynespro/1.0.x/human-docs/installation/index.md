# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **Key** module (`key`) — a hard dependency, used to store the HaynesPro API
  credentials. Composer pulls it in automatically with the command below.
- A **HaynesPro account** with API credentials, since the module is only useful
  once it can authenticate against HaynesPro's service.

> **Alpha and minimally maintained, not security-advisory covered.** This is a
> `1.0.0-alpha3` release, marked minimally maintained and not covered by
> Drupal's security advisory policy. Evaluate it carefully before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/haynespro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/haynespro -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en haynespro -y
```

This also enables the Key module if it wasn't already on. If you don't yet have
Key:

```bash
drush en key -y
```

## Verify it worked

Once enabled, the module can integrate with HaynesPro — but it won't return data
until you have supplied valid API credentials. Continue to
[Configuration](../configuration/index.md) to store those credentials securely
via a Key entity and connect Drupal to the service.
