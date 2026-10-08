# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Poll** (`poll`) and **REST** (`rest`) modules — both enabled.
- The optional **REST UI** (`restui`) module is recommended so you can enable and
  configure the REST resource through the admin UI rather than by editing
  configuration directly.

Note this module is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/poll_rest -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you want the admin UI for REST resources, also install
REST UI:

```bash
composer require drupal/restui -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/poll_rest -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Poll, REST and Poll Rest (and REST UI if you installed it):

```bash
drush en poll rest poll_rest restui -y
```

## Post-installation: turn on the REST resource

1. Go to **`/admin/config/services/rest`**.
2. Enable the **poll vote** resource.
3. Enable the **GET**, **POST** and **DELETE** methods, and configure the formats,
   authentication and permissions you need.

## Verify it worked

Create a poll (core Poll), then call the endpoint — for example
`GET /api/v1/poll/1?query=choices` — and confirm you get back a JSON response with
the poll's question and choices. Casting a vote with
`POST /api/v1/poll/1/vote` (body `{"chid":"1"}`) should return `{"error": false}`.
