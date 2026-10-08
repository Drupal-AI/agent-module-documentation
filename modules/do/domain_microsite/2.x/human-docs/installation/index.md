# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Domain** module (`domain`).
- At least one **regular domain record** must already exist before you create a
  microsite — a microsite needs a parent domain to sit under. If you have none,
  create a normal domain first.

There are no third-party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_microsite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_microsite -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_microsite -y
```

This also enables the `domain` module if it is not already on.

## Verify it worked

Go to **Configuration → Domain** (`/admin/config/domain`) and add or edit a domain
record. You should see a new **Make domain microsite** checkbox, along with
*Parent domain* and *Base path* fields. See
[Configuration](../configuration/index.md) for how to fill them in.
