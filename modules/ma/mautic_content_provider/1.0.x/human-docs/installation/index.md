# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Mautic** installation with the **"Drupal Integrated Content"** Mautic plugin
  enabled — this is what consumes the content Drupal exposes. Without it, the
  exposed content cannot be used in your Mautic emails.

There are no third‑party Composer or PHP library requirements on the Drupal side.

## Install with Composer

From the project root:

```bash
composer require drupal/mautic_content_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mautic_content_provider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mautic_content_provider -y
```

## Verify it worked

Go to **Configuration → Web services → Mautic Content Provider**
(`/admin/config/services/mautic-content-provider`) and select some nodes and view
modes to expose. On the Mautic side, confirm the **"Drupal Integrated Content"**
plugin is enabled and can see your Drupal content. See
[Configuration](../configuration/index.md) for the details.
