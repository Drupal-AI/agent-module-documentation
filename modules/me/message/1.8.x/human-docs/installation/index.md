# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Text** module (`text`) enabled — the template text uses formatted-text
  (text_format) values, so Text is required. Drupal enables it as a dependency
  automatically. You will also want the core **Token** infrastructure (part of
  core) for token replacement, and optionally the contrib **Token** module for a
  token browser when writing template text.

There are no third-party PHP library or Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message -y
```

After enabling, grant the relevant permissions (People → Permissions) to the roles
that need them:

| Permission | Grants |
|------------|--------|
| **Administer message templates** | Create, edit, and delete message templates, and manage their fields/display. |
| **Administer messages** | Manage the message content entities themselves. |
| **Overview messages** | Read-only access to the message overview. |

## The example submodule

Message ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Message Example** | `message_example` | Sample message templates that demonstrate how templates, tokens, partials, and rendering fit together. Useful for learning; not needed in production. |

```bash
drush en message_example -y
```

## What comes next

Message is a foundation for activity streams and notifications rather than a
finished feature. On its own it lets you define templates and have code create
messages. If you want messages emailed or pushed, or subscriptions managed, look
at companion modules such as **Message Notify** and **Message Subscribe**, which
build on this stack. To start defining templates, see
[Configuration](../configuration/index.md).
