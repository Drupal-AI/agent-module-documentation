# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements. (For the typical REST use case you will also want core **REST**
  and, conveniently, the contrib **REST UI** module — but those are for what you
  do *with* it, not to install it.)

Note the release documented here is `2.x-dev`, and the module is minimally
maintained.

## Install with Composer

From the project root:

```bash
composer require drupal/null_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/null_auth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module — in a non‑production environment

```bash
drush en null_auth -y
```

> **Reminder:** enable this only in **development or testing** environments with
> controlled access. It applies no flood control and auto‑authenticates any
> request using `?_null_auth=1` as anonymous, so it does not belong on a live
> public site. There is nothing to configure after enabling — the null
> authentication method is active automatically.

## Verify it worked

While logged in as an administrator, request a page with `?_null_auth=1` appended
and confirm it renders **as anonymous** (for example, personalised or
authenticated‑only elements disappear). For the REST use case, enable a REST
resource with the **null** authentication provider, grant the resource's
permission to anonymous, and confirm a request carrying `_null_auth=1` is handled
as anonymous.
