# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- A **working mail setup**. The module sends email on every login, so Drupal must
  be able to deliver mail. The maintainers recommend the
  [SMTP](https://www.drupal.org/project/smtp) module, but any mailing module that
  handles Drupal's outbound mail will do.

There are no other module dependencies and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/loginnotification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/loginnotification -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en loginnotification -y
```

## Verify it worked

1. Confirm mail delivery works on your site (send a test message, or check your
   SMTP configuration).
2. Edit a test user's profile, tick **Login notification**, and save.
3. Log in as that user. An email should arrive at the account's address
   confirming the login and offering a one‑time "close all sessions" link. Click
   the link and confirm the account's sessions are ended.
