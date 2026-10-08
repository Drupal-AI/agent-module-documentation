# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No modules outside of Drupal core are required.
- **Recommended:** the [YAML Editor](https://www.drupal.org/project/yaml_editor)
  module, which makes editing the module's YAML configuration in the admin form much
  more pleasant.

## Install with Composer

From the project root:

```bash
composer require drupal/http_headers_cleaner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_headers_cleaner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_headers_cleaner -y
```

Optionally enable the recommended YAML editor for a nicer configuration experience:

```bash
drush en yaml_editor -y
```

## Verify it worked

Log in as an administrator and open **Configuration → System → HTTP-Headers cleaner
settings**. After you add a removal rule (see [Configuration](../configuration/index.md)),
load any page and check the response headers in your browser's developer tools
(Network tab → Response Headers) — the header you targeted (for example
`X-Generator`) should no longer be present.
