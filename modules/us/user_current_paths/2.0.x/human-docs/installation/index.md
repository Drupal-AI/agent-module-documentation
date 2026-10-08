# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always part of a standard Drupal
  install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/user_current_paths -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/user_current_paths -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en user_current_paths -y
```

That is all — there is nothing to configure. The UID‑neutral routes become active
immediately, and an **"Edit my account"** link is added to the account menu for
logged‑in users. The module ships no submodules.

## Verify it worked

Log in as any user and visit `/user/edit` — you should be redirected to your own
account edit form (`/user/{your-uid}/edit`). Try `/user/current` too; it should
take you to your profile page. You should also see an **"Edit my account"** item in
the account menu.
