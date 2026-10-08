# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- [**Events Log Track**](https://www.drupal.org/project/events_log_track)
  (`event_log_track`) — the module whose logs this one encrypts.
- [**Encrypt**](https://www.drupal.org/project/encrypt) (`encrypt`) — the encryption
  service framework.
- [**Key**](https://www.drupal.org/project/key) (`key`) — where your encryption key is
  stored.

Composer resolves and installs these dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/event_log_track_encrypt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed, including Events Log Track, Encrypt, and Key.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/event_log_track_encrypt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en event_log_track_encrypt -y
```

Drupal enables Events Log Track, Encrypt, and Key automatically as dependencies.

## Verify it worked

Go to **Configuration → System → Keys** and confirm a key named **Event log track
public key** now exists — that is the key you will paste your public key into. Then
open **Configuration → System → Event log track** and confirm the **Encryption**
section appears. Follow [Set it up](../index.md#set-it-up) to generate your key pair,
install the public key, and enable encryption.
