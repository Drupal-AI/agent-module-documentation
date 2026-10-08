# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **PHP 7.3 or higher**.
- Core's **Path Alias** module (`path_alias`) — enabled automatically as a
  dependency.
- A **Eulerian** account with a website domain.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eulerian -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eulerian -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eulerian -y
```

## Optional: Commerce tracking submodules

If you run Drupal Commerce and want to track e‑commerce events, enable the relevant
bundled submodules:

```bash
drush en eulerian_commerce_cart eulerian_commerce_checkout eulerian_commerce_product -y
```

| Submodule | What it tracks |
|-----------|----------------|
| `eulerian_commerce_cart` | Cart events |
| `eulerian_commerce_checkout` | Checkout events |
| `eulerian_commerce_product` | Product events |

## Optional: consent integration

To gate Eulerian behind a consent manager, add the appropriate companion project —
**Eulerian Tarte au Citron** (for Tarte au Citron) or **Eulerian TacJS** (for
TacJS) — installed separately.

## Verify it worked

Go to the Eulerian settings form (`eulerian.settings_form`), enter your Eulerian
domain (see [Configuration](../configuration/index.md)), then view a front‑end
page's source in your browser to confirm the Eulerian tracking code is present.
