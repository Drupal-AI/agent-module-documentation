# Installation

## Requirements

Invite is lightweight and has no third‑party library requirements:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No mandatory dependencies beyond Drupal core. The base module gives you the
  invitation framework; you add a *sending method* with one of the submodules
  below.

## Install with Composer

From the project root:

```bash
composer require drupal/invite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/invite -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en invite -y
```

## Submodules — pick a sending method

The base module tracks invitations but does not, on its own, send them. Enable at
least one of these delivery submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Invite by Email** | `invite_by_email` | Lets users send an invitation to an email address. Good for direct, personal invitations. |
| **Invite Link** | `invite_link` | Generates a shareable invite link a user can pass along however they like (chat, social, etc.). |

Enable whichever you need, for example:

```bash
drush en invite_by_email -y
```

Both require the base Invite module, which is already present once you have
installed it above.

## Verify it worked

Log in as an administrator and visit the permissions page
(`/admin/people/permissions`). You should see the Invite permissions listed —
grant the "send invitations" permission to the roles that should be allowed to
invite others. Then, as a user with that permission, look for the invite form or
link provided by the submodule you enabled. See
[Configuration](../configuration/index.md) to tune the invite behavior first.
