# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Options** module (`options`) — enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements. The content types you
want to share must be the kind that can be unpublished (they implement Drupal's
"publishable" behaviour) and have a canonical page — nodes qualify out of the box.

## Install with Composer

From the project root:

```bash
composer require drupal/access_unpublished -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/access_unpublished -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_unpublished -y
```

There are no submodules. Once enabled, a **Temporary unpublished access** section
appears on the edit form of unpublished content, and an **Access Tokens** list
appears under **Content**.

## Next steps

Before shared links work — especially for logged-out visitors — you must grant the
right "view via token" permission for the content types you're sharing. See
[Configuration](../configuration/index.md) for generating tokens, the permissions,
and the global settings.
