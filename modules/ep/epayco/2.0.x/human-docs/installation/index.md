# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`). The base
  module depends only on core's **System**.
- An **ePayco account** with your API credentials (public key, private key, and the
  related identifiers ePayco issues).
- For the Commerce gateway submodule: **Drupal Commerce** (`commerce`) installed.
- No third‑party Composer or PHP library requirements are declared.

> **Upgrading from the old Commerce ePayco?** This module is a reworked
> continuation. If you used the previous version, **uninstall it before** installing
> this one.

## Install with Composer

From the project root:

```bash
composer require drupal/epayco -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/epayco -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module:

```bash
drush en epayco -y
```

## Submodules — enable only what you need

The project ships several submodules on top of the base module:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Commerce ePayco** | `commerce_epayco` | The Drupal Commerce payment gateway — off‑site (redirect) and "on‑page" (iframe) ePayco payments. Enable this only when Drupal Commerce is installed. |
| **ePayco API** | `epayco_api` | The API client/service used to talk to ePayco (used by the Commerce gateway and available for your own custom implementations). |
| **ePayco Business Rules** | `epayco_business_rules` | Basic integration with the Business Rules module. Note the project states this is **not yet supported on Drupal 10+** until a compatible Business Rules release exists. |

For example, to run ePayco with Drupal Commerce:

```bash
drush en commerce_epayco -y
```

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) and create an
ePayco settings entity with your credentials. Then, if you enabled Commerce ePayco,
add ePayco as a payment gateway under **Commerce → Configuration → Payment
gateways** and run a test transaction in ePayco's test mode before going live.
