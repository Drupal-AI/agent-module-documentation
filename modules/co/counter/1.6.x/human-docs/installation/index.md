# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`matomo/device-detector`** PHP library (`^5.0.3`), used to classify
  visitors (e.g. browsers vs. crawlers) for accurate unique‑visitor counting. This
  is a Composer dependency and is installed automatically when you require the
  module with Composer.

## Install with Composer

Install with Composer so the `matomo/device-detector` library comes along
automatically:

```bash
composer require drupal/counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the device‑detector
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/counter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en counter -y
```

## Grant the permission

Counter's configuration is protected by its own **`administer counter`**
permission. Go to **People → Permissions** (`/admin/people/permissions`) and grant
it to the roles that should manage the counter (typically administrators).

## Verify it worked

Visit **Configuration → Counter settings** (`/admin/config/counter`) — you should
see the counter's basic and advanced forms. Then place the Counter block (see
[Configuration](../configuration/index.md)) and load a few pages to confirm the
counts increment.

> **Before going live on a public site**, review the privacy, trusted‑proxy, and
> page‑cache considerations described on the [overview page](../index.md) — they
> materially affect whether the counter is accurate and compliant.
