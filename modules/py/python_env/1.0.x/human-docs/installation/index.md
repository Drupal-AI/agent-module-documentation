# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`). Depends on core **System**.
- **Python 3** installed on the server and reachable via the `python3` command.
- Symfony's Process component, which ships with Drupal core (nothing extra to
  install).

> **Security coverage:** this project is **not** covered by Drupal's security
> advisory policy. Because it executes code, only use it where you control the
> scripts directory — see the note on the [overview page](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/python_env -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/python_env -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en python_env -y
```

When you enable it, the module creates a `/python/` directory at the root of your
project (if it is not already there). Place your Python scripts in that directory.

## Confirm Python is available

The bridge shells out to `python3`, so make sure that command exists in the
environment your web server runs in:

```bash
python3 --version
```

With DDEV, check inside the container: `ddev exec python3 --version`. If Python 3 is
not present, install it (or add it to your DDEV web image) before using the bridge.

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep python_env`.
2. Confirm the `/python/` directory now exists at the project root.
3. Drop a small test script into `/python/` that reads its JSON argument and prints
   JSON, then call the `python_env.bridge` service from a bit of PHP (for example a
   Drush eval) and confirm you get the expected JSON back.
