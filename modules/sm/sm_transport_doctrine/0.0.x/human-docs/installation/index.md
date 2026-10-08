# Installation

## Requirements

- **Drupal 10.1 or newer** (`core_version_requirement: >=10.1`).
- The **DBAL** module (`dbal`) — pulled in by Composer.
- This project must have its dependencies managed with **Composer**.
- The **Symfony Messenger** (`sm`) module, which this provides a transport for.

## Install with Composer

From the project root:

```bash
composer require drupal/sm_transport_doctrine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `dbal` and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sm_transport_doctrine -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sm_transport_doctrine -y
```

Once enabled, the transport is available immediately under the **`doctrine`**
alias. Configure a Symfony Messenger transport to use it, and set up multiple
transports through container parameters if you need them.

> **Consider the built-in transport first.** SM v0.2.0 and later ships a Drupal
> database native transport via the `drupal-db://` protocol. Consider using that
> before the Doctrine transport unless you specifically want the Doctrine DBAL
> implementation.
