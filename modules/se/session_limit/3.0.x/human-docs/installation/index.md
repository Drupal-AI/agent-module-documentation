# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).

Session Limit has **no module dependencies** and no third-party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/session_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/session_limit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en session_limit -y
```

The module ships **no submodules**.

## Verify it worked

Log in as an administrator and go to **Configuration → People → Session limit**
(`/admin/config/people/session-limit`). You should see the settings form with a
maximum-sessions field. To test enforcement, set the maximum to 1, then log in as
an ordinary (non–User 1) account from two different browsers — the second login
should trigger the behavior you configured. Note that **User 1 and anonymous
users are never session-limited** unless you explicitly opt User 1 in.
