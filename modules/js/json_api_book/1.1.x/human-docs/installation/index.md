# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **JSON:API** module (`jsonapi`) — this is a hard dependency, and Drupal
  will enable it automatically when you turn on JSON:API Book.
- Core's **Book** module (`book`), enabled, with content organized into books —
  otherwise there is no book structure to expose.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/json_api_book -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/json_api_book -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_api_book -y
```

If core's JSON:API and Book modules aren't already on, enable them too:

```bash
drush en jsonapi book -y
```

## Verify it worked

Request a node that belongs to a book through JSON:API (for example
`/jsonapi/node/page/{uuid}`) and inspect the JSON response — it should now include
the book structure for that node alongside its regular fields.
