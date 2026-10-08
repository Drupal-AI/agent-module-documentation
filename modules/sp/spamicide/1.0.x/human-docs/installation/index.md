# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no module dependencies, no third-party Composer packages, and no PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/spamicide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/spamicide -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spamicide -y
```

On install, Spamicide automatically creates protection for five common core
forms:

- the site-wide contact form (`contact_message_feedback_form`),
- the personal contact form (`contact_message_personal_form`),
- the user registration form (`user_register_form`),
- the user login form (`user_login_form`),
- and the default comment form (`comment_comment_form`).

## Next step

Add protection to any other forms and adjust the settings — continue to
[Configuration](../configuration/index.md).
