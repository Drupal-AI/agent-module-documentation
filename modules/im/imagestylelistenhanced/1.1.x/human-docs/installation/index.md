# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No modules outside Drupal core, and no third‑party Composer or PHP library
  requirements.

> **Note:** This project is **not covered by Drupal's security advisory policy**.
> Weigh that before relying on it in production. It only affects the admin
> listing UI, so the exposure is small.

## Install with Composer

From the project root:

```bash
composer require drupal/imagestylelistenhanced -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagestylelistenhanced -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagestylelistenhanced -y
```

## Verify it worked

Go to **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`). The listing should now show the enhanced
overview (previews and a clearer layout) rather than the stock text-only list.
There is nothing further to configure.
