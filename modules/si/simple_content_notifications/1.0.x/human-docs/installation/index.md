# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working site mail system — the module sends its notices through Drupal's
  normal mail delivery, so your site must be able to send email.
- No other modules, PHP extensions, or third‑party libraries are required.

For the review‑notification half you will also need a **date field** on your
content that records when each item was last reviewed. You provide that field's
machine name in the settings; the module does not create the field for you.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_content_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_content_notifications -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_content_notifications -y
```

## After enabling

1. Grant the **Administer Content Notifications** permission to the roles that
   should manage notifications (**People → Permissions**). Users with this
   permission can reach both settings forms.
2. Configure the change notifications and (optionally) the review notifications —
   see [Configuration](../configuration/index.md).

Nothing is emailed until you have set at least one recipient and chosen the content
types to watch, so plan on a short configuration pass after install.
