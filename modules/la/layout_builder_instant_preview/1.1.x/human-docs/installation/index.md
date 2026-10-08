# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Layout Builder
  Instant Preview.

There are no third‑party Composer or PHP library requirements.

> **Security advisory coverage:** this project is **not covered** by Drupal's
> security advisory policy, and it is **minimally maintained**. Weigh that before
> relying on it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_instant_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_instant_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_instant_preview -y
```

## Verify it worked

Open a Layout Builder layout, add or edit a custom (inline) block, and start
changing its form fields. The preview in the off‑canvas sidebar should update as
you type rather than only after you save. If it does, the module is working.
