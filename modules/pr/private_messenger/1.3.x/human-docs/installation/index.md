# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Text** module (`text`) — the only dependency, enabled automatically as
  needed.

No modules outside Drupal core are required. The module pairs well with UX helpers
such as *Better Messages* if you want nicer message presentation, but that's
optional.

## Install with Composer

From the project root:

```bash
composer require drupal/private_messenger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/private_messenger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en private_messenger -y
```

## Grant the admin permission

At **People → Permissions**, grant **Access private messenger message overview**
to the administrator/staff role that should create and manage login messages. All
of the module's screens require it.

## Verify it worked

1. Go to `/admin/content/private-messenger-message` and create a message of type
   *warning* aimed at a test user.
2. Log in as that test user. The warning should appear via Drupal's messenger,
   and the stored message should then be gone (it's deleted after display) — so
   it won't reappear on the following login.
