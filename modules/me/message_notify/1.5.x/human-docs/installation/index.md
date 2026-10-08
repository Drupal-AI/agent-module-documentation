# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Message** module (`drupal/message`, `^1.0`), which provides the Message
  entity this framework renders and delivers. Composer pulls it in as a
  dependency.

There are no third‑party PHP library requirements. Email delivery uses Drupal
core's mail system; other channels (SMS, push, etc.) need a notifier you add.

## Install with Composer

From the project root:

```bash
composer require drupal/message_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Message module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_notify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_notify -y
```

On enable, the module creates the two Message view modes (`mail_subject` and
`mail_body`) and, for each existing message template, the matching view displays.
There is no settings page and no permissions — you use the module from code, as
shown in the [overview](../index.md#how-to-use-it).

## Optional submodule — example

Message Notify ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Message Notify Example** | `message_notify_example` | A worked example showing how to trigger a notification from an entity event (e.g. emailing a node's author on a new comment). Useful as a reference, not needed in production. |

Enable it only to study the example:

```bash
drush en message_notify_example -y
```
