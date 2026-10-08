# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/me_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/me_redirect -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en me_redirect -y
```

That's all — there is no configuration step. The `/me` paths are active immediately.

## Verify it worked

Log in as any user and visit **`/me`** — you should be redirected (via a 302) to that user's
own profile page at `/user/UID`. Try `/me/edit` too; it should land on the account edit
form. As an anonymous visitor, `/me` should send you to log in.
