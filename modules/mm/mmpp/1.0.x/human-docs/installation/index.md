# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **User** module (`user`) — always present in a standard Drupal install.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mmpp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mmpp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mmpp -y
```

Enabling MMPP adds the "private" base field to user accounts and registers its
entity access handler immediately. Remember that profiles default to **private**,
so users must opt in to a public profile.

## Verify it worked

1. Confirm the roles that should see public profiles hold the core **View user
   information** permission at **People → Permissions**.
2. Edit a test user (`/user/{user}/edit`) — you should see the new public/private
   toggle on the form.
3. Leave a profile private and view its `/user/{user}` page as another
   (non-admin) user: you should get access-denied. Tick the toggle to make it
   public and confirm the profile becomes visible to permitted roles.
