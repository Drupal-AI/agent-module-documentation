# Installation

## Requirements

- **Drupal 11 or newer** (`core_version_requirement: ^11`).
- The **Flag** module, version **5.x** (`flag`) — required. OGCB Likes builds
  directly on Flag and its `like_node` flag.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ogcb_likes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will pull in Flag if it isn't present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ogcb_likes -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ogcb_likes -y
```

Enabling it also enables Flag if needed, and **creates the `like_node` flag
automatically**.

## Verify it worked

Go to **Structure → Flags** and confirm a `like_node` flag is present. Configure the
content types it applies to, grant the `like_node` permission, then place an **OGCB
Likes** block and confirm it shows the summary of likers on a piece of liked
content. Full setup is in the [guide overview](../index.md).
