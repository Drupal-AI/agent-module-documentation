# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Media Remote** module (`media_remote`) — Media Qualtrics builds its
  formatter on top of it. It is pulled in automatically as a dependency when you
  install with Composer.
- **Optional:** the **CSP** module (`drupal/csp`). If present, the module adds your
  allowed Qualtrics hosts to the `frame-src` Content-Security-Policy directive so the
  embeds are not blocked. It is not required.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_qualtrics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Media Remote and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_qualtrics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_qualtrics -y
```

This enables Media Remote too if it is not already on.

## Next steps

Add a text field to hold the survey URL and set its display format to **Remote
Media - Qualtrics** (see [How to use it](../index.md#how-to-use-it)). If you embed
from a custom Qualtrics domain, add it to the allowed-hosts list — see
[Configuration](../configuration/index.md).
