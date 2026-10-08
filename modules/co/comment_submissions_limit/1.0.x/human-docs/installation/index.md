# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Comment** module (`comment`) enabled.

There are no third‑party Composer or PHP library requirements. Note this is a
**beta** release — test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/comment_submissions_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comment_submissions_limit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_submissions_limit -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to define your
submission limits on a comment type. To test, set a low
limit over a short interval, then submit comments quickly as a non‑privileged user
— once you exceed the rate, further submissions should be blocked until the window
passes.
