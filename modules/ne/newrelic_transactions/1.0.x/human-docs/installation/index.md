# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **New Relic PHP extension** must be installed and active on your web server.
  This is a server-level requirement, not a Composer package — the module hands
  transaction names to New Relic through the extension, so without it the module
  has nothing to report to.
- No contrib module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/newrelic_transactions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/newrelic_transactions -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix. Note that the
> New Relic PHP extension must be present in whatever environment actually serves
> production traffic to New Relic.

## Enable the module

```bash
drush en newrelic_transactions -y
```

## Verify it worked

1. Open the **Status report** at **Reports → Status report**
   (`/admin/reports/status`) and confirm the module reports that it is functioning
   correctly. If the New Relic PHP extension is missing, this is where you will see
   it flagged.
2. Review the settings at **Configuration → Development → New Relic Transactions**
   (`/admin/config/development/newrelic-transactions`).
3. Generate some page traffic and check your New Relic APM: transactions should now
   be named by route, entity bundle, and highest-weight role rather than showing up
   as `index.php`.
