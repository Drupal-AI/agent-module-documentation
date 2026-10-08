# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Path** module (`path`) — the only dependency; Drupal enables it
  automatically.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/url_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/url_redirect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en url_redirect -y
```

## Grant the permissions

The module defines three permissions, all of which gate the admin screens (they do
**not** affect whether a redirect fires — redirects run for any matching visitor):

| Permission | Grants access to |
|---|---|
| `access url redirect settings page` | The rules list and the Add form |
| `access url redirect edit page` | The Edit form |
| `access url redirect delete page` | The Delete form |

Grant them to the roles that should manage redirects, for example:

```bash
drush role:perm:add editor 'access url redirect settings page'
```

Next, create your redirect rules — see [Configuration](../configuration/index.md).
