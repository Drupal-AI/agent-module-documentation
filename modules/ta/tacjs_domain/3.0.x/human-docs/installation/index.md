# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Domain** module (`domain`) — the multi-domain framework this module scopes
  configuration against. The 3.x branch requires **Domain 3+**.
- The **TacJS** module (`tacjs`) — the tarteaucitron.js consent manager that does
  the actual gating. The 3.x branch requires **TacJS 7+**.

There are no PHP library or extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tacjs_domain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Domain and
TacJS dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tacjs_domain -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tacjs_domain -y
```

This also enables the Domain and TacJS dependencies if they are not already on.

## Verify it worked

With Domain and TacJS configured, confirm you can now vary the active TacJS
consent services per domain. Remember that in the 3.x line this module is only
needed if you want the aggregation of JavaScript from active tarteaucitron
services — if you do not need that feature, you may not need this module at all.
