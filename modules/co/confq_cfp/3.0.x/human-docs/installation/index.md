# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **User** module (`user`) — enabled on any standard site.
- The **Webform** contrib module (`webform:webform`) — the form engine ConfQ CFP
  is built on. Composer pulls it in automatically with the command below.
- No third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/confq_cfp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/confq_cfp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en confq_cfp -y
```

This enables ConfQ CFP and, if it is not already on, the Webform module.

## Verify it worked

Go to **Structure → Webforms** (`/admin/structure/webform`) and confirm the
call‑for‑papers webform is present, and check that a **track chair** role now
appears under **People → Roles**. From there, follow "How to use it" in the
[overview](../index.md) to tailor the form and assign reviewers.
