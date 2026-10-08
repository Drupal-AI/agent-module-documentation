# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Key** module (`key`), which Braintree API depends on — it is used to
  store your Braintree private key securely rather than in plain config. Drupal
  enables it automatically as a dependency.
- A Braintree account with API credentials (merchant ID, public key, private key)
  for either the sandbox or production environment.
- Outbound HTTPS access from the server to Braintree so the SDK can reach the
  gateway.

## Install with Composer

From the project root:

```bash
composer require drupal/braintree_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the Braintree PHP SDK and the Key module) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/braintree_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en braintree_api -y
```

This also enables the Key module if it is not already on.

## Submodule

Braintree API ships a test submodule, **`braintree_api_test`**, used for
automated testing of the integration. You do not need it on a normal site — leave
it disabled in production. Enable it only if you are writing or running tests
against the module:

```bash
drush en braintree_api_test -y
```

## Next step

Before the module can talk to Braintree you must enter your credentials and store
the private key as a secret — see [Configuration](../configuration/index.md).
