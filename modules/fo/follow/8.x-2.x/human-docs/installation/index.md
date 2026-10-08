# Installation

## Requirements

Follow needs:

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).

There are no module dependencies and no third-party PHP library requirements.

> **Recommended companion:** a module such as *External Links* (`extlink`), so
> follow links open in a new tab/window — Follow deliberately does not add
> `target="_blank"` because it does not validate.

## Install with Composer

From the project root:

```bash
composer require drupal/follow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/follow -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en follow -y
```

## Verify it worked

1. Go to **Configuration → People → Follow** (`/admin/config/people/follow`) — you
   should see the sitewide follow settings form.
2. Add one link (for example your Twitter/X profile) and save.
3. Place the **Follow Site** block at **Structure → Block layout** and view a page
   — the link should appear with its icon.

Next, see [Configuration](../configuration/index.md) to set permissions, place the
per-user block, and let members add their own links.
