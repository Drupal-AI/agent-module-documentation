# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`) — the context resolves to a group.
- The **Domain** module — the module assigns a group to each domain record, so a
  working Domain setup is expected on the multi‑tenant sites this targets.

## Install with Composer

From the project root:

```bash
composer require drupal/group_context_domain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_context_domain -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_context_domain -y
```

## Grant the permission

Grant the **set domain group** permission at **People → Permissions**
(`/admin/people/permissions`) to the roles that should be able to assign a group to
a domain.

## Verify it worked

Edit a domain record and confirm you can assign it a group. Then place a block with
a **Group** context condition and confirm it resolves the correct group when you
browse that domain — including on pages that are not group routes.
