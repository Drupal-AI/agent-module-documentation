# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **User** module (`user`) — always present in a Drupal site; it's the only
  dependency.

There are no third‑party Composer or PHP library requirements.

> **Heads‑up:** this is a **release‑candidate** version. If your project's Composer
> `minimum-stability` is set to `stable`, you may need to allow `rc` releases for this
> package.

> **Conflict note:** Email Registration overlaps with the LoginToboggan module's
> email‑login feature. If LoginToboggan is enabled, the module warns you at install
> time — don't run both email‑login behaviors at once.

## Install with Composer

From the project root:

```bash
composer require drupal/email_registration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/email_registration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_registration -y
```

The moment it's enabled, the registration and login forms switch to email‑based
behavior — new accounts get an auto‑generated username. See
[Configuration](../configuration/index.md) for the one option and a welcome‑email tip.

## Submodule — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Email Registration (username)** | `email_registration_username` | Goes a step further and keeps the username fully in sync with the email address (using the full email as the username), plus a display‑name override. |

```bash
drush en email_registration_username -y
```

It requires the base Email Registration module, which is already present once you've
installed it above.
