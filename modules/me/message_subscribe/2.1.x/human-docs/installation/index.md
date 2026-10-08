# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Three contrib modules, pulled in automatically by Composer:
  - **Flag** (`drupal/flag` `^4.0 || ^5.0`) — subscriptions are Flag flaggings.
  - **Message** (`drupal/message` `^1.0`) — the message entities that get sent.
  - **Message Notify** (`drupal/message_notify` `^1.0`) — the delivery layer
    (email and other channels).
- A working mail setup if you want the default email notifications to actually go
  out.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/message_subscribe -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in the required **Flag**, **Message**, and **Message Notify** modules (and update
any shared dependencies) alongside Message Subscribe.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_subscribe -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies (Drush enables Flag, Message, and Message
Notify automatically as requirements):

```bash
drush en message_subscribe -y
```

### Submodules — enable what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Message Subscribe UI** | `message_subscribe_ui` | The user-facing subscriptions management interface **and** the *Administer message subscribe* permission that guards the settings form. Enable this if you want anyone other than user 1 to configure the module, or if you want end users to manage their subscriptions. |
| **Message Subscribe Email** | `message_subscribe_email` | Per-flag email preferences (an `email_*` flag layer and an extra "Email flag prefix" field on the settings form), so users can choose which subscriptions email them. |
| **Message Subscribe Example** | `message_subscribe_example` | A worked example implementation — useful as a reference, not for production. |

For example, to get the admin permission and user interface:

```bash
drush en message_subscribe_ui -y
```

## Next steps

Because the base module is an API, enabling it doesn't send anything yet. Head to
[Configuration](../configuration/index.md) to enable the `subscribe_*` flags,
review the settings form, and grant the admin permission. Actually *triggering*
notifications requires either the example submodule or your own code calling the
`message_subscribe.subscribers` service — see the sibling
[`agent/`](../agent/start.md) docs for the developer API.
