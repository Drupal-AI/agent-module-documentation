# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No module dependencies and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/call_now_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/call_now_button -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en call_now_button -y
```

## Set it up

1. Grant the module's permission to the roles that should manage the button,
   under **People → Permissions** (`/admin/people/permissions`).
2. Set the **phone number** the button should dial. Use a number meant to be
   public, since it is rendered as a `tel:` link visible in the page.

The button then appears fixed to the bottom of the screen on mobile devices, and
tapping it opens the visitor's phone dialler with your number.
