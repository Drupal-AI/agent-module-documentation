# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- If you choose Yandex as the provider and it requires an API key, you will need
  that key from Yandex — store it as a secret, not in committed configuration.
- No dependent Drupal modules, PHP extensions, or external Composer libraries are
  listed as required.

## Install with Composer

From the project root:

```bash
composer require drupal/synmap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/synmap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synmap -y
```

## Verify it worked

After enabling, open the SynMap settings form (route `synmap.settings`), pick a map
provider and set the location, then place the map block via
**Structure → Block layout**. Load a page that shows the block and confirm the map
renders at your chosen location.
