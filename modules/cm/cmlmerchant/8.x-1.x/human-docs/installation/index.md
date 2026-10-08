# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **[catalog](https://www.drupal.org/project/catalog)** (`catalog`) — provides the
  catalog taxonomy the feeds are built from.
- **[cmlstarter](https://www.drupal.org/project/cmlstarter)** (`cmlstarter`) — the
  CML Starter storefront structure. Both are required dependencies.
- A **working cron** so feeds regenerate on schedule.

There are no third‑party PHP library requirements.

> **Note:** this project is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/cmlmerchant -W
```

The `-W` (`--with-all-dependencies`) flag brings in the `catalog` and `cmlstarter`
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cmlmerchant -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmlmerchant -y
```

The `catalog` and `cmlstarter` dependencies are enabled automatically if they aren't
already.

## Verify it worked

Go to **Configuration → cmlmerchant → Settings**
(`/admin/config/cmlmerchant/settings`) and confirm the form loads. Then let cron run
(or trigger regeneration with the module's Drush command) and visit
`/cmlmerchant/google-feed.xml` — you should see the generated feed. Until the files
are generated, the feed routes return a small placeholder instead of XML. Continue
to [Configuration](../configuration/index.md).
