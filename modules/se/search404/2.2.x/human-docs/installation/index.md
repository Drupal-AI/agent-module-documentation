# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A search backend for the results to come from. Out of the box that is core's
  **Search** module, so enable it (and configure a search page) unless you plan to
  point Search 404 at Search API or a View instead. Visitors also need the core
  *search content* permission for a search to actually run.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search404 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search404 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search404 -y
```

Enabling the module automatically sets your site's **404 (Page not found)** page to
Search 404's own handler, so it starts working right away.

## Permissions

Search 404 defines no permissions of its own; it uses core permissions:

- **Administer search** — needed to reach the Search 404 settings form. Grant it to
  whoever configures the 404 behaviour.
- **Access content** — needed by any visitor to reach the 404 results page (granted
  to everyone by default).
- **Search content** — needed for a search to actually run and return results.

For example:

```bash
drush role:perm:add editor 'administer search'
```

## Verify it worked

Visit any URL that does not exist on your site (for example
`/this-page-does-not-exist`). Instead of a bare "Page not found", you should see a
search results page built from the words in that URL. Fine‑tune the behaviour at
**Configuration → Search and metadata → Search 404 settings** — see
[Configuration](../configuration/index.md).
