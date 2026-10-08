# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies — it depends on Drupal core only.
- It adjusts Drupal's default **PHP mailer**, so it is most relevant when your site
  sends mail through core's built‑in mail system.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/phpmail_alter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phpmail_alter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phpmail_alter -y
```

## Verify it worked

Open the PhpMail Alter settings form from the **Configuration** area (config
`phpmail_alter.settings`) and confirm it loads. Adjust the options to suit your mail
setup, save, and send a test email to check the headers — see "How to use it" on the
[overview page](../index.md).
