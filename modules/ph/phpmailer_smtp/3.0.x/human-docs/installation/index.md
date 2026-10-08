# Installation

## Requirements

- **Drupal 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- The **PHPMailer** PHP library (`phpmailer/phpmailer` `^7.1.1`) — installed
  automatically with Composer (see below).
- Access to an **SMTP server** (a mail service or your own).
- The **Mail System** module (`drupal/mailsystem`) is the recommended way to
  route Drupal's mail through this module.

## Install with Composer

From the project root:

```bash
composer require drupal/phpmailer_smtp -W
```

This installs both the module **and** the PHPMailer library. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed. (If you cannot use Composer, the module also supports the Ludwig library
manager.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/phpmailer_smtp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phpmailer_smtp -y
```

The module ships **no submodules**.

## Add the Mail System module

Enabling PHPMailer SMTP does not by itself change how Drupal sends mail — it only
provides a mail plugin. The recommended way to activate it is the Mail System
module:

```bash
composer require drupal/mailsystem -W
drush en mailsystem -y
```

You then choose PHPMailer SMTP as the sender and formatter on the Mail System
form — see [Configuration](../configuration/index.md).

## Verify it worked

Log in as an administrator and go to **Configuration → System → PHPMailer SMTP**
(`/admin/config/system/phpmailer-smtp`). You should see the SMTP transport form.
After you enter your server details, use the form's **send test email** field to
confirm delivery, and check **Configuration → System → Mail System** to make sure
PHPMailer SMTP is selected as the default sender and formatter.
