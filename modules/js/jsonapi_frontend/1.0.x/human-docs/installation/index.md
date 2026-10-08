# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **JSON:API** (`jsonapi`) module.
- Core's **Path Alias** (`path_alias`) module — used to resolve aliases.

Both are enabled automatically as dependencies. There are no third‑party Composer
packages or external libraries to install.

> **Not covered by the security advisory policy.** This project isn't tracked
> through Drupal's official security process — worth weighing before using it on
> a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_frontend -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_frontend -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_frontend -y
```

This also enables core JSON:API and Path Alias if they aren't already on.

## Configure before you rely on the routes feed

The resolver endpoint works immediately, but the **routes feed stays closed until
you set a secret** for it. Head to [Configuration](../configuration/index.md) to
set that secret and review the endpoint settings before pointing a front end at
the feed.

## Verify it worked

Request the resolver for a known path, for example
`/jsonapi/resolve?path=/about-us&_format=json`. You should get back the matching
entity and its JSON:API URL. Try a restricted or unpublished path too and confirm
it resolves as "not found" — that's the access check doing its job.
