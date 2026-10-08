# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (always present on a Drupal site).
- No third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/change_mail_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/change_mail_page -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en change_mail_page -y
```

## Verify it worked

Log in as a non‑administrator user and open your profile. You should see a new
**Change Email** tab, and the email field should no longer appear on your main
account‑edit form. Visiting `/user/change-mail` should take you straight to your
own change page, where changing the email requires your current password.
