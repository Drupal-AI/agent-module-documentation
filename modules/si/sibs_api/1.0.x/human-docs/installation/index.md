# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **contract with SIBS** to activate the payment API for your site, and the
  **merchant credentials (API keys)** that come with it.

No other Drupal modules and no third-party PHP libraries are declared as required for
the base module itself. (The modules that build on it — such as SIBS API Commerce —
add their own dependencies.)

## Install with Composer

From the project root:

```bash
composer require drupal/sibs_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sibs_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sibs_api -y
```

## Store your credentials as secrets

Before wiring up payments, put your SIBS merchant credentials somewhere safe — an
environment variable or a **Key** entity — rather than pasting a permanent secret into
plain configuration. These keys authorise real payment operations, so keep them out of
version control and make sure the site is served over HTTPS.

## Next step

On its own this base library has no storefront. To actually take payments, add a module
that builds on it — for example **SIBS API Commerce** for Drupal Commerce — and follow
its setup.
