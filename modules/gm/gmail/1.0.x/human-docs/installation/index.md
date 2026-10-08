# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Google API PHP client** (`google/apiclient`) — the library that talks to
  the Gmail API.
- **PHPMailer** (`phpmailer/phpmailer`) — used to build the messages. It is an
  *unbundled* dependency, so you install it with Composer yourself.
- A **Google account** (or Google Workspace account) you want to send mail from,
  and access to the **Google Cloud console** to create OAuth credentials.

## Install with Composer

From the project root, pull in the module and its two libraries:

```bash
composer require drupal/gmail -W
composer require google/apiclient phpmailer/phpmailer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gmail -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gmail -y
```

## Verify it worked

Go to **Configuration → System → Gmail API** (`/admin/config/system/gmail`). If the
settings form loads with fields for a client id and secret, the module and its
libraries are installed correctly. Continue with
[Configuration](../configuration/index.md) to connect it to Google and select it
as your mailer.
