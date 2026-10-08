# Installation

## Requirements

Token is lightweight and has no third-party dependencies. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no other module dependencies, no PHP library requirements, and no
Composer requirements beyond core itself.

## Install with Composer

From the project root:

```bash
composer require drupal/token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/token -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en token -y
```

That is all it takes. Token has no required configuration and no settings form —
once enabled, the token browser and the extra tokens are available immediately
inside other modules' forms.

## Verify it worked

Go to a form that uses tokens — for example a Pathauto pattern at
**Configuration → Search and metadata → URL aliases → Patterns**, or simply visit
`/token/tree`. You should see the **"Browse available tokens"** tree listing the
tokens available on your site.
