# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A project that manages patches with **`cweagans/composer-patches`** (the module
  reads your Composer patch information), and access to the site's `composer.json`.
- No additional Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/patch_info -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/patch_info -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en patch_info -y
```

## Configure and verify

After enabling, do the one‑time setup described in the overview:

1. Go to **Administration → Configuration → Patch information** and open the
   **Patch config form**.
2. Point it at your **`composer.json`**, test that the path exists, and save.
3. Fetch the API records.

Then browse to **`/patch-info`** — you should see a summary of the patches applied
to your site. If the list reflects the patches in your `composer.json`, the module
is working.
