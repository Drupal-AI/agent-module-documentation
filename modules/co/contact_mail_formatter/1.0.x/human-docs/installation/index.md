# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or newer** (`php_requirement: 7.4`).
- Core's **Contact** module (`contact`) — provides the forms whose emails are
  formatted.
- The **Token** module (`token`) — provides the token browser and token support.
- Recommended: the **SMTP** module, configured to send HTML. The project notes SMTP
  is pulled in when you install via Composer; you then need to enable it as your
  mail system and switch on "Allow to send emails formatted as HTML" so your
  transport actually delivers HTML mail.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_mail_formatter -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the Token dependency (and the
SMTP module) and updates any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_mail_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_mail_formatter -y
```

Drupal enables the Contact and Token modules too if they aren't already on.

## Set up HTML mail delivery (recommended)

For the HTML formatting to reach recipients, your mail transport must send HTML. If
you use the SMTP module:

1. Go to **Configuration → System → SMTP Authentication Support**
   (`/admin/config/system/smtp`).
2. Enable SMTP as the default mail system.
3. Enter your SMTP server details (server, port, and the authentication username
   and password your mail provider gives you).
4. Enable the **"Allow to send emails formatted as HTML"** option.

## Verify it worked

Edit a contact form at **Structure → Contact forms** — you should see a new **Mail
Formatter** section on the form. See [Configuration](../configuration/index.md) for
enabling HTML mail and choosing a template, then submit a test message and confirm
it arrives as formatted HTML.
