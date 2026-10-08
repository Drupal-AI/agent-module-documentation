# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [Message](https://www.drupal.org/project/message) module (`message`).
- The [Dynamic Entity Reference](https://www.drupal.org/project/dynamic_entity_reference)
  module (`dynamic_entity_reference`) — this provides the reference-field type used to
  link a message to any entity.

There are no external PHP library requirements. This project is not covered by
Drupal's security advisory policy, so review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/message_associated_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Message and
Dynamic Entity Reference dependencies and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_associated_entity -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_associated_entity -y
```

Drupal enables the `message` and `dynamic_entity_reference` dependencies
automatically if they are present.

## Verify it worked

After enabling, the dynamic entity reference is available on Message entities. There
is nothing further to configure — populate the association from your message-creation
code or workflow as described in the main guide's "How to use it".
