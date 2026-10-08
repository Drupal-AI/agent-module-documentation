# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Media** module enabled — this is the only dependency.

There are no third-party Composer or PHP library requirements.

One installation guard worth knowing: the module **blocks installation while the
old contributed Media Entity 1.x branch is still present**. That is intentional —
it is meant to take over from that legacy module, not run alongside it. Finish (or
remove) the old Media Entity before enabling this one.

## Install with Composer

Often this module is already in your codebase because it was pulled in by a Media
upgrade path. If it is not, add it from the project root:

```bash
composer require drupal/media_entity_generic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_entity_generic -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_generic -y
```

Drush enables core's Media module automatically if it is not already on. There are
no submodules.

## Verify it worked

Go to **Structure → Media types → Add media type** and open the **Media source**
drop-down. You should see **Generic media** listed as one of the options. Choosing
it and saving creates a media type backed by a plain text string.
