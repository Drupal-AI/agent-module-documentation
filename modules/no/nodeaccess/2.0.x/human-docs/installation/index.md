# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Node** module enabled — the only dependency, and it is on by default on
  a standard site.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/nodeaccess -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nodeaccess -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nodeaccess -y
```

There are no submodules. When you enable it, Nodeaccess seeds a default-grants
entry for each existing content type, and it keeps these entries in sync
automatically as you add content types or roles later.

## Grant the permissions

Out of the box nobody can reach the settings form or the per-node Grants tab. Assign
the module's permissions at **People → Permissions**
(`/admin/people/permissions`) — see [Configuration](../configuration/index.md) for
what each one does. For example:

```bash
# Let a role manage grants on Article nodes only:
drush role:perm:add page_editor 'nodeaccess grant article permissions'
# Or on every node:
drush role:perm:add trusted 'grant node permissions'
```

## Verify it worked

Visit **Configuration → People → Nodeaccess**
(`/admin/config/people/nodeaccess`) as an administrator. You should see the
per-content-type grant settings. See [Configuration](../configuration/index.md) to
set defaults and turn on the Grants tab.
