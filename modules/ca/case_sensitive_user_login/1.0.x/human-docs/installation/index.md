# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), which is always enabled on a Drupal site.

There are no third‑party Composer or PHP library requirements.

For the case-sensitive check to have any effect, your site's **database
collation must be case-sensitive**. Under a case-insensitive collation (the
common MySQL default) the module installs cleanly but the extra check is a
no-op.

## Install with Composer

From the project root:

```bash
composer require drupal/case_sensitive_user_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/case_sensitive_user_login -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en case_sensitive_user_login -y
```

That's all it takes. Case-exact login validation is active immediately.

## Verify it worked

Try logging in with a deliberately mis-cased version of a real username (for
example `Admin` when the account is `admin`). With a case-sensitive database
collation the attempt is rejected; the correctly-cased username still works. If
the mis-cased login succeeds, your database collation is case-insensitive and the
module cannot enforce the check.
