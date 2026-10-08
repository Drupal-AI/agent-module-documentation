# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Link** module (`link`) and core's **Path Alias** module
  (`path_alias`) — both ship with Drupal and are enabled automatically as
  dependencies when you turn this module on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_fix_absolute_urls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_fix_absolute_urls -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_fix_absolute_urls -y
```

That is the entire setup — there is no configuration to do.

## Verify it worked

Edit any entity with a link field, paste a full absolute URL to one of your own
pages (for example `https://your-site/some-page`), and save. Re‑open the field
and it should now hold the internal path equivalent rather than the full URL.
Genuinely external URLs are left unchanged.
