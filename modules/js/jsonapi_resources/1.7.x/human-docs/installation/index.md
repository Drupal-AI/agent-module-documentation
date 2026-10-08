# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **JSON:API** module (`jsonapi`) enabled — the only dependency. This
  module builds on core JSON:API and reuses its resource types.

There are no third-party Composer or PHP library requirements.

Optional: **JSON:API Extras** (`drupal/jsonapi_extras`) integrates as a
development-time dependency if you want to customize resource-type naming or
field aliases on the resource types you reuse.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_resources -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsonapi_resources -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_resources -y
```

## Verify it worked

There's nothing to see in the UI — enabling the module exposes no routes or
resources by itself. It's a framework you build on. Confirm it's enabled with
`drush pm:list --status=enabled | grep jsonapi_resources`, then define your first
resource class and route following [How to use
it](../index.md#how-to-use-it) and the sibling
[`agent/api/extend.md`](../agent/api/extend.md) reference.
