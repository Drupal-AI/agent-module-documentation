# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9||^10||^11||^12`).
- Core's **Telephone** module (`telephone`), enabled automatically as a
  dependency.
- An **Android phone** and the companion *send sms* app (the project links to an
  APK, roughly 6 MB) to actually dispatch the messages. You can also build the app
  yourself from the `sms-android` source folder included with the project.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sms_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sms_message -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sms_message -y
```

## Verify it worked

Go to **`/admin/content/sms-message`** — you should see the SMS message management
screen. The module also provides a unique token for the API endpoint on its
settings page.

## Next step

Set the endpoint token and connect your Android app — see
[Configuration](../configuration/index.md).
