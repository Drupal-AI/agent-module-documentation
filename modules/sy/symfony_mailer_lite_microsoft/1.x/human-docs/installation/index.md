# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.3 or higher.**
- The **Symfony Mailer Lite** module (`symfony_mailer_lite`) and **Symfony HTTP
  Client for Drupal** (`symfony_http_client`) — both are dependencies.
- A **Microsoft Azure** account with a configured application (Azure Active
  Directory) granting the Microsoft Graph **Mail.Send** permission.
- Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_lite_microsoft -W
```

The Composer package name (`drupal/symfony_mailer_lite_microsoft`) matches the
module's machine name (`symfony_mailer_lite_microsoft`). The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed, and pulls in the required Symfony Mailer Lite and Symfony HTTP Client
modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_lite_microsoft -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer_lite_microsoft -y
```

## Prepare your Azure application

Before configuring the module, register an application in Azure Active
Directory, grant it the Microsoft Graph **Mail.Send** permission (with admin
consent if your tenant requires it), and note the **Client ID**, **Client
Secret**, and **Tenant ID**. Treat the client secret as a secret — store it in
an environment variable and surface it through a Key entity — and scope the app
registration minimally, since Graph mail-send permissions can be broad.

## Next steps

Enter your credentials, set the sender address, and test the connection on the
module's settings form — see [Configuration](../configuration/index.md).
