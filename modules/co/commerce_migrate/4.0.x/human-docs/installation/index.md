# Installation

## Requirements

- **Drupal 9.3+ / 10** (`core_version_requirement: >=9.3 || 10`). This branch is a
  Drupal 10 contrib release; there is no Drupal 11 release.
- Core's **Migrate** module (`migrate`) and the **Telephone** module
  (`telephone`).
- The **Migrate Plus** module (`migrate_plus`), which provides the CSV source
  plugins used by the SaaS-platform submodules.
- The **Migrate Tools** module (`migrate_tools`) is what you actually run the
  migrations with (`drush migrate:import`, `migrate:status`, `migrate:rollback`).
  Install it alongside Commerce Migrate.
- **Drupal Commerce 2** installed as the destination for the migrated data.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_migrate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Migrate Plus and
any shared dependencies. It's convenient to add Migrate Tools at the same time:

```bash
composer require drupal/migrate_tools -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/commerce_migrate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module and the **submodule that matches your source platform** —
the base module alone provides only shared infrastructure:

```bash
drush en commerce_migrate -y
# then the submodule for your source, e.g.:
drush en commerce_migrate_ubercart -y
```

## Submodules

| Submodule | Machine name | Source | Stability |
|-----------|--------------|--------|-----------|
| Commerce (1 → 2) | `commerce_migrate_commerce` | Drupal Commerce 1 database | Stable |
| Ubercart | `commerce_migrate_ubercart` | Ubercart 6/7 database | Stable |
| Magento | `commerce_migrate_magento` | Magento 2 CSV export | Experimental |
| Shopify | `commerce_migrate_shopify` | Shopify CSV export | Experimental |
| WooCommerce | `commerce_migrate_woocommerce` | WooCommerce 3 CSV export | Experimental |
| CSV example | `commerce_migrate_csv_example` | Sample CSV | Example/template |

The experimental submodules are provided as starting points and have limited
coverage — expect to extend them for a real store.

## Verify it worked

With the base module and a source submodule enabled and your source configured
(database connection or CSV paths), run:

```bash
drush migrate:status
```

Your platform's migrations should be listed. From there, run
`drush migrate:import …` to perform the migration — see "How to use it" in the
[overview](../index.md).
