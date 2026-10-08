# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Node** module (`node`) — the only dependency, and enabled by default on
  most sites.

There are no additional PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/samples -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/samples -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en samples -y
```

## Configure permissions

Go to **People → Permissions** and grant the sample‑content permissions the module
provides to the appropriate roles. In particular, decide which roles may **view**
sample content — that permission is what keeps samples visible to your intended
audience and hidden from everyone else.

## Rebuild node access permissions

This step is required. Because Sample Content uses Drupal's node access grants
system, the restriction only takes effect once node access permissions have been
rebuilt. Go to the **Status report** page at **`/admin/reports/status`** and
rebuild permissions when prompted, or run:

```bash
drush php:eval "node_access_rebuild();"
```

On sites with very large numbers of nodes this rebuild can take a while. You will
also need to rebuild again whenever the grants change.

## Verify it worked

Create a piece of sample content, then view the site as an anonymous or
unprivileged user — the sample should not appear, including in Views listings,
search results and JSON:API/REST output. Viewed as a user with the view‑samples
permission, it should be visible.
