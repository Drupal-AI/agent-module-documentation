# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** module (`node`) — the `published_at` field is attached to nodes,
  so Node must be enabled (it is on any standard content site). Drupal enables it
  as a dependency automatically.

There are no third-party PHP library or Composer requirements. The module has
optional, automatic integrations with Feeds, Workbench Moderation, Node Clone, and
Scheduler if those modules are present, but it does not depend on any of them.

> **Database note:** on install the module back-fills the publication date of
> existing nodes by reading each node's first published revision. This automatic
> back-fill is supported on **MySQL/MariaDB and PostgreSQL only**; on other
> databases it is skipped with a warning (new nodes are still stamped correctly).

## Install with Composer

From the project root:

```bash
composer require drupal/publication_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/publication_date -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en publication_date -y
```

The module ships no submodules and no settings form. Once enabled, the
`published_at` field exists on every node automatically — there is nothing to add
via Field UI. Next, grant the relevant "published on date" permissions to the
roles that should edit or view the date, and enable the field on your view
displays as needed. See [the index page](../index.md#how-to-use-it) for the
details.
