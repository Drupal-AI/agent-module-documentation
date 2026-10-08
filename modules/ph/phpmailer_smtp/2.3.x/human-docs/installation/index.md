# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **PHPMailer library** (`phpmailer/phpmailer` `^6.11.0`). When you install
  the module with Composer this library is pulled in automatically. (If you cannot
  use Composer, the module also supports the Ludwig library‑download workflow — see
  the project page.)

There are no other Drupal module dependencies. To route your mail through it you
will most likely also want the **Mail System** module (`drupal/mailsystem`), which
is the recommended way to activate the plugin — that is covered in
[Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/phpmailer_smtp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it is what brings in the `phpmailer/phpmailer` library
alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phpmailer_smtp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phpmailer_smtp -y
```

**Important:** enabling the module does not change how your site sends mail yet. On
its own it simply makes the PHPMailer SMTP option available. You must point
Drupal's mail system at it — see [Configuration](../configuration/index.md).

## Grant the permission

At **People → Permissions**, grant **Administer PHPMailer SMTP settings** to the
administrators who should manage the SMTP connection. This is a security‑sensitive
permission — it exposes SMTP credentials and controls how all site mail is sent —
so grant it only to trusted users.

## Verify it worked

Visit **Configuration → System → PHPMailer SMTP**. The settings form should load.
Once you have activated the plugin and entered your SMTP details (see
Configuration), use the form's test‑email field to confirm delivery.
