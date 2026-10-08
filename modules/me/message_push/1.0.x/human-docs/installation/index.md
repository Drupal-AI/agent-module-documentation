# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The [Message](https://www.drupal.org/project/message) module (`message`).
- The [Push Framework](https://www.drupal.org/project/push_framework) module
  (`push_framework`).
- The [Flag](https://www.drupal.org/project/flag) module (`flag`) — used to let users
  subscribe to entities.

Message, Flag and Push Framework are **not** installed automatically with this
module — that is deliberate, so you control which versions you run. The module will
not break without them; it simply will not be useful until they are present. There are
no external PHP library requirements.

## Install with Composer

From the project root, require Message Push together with its companions:

```bash
composer require drupal/message_push drupal/message drupal/flag drupal/push_framework -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_push -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_push message flag push_framework -y
```

## Verify it worked

Visit **`/admin/config/people/subscription-type`** as a user with the **Administer
subscription type** permission. If the subscription types listing loads, the module
is installed. Nothing is delivered yet — continue to
[Configuration](../configuration/index.md) to define a subscription type. Remember
Message Push does not create messages itself; you still need custom code or ECA to
generate them.
