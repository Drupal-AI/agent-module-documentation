# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **[Message](https://www.drupal.org/project/message)** 1.x (`drupal/message`) —
  the entity framework Message UI provides the interface for.
- Core's **Views** module (`views`), which Message UI uses for its listings and
  operation links. Views ships with Drupal core.

Composer pulls in Message automatically; Views is part of core and just needs to
be enabled (Drupal handles that as a dependency).

## Install with Composer

From the project root:

```bash
composer require drupal/message_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/message_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_ui -y
```

Drush enables Message and Views automatically if they are not already on. After
enabling, visit **People → Permissions** to grant the message permissions your
roles need — see [Configuration](../configuration/index.md).

## Submodules — enable only what you need

Message UI ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Message Notify UI** | `message_notify_ui` | Adds a "Send" form and a `notify` operation link on top of Message UI, so you can notify a message's recipients directly from the interface. Enable it if you use the Message Notify framework to deliver messages. |

Enable it with:

```bash
drush en message_notify_ui -y
```

It requires the base Message UI module, which is already present once you have
installed it above.
