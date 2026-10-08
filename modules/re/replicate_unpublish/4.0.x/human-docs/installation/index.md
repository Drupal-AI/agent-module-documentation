# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Replicate** module (`replicate`) and **Replicate UI** module
  (`replicate_ui`) — both are hard dependencies. Replicate provides the cloning
  engine and the event this module listens to; Replicate UI provides the "Clone"
  action editors click.
- No third-party libraries and no PHP version constraint beyond your Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/replicate_unpublish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Replicate and
Replicate UI and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/replicate_unpublish -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en replicate_unpublish -y
```

This also enables Replicate and Replicate UI if they aren't on already. There is
no configuration step — the unpublish-on-clone behaviour is active immediately.

## Verify it worked

Clone any node with Replicate UI's **Clone** action. The new copy should be
created **unpublished**; open it and confirm its published checkbox is cleared
(and, on a multilingual site, that each translation is unpublished too).
