# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2||^10||^11`).
- A working **outbound mail** setup on the site (this module manages email
  *definitions*; actual delivery still goes through your configured mail backend).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mail -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail -y
```

## Submodules

Mail ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mail Example** | `mail_example` | A worked example that defines mail message config entities and a group‑scoped admin list for editing them. Enable it to see how the system is meant to be used, or as a template for your own module's emails. |

```bash
drush en mail_example -y
```

## Permissions

The module provides its own permission gating who may edit the mail message
entities. Grant it at **People → Permissions** (`/admin/people/permissions`) to
the roles that should manage email content.

## Verify it worked

The clearest way to confirm the install is to enable **Mail Example** and open the
admin list it provides — you should see the example mail message entities and be
able to edit their subject and body. On a real site, the admin lists come from
whichever modules define emails against this system.
