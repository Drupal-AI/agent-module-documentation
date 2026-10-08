# Installation

## Requirements

- **Drupal 9.5 or 10** (`core_version_requirement: ^9.5 || ^10`).
- **PHP 7.4 or newer**.
- Core's **Datetime** module (`datetime`), which Drupal enables as a dependency.
- The **Buckaroo PHP SDK** (`buckaroo/sdk`), which Composer pulls in
  automatically when you require the module.
- A Buckaroo merchant account with a **website key** and **secret key**.
- For the Webform integration, the **Webform** module (`drupal/webform`).

## Install with Composer

From the project root:

```bash
composer require drupal/buckaroo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and this is what pulls in the `buckaroo/sdk` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/buckaroo -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en buckaroo -y
```

To take payments from a webform, also enable the submodule (it requires the
Webform module):

```bash
drush en buckaroo_webforms -y
```

## Next step

Enter your Buckaroo credentials and choose test or live mode before you try to
take any payment — see [Configuration](../configuration/index.md).
