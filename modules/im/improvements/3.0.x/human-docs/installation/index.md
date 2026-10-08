# Installation

## Requirements

- **Drupal 10 through 15** (`core_version_requirement: ^10 || ^11 || ^12 || ^13 || ^14 || ^15`).
- The **Druhels** module (`druhels`) — the helper library this module builds on.
  Composer pulls it in for you.

There are no third‑party PHP library requirements. Note the module is **not covered
by Drupal's security advisory policy**, and the maintainer advises against
thoughtless use — enable it deliberately.

## Install with Composer

From the project root:

```bash
composer require drupal/improvements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Druhels.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/improvements -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en improvements -y
```

Drupal enables Druhels automatically if it is not already on.

## Verify it worked

The enhancements surface in context rather than on one page. After enabling, look
for the extra options this module adds in the tools it extends — for example new
field widget/formatter choices on a field's **Manage display**, or additional
plugins in the Views UI — to confirm it is active.
