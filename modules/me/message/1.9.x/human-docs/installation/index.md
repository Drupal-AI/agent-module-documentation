# Installation

## Requirements

- **Drupal 9.2, 10, 11, or 12** (`core_version_requirement: ^9.2 || ^10 || ^11 || ^12`).
- Core's **Text** module (`text`), enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/message -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Message Example** | `message_example` | Sample message templates that demonstrate how the module works — handy for learning or as a starting point. Enable it on a development site to explore; you generally don't need it in production. |

```bash
drush en message_example -y
```

## The wider message stack

Message itself only logs and displays events. To actually notify people or let them
subscribe, add the companion modules as needed:

- **Message Notify** (`drupal/message_notify`) — forward messages when generated.
- **Message Subscribe** (`drupal/message_subscribe`) — user subscriptions.
- **Message Digest** (`drupal/message_digest`) — aggregated digests.
- **Message UI** (`drupal/message_ui`) — a UI for creating/editing message content.

## Verify it worked

Log in as an administrator. You should find **Structure → Messages**
(`/admin/structure/message`) for templates and **Configuration → Message**
(`/admin/config/message`) for settings. If you enabled Message Example, its sample
templates will appear in the template list. See
[Configuration](../configuration/index.md) to create your first template.
