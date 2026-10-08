# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Token** module (`token`), enabled as a dependency — it lets the greeting
  template include tokens such as the user's name.
- A **birthday field** on your user accounts for the module to read.
- **Cron** running reliably (at least daily), since greetings are sent on cron.

There are no third-party Composer or PHP library requirements. The Token module is a
contributed dependency that Composer pulls in with the `-W` flag.

## Install with Composer

From the project root:

```bash
composer require drupal/birthday_wish_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch and update the Token
dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/birthday_wish_mail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en birthday_wish_mail -y
```

Drupal enables the Token dependency automatically. After enabling, continue to
[Configuration](../configuration/index.md) to choose the birthday field and write the
email template.
