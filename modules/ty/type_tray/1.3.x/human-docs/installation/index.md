# Installation

## Requirements

Type Tray has no third-party libraries. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Node** module (`node`) — the tray reworks the node-add page.
- Core's **Filter** module (`filter`) — used to render the formatted extended
  descriptions.

Both dependencies are enabled automatically when you turn on Type Tray.

## Install with Composer

From the project root:

```bash
composer require drupal/type_tray -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/type_tray -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en type_tray -y
```

There are no submodules. As soon as it's enabled, Type Tray takes over the
`/node/add` page — but on a fresh install **no categories exist yet**, so your
content types will all appear in the fallback "Uncategorized" group until you set
things up. Head to [Configuration](../configuration/index.md) to define categories
and style each type.

## Grant the permission (optional)

Only users with the **Administer Type Tray** permission can open the settings form.
By default that's administrators. To grant it to another role:

```bash
drush role:perm:add site_admin 'administer type tray'
```

Note this permission only gates the settings form. The tray page itself uses core's
normal per-type "create" access.
