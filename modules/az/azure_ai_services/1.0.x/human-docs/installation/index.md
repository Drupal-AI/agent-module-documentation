# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **Azure AI / Cognitive Services** resource with an endpoint and access key,
  created in the Azure portal. This is a paid Microsoft service.

There are no other module dependencies and no third‑party Composer or PHP library
requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/azure_ai_services -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/azure_ai_services -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en azure_ai_services -y
```

After enabling, configure the Azure connection — see
[Configuration](../configuration/index.md).
