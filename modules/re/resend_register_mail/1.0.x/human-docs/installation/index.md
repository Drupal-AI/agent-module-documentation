# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **User** module (always enabled on a Drupal site).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/resend_register_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/resend_register_mail -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en resend_register_mail -y
```

Then, at **People → Permissions**, grant the **Resend account emails** permission to
the trusted administrators who should be able to use the action. It is a restricted
permission and is not granted by default.

## Verify it worked

Go to **People** (`/admin/people`), tick a user, and open the **Action** dropdown.
You should see the option to resend the registration / welcome email. See the "How
to use it" section of the [overview](../index.md) for the full walkthrough.
