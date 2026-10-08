# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.3 or 8.4**.
- The **Key** module (`key`) — stores the RaiseDonors API token securely.
- The **Address** module (`address`) — used for donor address data.
- Core's **User**, **Views**, and **Telephone** modules (normally present; enabled as
  dependencies).
- A **RaiseDonors 2.0 account** and an API token from it.

## Install with Composer

From the project root:

```bash
composer require drupal/raisedonors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key and Address
modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/raisedonors -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en raisedonors -y
```

Drupal enables the Key, Address, and other dependencies at the same time.

## Grant permissions

Under **People → Permissions**, grant **administer raisedonors module settings** to
the roles that should configure the integration and run syncs.

## Verify it worked

Log in as an administrator and go to **Configuration → RaiseDonors**
(`/admin/config/raisedonors`). If the settings form loads, the module is installed.
Continue to [Configuration](../configuration/index.md) to store your API token and
test the connection.
