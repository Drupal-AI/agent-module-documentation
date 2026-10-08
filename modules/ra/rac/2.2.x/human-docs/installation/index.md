# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- Core's **User** module (always present).
- The **Advanced Access (ADVA)** module (`adva`) — a required dependency that
  provides the grants framework RAC builds on. To apply role access to nodes you also
  need ADVA's node‑access consumer (part of the Advanced Access project); check the
  ADVA project page for which entity types are supported.

## Install with Composer

From the project root:

```bash
composer require drupal/rac -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Advanced Access and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rac -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rac -y
```

Drupal enables Advanced Access at the same time if it is not already on.

## Submodules

**RAC Relations** (`rac_relations`) extends the role‑access model to related
entities. Enable it only if you need that:

```bash
drush en rac_relations -y
```

## Verify it worked

Go to **Configuration → People → Advanced Access Settings**
(`/admin/config/people/adva`) — you should see **Role Access** available as an access
option there. That confirms RAC and ADVA are installed and talking to each other. Now
continue to [Configuration](../configuration/index.md) to set it up.
