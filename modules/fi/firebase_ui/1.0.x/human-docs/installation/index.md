# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- A **Firebase project** with **Firebase Cloud Messaging (FCM)** enabled.
- The PHP libraries **`google/auth`** and **`guzzlehttp/guzzle`**, installed via
  Composer (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/firebase_ui -W
```

The module also needs the Google Auth and Guzzle libraries. If they aren't already
present in your project, require them too:

```bash
composer require google/auth guzzlehttp/guzzle
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/firebase_ui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en firebase_ui -y
```

Enabling the module adds a `field_firebase_tokens` field to the user entity, which
it uses to store and manage device tokens automatically.

## Processing the notification queue

Notifications are sent through a queue named `firebase_ui_notification_queue`.
Drupal **cron** processes it automatically, so make sure cron runs regularly. To
process it on demand, run:

```bash
drush queue:run firebase_ui_notification_queue
```

## Verify it worked

Visit **Configuration → Web services → Firebase UI → Settings**
(`/admin/config/services/firebase-ui/settings`). You should see the credentials
form. Enter your Firebase project details there — continue to
[Configuration](../configuration/index.md) for the field-by-field walkthrough and
how to send your first notification.
