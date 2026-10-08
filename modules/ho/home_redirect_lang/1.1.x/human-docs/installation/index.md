# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5||^11`).
- A **multilingual** site — the module only makes sense when you have more than
  one language configured and a language switcher available.
- No other contrib modules are required, and there are no third‑party Composer or
  PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/home_redirect_lang -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/home_redirect_lang -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en home_redirect_lang -y
```

## Disable Internal Page Cache for anonymous users

For the redirect to work for anonymous visitors, disable core's **Internal Page
Cache** module — it serves an identical cached page to all anonymous users and
would prevent the per‑visitor redirect:

```bash
drush pmu page_cache -y
```

(The dynamic page cache and other caches can stay on.)

## Verify it worked

As a visitor, change the site language using the language switcher (this sets the
preference cookie), then return to the homepage in a different language — you
should be redirected to the front page in your chosen language. To enable
first‑visit handling, see [Configuration](../configuration/index.md).
