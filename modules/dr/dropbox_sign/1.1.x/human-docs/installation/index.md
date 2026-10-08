# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Encryption** module (`encryption`) — used to store your API key encrypted;
  it's a hard dependency.
- The **Dropbox Sign PHP SDK** — the library the module talks to the API through,
  pulled in by Composer.
- A **Dropbox Sign account** with an API key and a client ID.

## Install with Composer

From the project root:

```bash
composer require drupal/dropbox_sign -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including the Encryption module and the Dropbox Sign PHP SDK — as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dropbox_sign -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dropbox_sign -y
```

Drush enables the Encryption module automatically as a dependency. You may need to
configure an encryption profile/key for the Encryption module so the API key can
be stored encrypted — see that module's documentation.

## Verify it worked

1. Go to **Configuration → System → Dropbox Sign API**
   (`/admin/config/system/dropbox-sign`) and confirm the settings form loads.
2. Enter your API key and client ID (see [Configuration](../configuration/index.md)).
3. From code, call `\Drupal::service('dropbox_sign')->getSignatureRequestApi()` (or
   run a small test request) to confirm the credentials are accepted — turn on
   **Test mode** first so no live requests are created.
