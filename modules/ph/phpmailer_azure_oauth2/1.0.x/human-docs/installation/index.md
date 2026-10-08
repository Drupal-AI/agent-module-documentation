# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **[PHPMailer SMTP](https://www.drupal.org/project/phpmailer_smtp)** module
  (`phpmailer_smtp`) — the base SMTP sender this plugs into.
- The **[Key](https://www.drupal.org/project/key)** module (`key`) — used to store
  the OAuth2 client secret securely.
- A **Microsoft Entra ID (Azure AD)** application you can register, with permission
  to send mail for the target mailbox.

Composer pulls in the module dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/phpmailer_azure_oauth2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the PHPMailer SMTP
and Key modules and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phpmailer_azure_oauth2 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phpmailer_azure_oauth2 -y
```

Drupal enables the PHPMailer SMTP and Key modules automatically as dependencies if
they are not already on.

## Verify it worked

Log in as an administrator and go to **Configuration → System → PHPMailer Azure
OAuth2** (`/admin/config/system/phpmailer-azure-oauth2`). If the settings form
loads, the module is installed. Then follow the [Configuration](../configuration/index.md)
page to register your Entra ID app, store the client secret, and authorise the
connection.
