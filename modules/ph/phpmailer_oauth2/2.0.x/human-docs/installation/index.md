# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[PHPMailer SMTP](https://www.drupal.org/project/phpmailer_smtp)** module
  (`drupal/phpmailer_smtp ^2.1`) — a hard dependency. It provides the SMTP mail
  transport and the OAuth2 plugin type this module plugs into.
- The **`thenetworg/oauth2-azure`** Composer library (`^2.0.1`), which builds the
  Azure OAuth2 provider. Composer pulls it in automatically.
- An **Azure AD app registration** with the `SMTP.Send` delegated permission and a
  client secret (set up during [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/phpmailer_oauth2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in PHPMailer SMTP and
the Azure OAuth2 library and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/phpmailer_oauth2 -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phpmailer_oauth2 -y
```

This also enables PHPMailer SMTP if it is not already on. There are no submodules.

## Next step

You still need to register an Azure app, fill in the settings form, and run the
token‑exchange flow before mail will send — see
[Configuration](../configuration/index.md).
