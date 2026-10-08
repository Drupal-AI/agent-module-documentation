# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Mail System** (`mailsystem`) — required. This is what lets you select SendGrid
  as the mail plugin Drupal uses.
- A **SendGrid (Twilio) account** and an **API key**.

The module uses the official SendGrid PHP library; Composer pulls in what it needs
when you require the module with `-W`.

## Install with Composer

From the project root:

```bash
composer require drupal/sendgrid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required Mail
System module and the SendGrid PHP library as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sendgrid -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sendgrid -y
```

This also enables Mail System if it is not already on.

## After enabling

1. Add your SendGrid credentials on the settings form — see
   [Configuration](../configuration/index.md).
2. Use Mail System to route the desired mail through SendGrid.

## Verify it worked

Go to **Configuration → Web services → SendGrid settings**
(`/admin/config/services/sendgrid/settings`), enter a valid API key, and send a
test email (for example trigger a password reset). With SendGrid selected in Mail
System, the message should be delivered via SendGrid and appear in your SendGrid
activity/dashboard.
