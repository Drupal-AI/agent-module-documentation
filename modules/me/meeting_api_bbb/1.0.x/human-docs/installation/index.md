# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Meeting API** module (`meeting_api`) — the framework this provider plugs
  into.
- The **Key** module (`key`) — used to store the BigBlueButton shared secret
  securely rather than in plain configuration.
- A reachable **BigBlueButton server**, with its **server URL** and a **shared
  secret** generated using a supported (non‑SHA‑1) hashing algorithm.

Installing this module with Composer pulls in Meeting API and Key as dependencies.
There are no PHP library requirements. Note this is an early **alpha** release.

## Install with Composer

From the project root:

```bash
composer require drupal/meeting_api_bbb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Meeting API and Key
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/meeting_api_bbb -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en meeting_api_bbb -y
```

Meeting API and Key are enabled automatically as dependencies if they are not
already on.

## Verify it worked

Once you have stored the shared secret as a Key and set the BBB server URL (see
[Configuration](../configuration/index.md)), create a meeting of a BigBlueButton‑backed
type in Meeting API and confirm the meeting is created on your BBB server without an
authentication error. An auth failure usually means the shared secret or hashing
algorithm does not match the server (see the SHA‑1 note on the
[overview page](../index.md)).
