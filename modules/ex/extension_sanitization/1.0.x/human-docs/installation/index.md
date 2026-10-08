# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no additional module dependencies and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/extension_sanitization -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extension_sanitization -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extension_sanitization -y
```

That's all it takes — there is no configuration. From now on, uploaded filenames
with duplicated extensions are collapsed automatically.

## Verify it worked

Upload a file whose name contains a duplicated extension — for example
`test.jpg.jpg` — through any file or image field. The stored filename should have
the duplicated extension removed. This confirms sanitization is active.

Remember this is one layer of defense: keep your file fields' allowed-extension
lists tight and serve uploads from a non-executing location as well.
