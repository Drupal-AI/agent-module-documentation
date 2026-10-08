# Installation

## Requirements

- **Drupal 9.1 or 10** (`core_version_requirement: ^9.1 || ^10`).

Smart Content has no hard module dependencies of its own and needs no third-party
Composer packages or PHP libraries. In practice, though, you'll almost always want
the bundled **Smart Content Blocks** submodule (`smart_content_block`) so you have
somewhere to place your personalization, and **Smart Content Browser** for the
browser-based conditions.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_content -W
```

The Composer package name (`drupal/smart_content`) matches the module's machine
name (`smart_content`). The `-W` (`--with-all-dependencies`) flag lets Composer
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Smart Content together with the bundled block submodule so you can start
placing Decision Blocks straight away:

```bash
drush en smart_content smart_content_block -y
```

## Verify it worked

Log in as a user with the **administer smart content** permission and visit
**Structure → Smart Content** (`/admin/structure/smart-content`) — you should see
the segment-set management screen. Grant **administer smart content** to the roles
that will author personalization, then place a Decision Block to begin.
