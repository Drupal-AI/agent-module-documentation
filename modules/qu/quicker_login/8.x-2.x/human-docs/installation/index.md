# Installation

> **Development environments only.** Quicker Login lets anyone who can reach its
> paths log in as any user, so it must never be installed on a public or production
> site. Everything below assumes a local, sandbox, or CI environment.

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no other special requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/quicker_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Consider requiring it as a `--dev` dependency so it never
ships to production.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quicker_login -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quicker_login -y
```

## Verify it worked

Once enabled you will see a persistent warning on the site saying Quick Login is on.
Visit `/user/ql/admin` (or any existing username) and you should be logged in as that
account. When you are done, remove the module:

```bash
drush pmu quicker_login -y
composer remove drupal/quicker_login
```
