# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- The **Webform** module 6.3 or newer (`drupal/webform:>=6.3`). Composer installs it
  for you if it is not already present.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_spam_words -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Webform and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_spam_words -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_spam_words -y
```

Drush enables the Webform dependency automatically. There are no submodules.

## Verify it worked

Two checks:

- The global defaults form is reachable at
  `/admin/config/webform/webform-spam-words`.
- When you edit a webform's **Handlers** and click **Add handler**, **Webform Spam
  Words** appears in the list.

Remember: enabling the module does not block anything yet. You must attach the
handler to a webform and give it real settings — see
[Configuration](../configuration/index.md).
