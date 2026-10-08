# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Comment** module (`comment`) enabled.
- The contributed **Token** module (`drupal/token` `^1.6`) — used for the tokens
  in the email templates. Composer installs it for you.
- A working outbound mail setup on the site (core's default mail system is fine),
  since the whole point of the module is sending email.

## Install with Composer

From the project root:

```bash
composer require drupal/comment_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/comment_notify -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_notify -y
```

Token is enabled automatically as a dependency.

## Set permissions

At **People → Permissions** (`/admin/people/permissions`) grant:

- **Administer comment notify** — to administrators who should manage the settings
  page and global email templates.
- **Subscribe to comments** — to any role that should see the *"Notify me when new
  comments are posted"* checkbox. Include the **Anonymous user** role here if you
  want visitors to be able to subscribe with their email address.

Once installed, head to [Configuration](../configuration/index.md) to choose which
comment fields are enabled and to tune the subscription modes, defaults, and email
templates.
