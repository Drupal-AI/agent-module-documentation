# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- [Message recipient](https://www.drupal.org/project/message_recipient) — specifically
  its **`message_recipient_entity`** component (`message_recipient:message_recipient_entity`).
- The [Group](https://www.drupal.org/project/group) module — the source of the
  membership this module reads.

There are no external PHP library requirements. **Note:** this is an early alpha
release the maintainers say is not yet ready for production, and it is not covered by
Drupal's security advisory policy — evaluate it accordingly.

## Install with Composer

From the project root:

```bash
composer require drupal/message_recipient_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Message recipient and
update shared packages as needed. Install the [Group](https://www.drupal.org/project/group)
module too if it is not already present:

```bash
composer require drupal/group -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_recipient_group -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_recipient_group -y
```

Make sure the `message_recipient_entity` component and the `group` module are enabled;
Drupal enables declared dependencies automatically when they are present.

## Verify it worked

On a message template that uses Message recipient collectors, you should now be able
to add a **group** collector and select a Group. Confirm it resolves that Group's
members into the recipient list when a message is sent.
