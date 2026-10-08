# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **No module dependencies** — Post API is self‑contained.
- A custom module of your own that will actually build payloads and feed the queue (Post API is
  a framework; it does nothing until your code uses it).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/post_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/post_api -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en post_api -y
```

## Verify it worked

1. Visit **`/admin/config/post-api/queue`** — you should see the Post API queue management UI.
2. From your own module, add an item with the `post_api.add_to_queue` service (see the
   [manual setup guide](../index.md)), run cron (or process the queue manually), and confirm the
   POST reaches your endpoint.
