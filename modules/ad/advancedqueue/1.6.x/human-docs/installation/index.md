# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other contributed module dependencies and no third‑party PHP libraries — the
  database storage backend uses Drupal's own database layer.

The per‑queue **job listing** screen is built with core's **Views** module (which
is enabled by default on a standard install). If Views is off, the queues and jobs
still work, but the admin job list will not render.

## Install with Composer

From the project root:

```bash
composer require drupal/advancedqueue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advancedqueue -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advancedqueue -y
```

Advanced Queue has **no submodules**. Enabling it installs one ready‑made queue
called `default` and creates the `advancedqueue` database table used by the
database backend.

## Grant the permission

All queue and job administration is behind one permission, **Administer queues**
(`administer advancedqueue`). Grant it to the roles that should manage queues —
it is marked *restricted* because it is security‑sensitive:

```bash
drush role:perm:add content_editor 'administer advancedqueue'
```

## Verify it worked

Log in as a user with *Administer queues* and go to **Configuration → System →
Queues** (`/admin/config/system/queues`). You should see the shipped **Default**
queue listed. From here you can add new queues and open each queue's job list.

Next, head to [Configuration](../configuration/index.md) to create and tune your
own queues.
