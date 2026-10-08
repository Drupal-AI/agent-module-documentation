# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- Core's **Menu Link Content** module (`menu_link_content`), which Drupal enables as a
  dependency.
- No third-party Composer packages or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/single_page_site -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/single_page_site -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en single_page_site -y
```

## Optional submodule

Single Page Site ships one optional submodule. Enable it separately with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Next Page** | `single_page_site_next_page` | Appends a "scroll to next page" link to the bottom of each section on the assembled page. It works by altering the output through an event subscriber, and exposes an alter event so custom code can hook the same point. |

```bash
drush en single_page_site_next_page -y
```

## Next

Once enabled, configure which menu becomes your one-pager and tell the module about
your theme's menu wrapper — see [Configuration](../configuration/index.md). Then visit
`/single-page-site` to view the result.
