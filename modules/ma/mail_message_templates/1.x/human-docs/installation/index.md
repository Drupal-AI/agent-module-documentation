# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, no third‑party Composer packages, and no PHP library
  requirements.

Before you install, note that this project is **minimally maintained** and is
**not covered** by Drupal's security advisory policy — factor that into your
decision for a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/mail_message_templates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mail_message_templates -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_message_templates -y
```

## Verify it worked

Log in as an administrator and confirm you can create an email template from the
admin UI. Create a simple template with a subject and body, then check that it can
be exported with your site configuration. See the
[overview](../index.md#how-to-use-it) for how to work with templates.
