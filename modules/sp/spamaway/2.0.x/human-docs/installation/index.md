# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Webform** module (`webform`) enabled — SpamAway is a Webform
  handler, so Webform is a hard dependency.

There are **no Composer library dependencies** beyond Webform itself.

## Install with Composer

From the project root:

```bash
composer require drupal/spamaway -W
```

If you don't already have Webform, add it too:

```bash
composer require drupal/webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/spamaway -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spamaway -y
```

Drupal enables Webform at the same time if it isn't already on. Enabling SpamAway
does **not** protect any form yet — nothing happens until you add the SpamAway
handler to a webform. Continue with [Configuration](../configuration/index.md).

## Verify it worked

Go to **Structure → Webforms**, open any webform, and choose **Settings → Emails /
Handlers → Add handler**. You should see **SpamAway - Anti spam handler** in the list
(category "Anti-SPAM"). If it's there, the module is installed correctly.
