# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`) and **PHP 8.1+**.
- Core's **System** module (always present).
- The **Key** module (`key`) — used to store the Jotform API key securely. Composer
  pulls it in as a dependency.
- A **Jotform account** with an **API key scoped to Full Access** — a read‑only key
  can list forms but cannot create submissions.

## Install with Composer

From the project root:

```bash
composer require drupal/jotform_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jotform_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jotform_api -y
```

If the Key module wasn't already enabled, enable it too:

```bash
drush en key -y
```

## Verify it worked

Go to **Configuration → Web services → Jotform API**
(`/admin/config/services/jotform-api`). Once you've stored your API key and
configured the connection (see [Configuration](../configuration/index.md)), the
module should be able to list your Jotform forms — at which point you can place one
as a block, field, or auto‑route.
