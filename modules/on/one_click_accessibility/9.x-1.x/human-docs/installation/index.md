# Installation

## Requirements

One Click Accessibility is lightweight and depends only on Drupal core:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2||^10||^11`).
- No other contrib modules and no third‑party Composer or PHP libraries.

> **Note on security coverage:** this project is *not* covered by Drupal's
> security advisory policy (`security_advisory_coverage: not-covered`). Because
> the widget is purely a client‑side display aid — it changes nothing about
> content or access — the risk is low, but it is worth knowing before you deploy.

## Install with Composer

From the project root:

```bash
composer require drupal/one_click_accessibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/one_click_accessibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en one_click_accessibility -y
```

## Verify it worked

The module ships no block placement of its own, so after enabling it head to
**Structure → Block layout**, place the **One Click Accessibility** block in a
region, and reload a front‑end page — the accessibility widget should appear on
the side you chose. See [Configuration](../configuration/index.md) for placing
the block and tuning its options.
