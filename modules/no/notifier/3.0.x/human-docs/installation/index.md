# Installation

## Requirements

- **Drupal 10.3 or newer** (`core_version_requirement: >=10.3`).
- **PHP 8.3** — this is a hard requirement; the module will not install on an
  older PHP.
- One or more **channel modules** for the delivery methods you want:
  [Notifier Email Channel](https://www.drupal.org/project/notifier_email_channel),
  [Notifier Chat Channel](https://www.drupal.org/project/notifier_chat_channel),
  and/or the SMS channel (via the SMS Framework). Notifier on its own is the
  framework; a channel is what actually sends.

## Install with Composer

From the project root:

```bash
composer require drupal/notifier -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will also pull in the Symfony Notifier
component that this module wraps.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notifier -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en notifier -y
```

Then enable the channel module(s) you need, for example:

```bash
drush en notifier_email_channel -y
drush en notifier_chat_channel -y
```

## Verify it worked

After enabling Notifier and a channel, configure a transport for that channel
(see [Configuration](../configuration/index.md)) and send a test notification
from custom code to a recipient you control. If the message arrives through the
expected channel, the integration is working. If it does not, check that the
channel module is enabled and that the transport's DSN/credentials are correct
and reachable.
