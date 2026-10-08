# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **CodeMirror Editor** module (`codemirror_editor`) — this is a hard
  dependency and provides the code editor shown on the Manage Display form.
  Composer pulls it in automatically with the `-W` flag below.

There are no PHP extension or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_display_template -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install CodeMirror
Editor and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_display_template -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_display_template -y
```

This also enables `codemirror_editor` if it is not already on.

## Verify it worked

Go to **Structure → (any entity type) → Manage display**, choose a view mode,
and scroll down. You should see a new **Display Template options** section with
an *Enabled* checkbox and a Twig code editor. If it is there, you are ready to
head to [Configuration](../configuration/index.md).
