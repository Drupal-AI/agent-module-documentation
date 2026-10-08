# Installation

## Requirements

- **Drupal 10.5.8+ or 11.2.8+** (`core_version_requirement:
  ^10.5.8 || ^11.2.8`). This is a deliberately narrow constraint — the module
  relies on recent core behaviour, so older point releases are not supported.
- **PHP 8.1.6 or newer**.
- Core's **User** module (`user`), always present in a Drupal install.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/view_usernames -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/view_usernames -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en view_usernames -y
```

## Grant the permission

The moment the module is enabled the new, stricter default is active: only the
account owner, administrators, and anonymous labels are shown; everyone else
sees a placeholder. Decide which roles should see usernames and grant them the
**View usernames** permission:

- In the UI: **People → Permissions** (`/admin/people/permissions`), find
  **View usernames**, tick the roles, and save.
- Or from the command line:

  ```bash
  drush role:perm:add editor 'view usernames'
  ```

> **Important:** do not grant **View usernames** to *anonymous* or to *all
> authenticated users* — that re-opens the username exposure the module is meant
> to prevent, particularly if JSON:API is enabled.

After granting it, review your public-facing displays (author bylines,
comments, Views, JSON:API responses) to confirm the new behaviour is what you
expect.
