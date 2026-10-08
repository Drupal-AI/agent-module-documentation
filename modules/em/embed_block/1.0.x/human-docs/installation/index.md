# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Filter** (`filter`) module, which provides the text-format and text
  filter system this module plugs into. It is enabled automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

> **Note on maturity:** the packaged release is `8.x-1.0-alpha4`. Test it before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/embed_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/embed_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en embed_block -y
```

## Switch the filter on for a text format

Enabling the module does nothing until you turn the filter on for a text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose the format you want (for example *Basic HTML* or *Full HTML*) and click
   **Configure**.
3. Under **Enabled filters**, tick **Embed Block**.
4. Save the format.

Repeat for each format where editors should be able to embed blocks. Be selective
— only give the filter to formats used by people you trust to embed blocks, since
any block plugin can be referenced.

There are no submodules.
