# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **JSON:API** (`jsonapi`) module — enabled automatically as a dependency.

There are no third‑party Composer packages or external libraries to install. The
module is compatible with, but does not require,
[JSON:API Extras](https://www.drupal.org/project/jsonapi_extras) — if you use
Extras, this module respects its base path and disabled relationships.

> **Not covered by the security advisory policy.** This project isn't tracked
> through Drupal's official security process — worth weighing before using it on
> a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_auto_include -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_auto_include -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_auto_include -y
```

That's all — there is no configuration step.

## Verify it worked

Make a JSON:API request with the flag, for example
`/jsonapi/node/article?jsonapi_auto_include=1`, and compare the response to the
same request without it. With the flag on, the response should carry an `included`
section populated with the resource type's relationships. (Remember it only
includes related resources the caller is actually allowed to see.)
