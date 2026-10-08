# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No module dependencies, and no third‑party Composer packages or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/dismiss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dismiss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dismiss -y
```

That is all that is required. The close button appears on Drupal messages
immediately — there is no mandatory configuration.

## Verify it worked

Do something that produces a Drupal message — for example, save any configuration
form so the "The configuration options have been saved" status message appears. You
should now see a small close (✕) control on the message; click it and the message
disappears without reloading the page.
